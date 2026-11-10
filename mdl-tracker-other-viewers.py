#!/usr/bin/env python3
"""View and add people to the 'Other viewers' custom field of a Jira issue.

Credentials come from ~/.netrc (shared with git-backport):

    machine moodle.atlassian.net login EMAIL password API_TOKEN

JIRA_EMAIL / JIRA_API_TOKEN env vars override it; JIRA_URL overrides the site
(default https://moodle.atlassian.net).

Usage:
    other_viewers.py show CONTRIB-10666
    other_viewers.py add CONTRIB-10666 "Jane Doe" jane@example.com
    other_viewers.py remove CONTRIB-10666 "Jane Doe"
"""
import argparse
import base64
import json
import netrc
import os
import sys
import urllib.error
import urllib.parse
import urllib.request

FIELD_NAME = "Other viewers"


class Jira:
    def __init__(self, base_url, email, token):
        self.base = base_url.rstrip("/")
        auth = base64.b64encode(f"{email}:{token}".encode()).decode()
        self.headers = {
            "Authorization": f"Basic {auth}",
            "Accept": "application/json",
            "Content-Type": "application/json",
        }

    def request(self, method, path, params=None, body=None):
        url = f"{self.base}/rest/api/3{path}"
        if params:
            url += "?" + urllib.parse.urlencode(params)
        data = json.dumps(body).encode() if body is not None else None
        req = urllib.request.Request(url, data=data, headers=self.headers, method=method)
        try:
            with urllib.request.urlopen(req) as resp:
                raw = resp.read()
        except urllib.error.HTTPError as e:
            detail = e.read().decode(errors="replace")
            sys.exit(f"Jira API error {e.code} on {method} {path}: {detail}")
        return json.loads(raw) if raw else None

    def field_id(self, name=FIELD_NAME):
        matches = [f for f in self.request("GET", "/field") if f["name"].lower() == name.lower()]
        if not matches:
            sys.exit(f"Custom field '{name}' not found (or not visible to you).")
        if len(matches) > 1:
            ids = ", ".join(f["id"] for f in matches)
            sys.exit(f"Multiple fields named '{name}': {ids}. Set JIRA_FIELD_ID to choose one.")
        return matches[0]["id"]

    def find_user(self, query, issue):
        # /user/search is empty on this site, so also try the issue-scoped assignable search.
        found = {}
        for path, params in (("/user/search", {"query": query}),
                             ("/user/assignable/search", {"query": query, "issueKey": issue})):
            for u in self.request("GET", path, params):
                if u.get("accountType") == "atlassian" and u.get("active", True):
                    found[u["accountId"]] = u
        users = list(found.values())
        if not users:
            sys.exit(f"No active user found for '{query}'.")
        exact = [u for u in users
                 if query.lower() in (u["displayName"].lower(), (u.get("emailAddress") or "").lower())]
        if len(exact) == 1:
            return exact[0]
        if len(users) == 1:
            return users[0]
        options = "\n".join(f"  {u['displayName']} <{u.get('emailAddress', 'hidden')}>" for u in users)
        sys.exit(f"'{query}' is ambiguous, matches:\n{options}")


def current_users(jira, issue, fid):
    data = jira.request("GET", f"/issue/{issue}", {"fields": fid})
    value = data["fields"].get(fid)
    if value is None:
        return []
    if not isinstance(value, list):
        sys.exit(f"Field {fid} is not a multi-user field (got {type(value).__name__}); can't edit it.")
    return value


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = p.add_subparsers(dest="cmd", required=True)
    sub.add_parser("show").add_argument("issue")
    for name in ("add", "remove"):
        s = sub.add_parser(name)
        s.add_argument("issue")
        s.add_argument("people", nargs="+", help="display name or email")
    if len(sys.argv) == 1:
        p.print_help()
        return
    args = p.parse_args()

    url = os.environ.get("JIRA_URL", "https://moodle.atlassian.net")
    email, token = os.environ.get("JIRA_EMAIL"), os.environ.get("JIRA_API_TOKEN")
    if not (email and token):
        host = urllib.parse.urlparse(url).hostname
        try:
            auth = netrc.netrc().authenticators(host)
        except (OSError, netrc.NetrcParseError) as e:
            sys.exit(f"Can't read ~/.netrc: {e}")
        if not auth:
            sys.exit(f"No credentials: add 'machine {host} login EMAIL password API_TOKEN' to ~/.netrc")
        email, _, token = auth
    jira = Jira(url, email, token)

    fid = os.environ.get("JIRA_FIELD_ID") or jira.field_id()
    users = current_users(jira, args.issue, fid)

    if args.cmd != "show":
        ids = [u["accountId"] for u in users]
        for person in args.people:
            u = jira.find_user(person, args.issue)
            if args.cmd == "add" and u["accountId"] not in ids:
                ids.append(u["accountId"])
                print(f"Adding {u['displayName']}")
            elif args.cmd == "remove" and u["accountId"] in ids:
                ids.remove(u["accountId"])
                print(f"Removing {u['displayName']}")
        jira.request("PUT", f"/issue/{args.issue}", body={"fields": {fid: [{"accountId": i} for i in ids]}})
        users = current_users(jira, args.issue, fid)

    print(f"{FIELD_NAME} on {args.issue} ({fid}):")
    for u in users or []:
        print(f"  {u['displayName']}")
    if not users:
        print("  (none)")


if __name__ == "__main__":
    main()
