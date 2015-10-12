<?php
define('CLI_SCRIPT', true);

$last = $argv[count($argv) - 1];
if ($last && is_dir($last) ) {
    $dirroot = array_pop($argv).'/';
    array_pop($_SERVER['argv']);
}

require($dirroot.'config.php');
require_once($CFG->libdir.'/clilib.php');
list($options, $unrecognized) = cli_get_params(
    array(
        'help' => false,
        'search' => '',
    ),
    array(
        'h'   => 'help',
        's'   => 'search',
    )
);

if ($unrecognized) {
    $unrecognized = implode("\n  ", $unrecognized);
    cli_error(get_string('cliunknowoption', 'admin', $unrecognized));
}

    $help = "Search the DB for any string

db_grep.php [options]

Options:
-h, --help          Print out this help
-s  --search        A string to search for

Example:
\$sudo -u www-data php db_grep.php -s 'somestring' /var/www/moodle
";
if ($options['help']) {
    print $help;
    die;
}
if (!$options['search']) {
    print $help;
    die;
}

/*
 * SUPER hacky! :)
 */
function db_grep($search) {
    global $DB, $CFG, $OUTPUT;

    // Turn off time limits, sometimes upgrades can be slow.
    core_php_time_limit::raise();

    if (!$tables = $DB->get_tables() ) {    // No tables yet at all.
        return false;
    }
    foreach ($tables as $table) {

        if ($columns = $DB->get_columns($table)) {
            foreach ($columns as $column) {
                $tab = '{' . $table . '}';
                $colname = $column->name;
                try {
                    $sql = "SELECT * FROM $tab WHERE $colname like '%$search%'\n";
                    // echo $sql;
                    $results = $DB->get_records_sql($sql);
                    if ($results) {
                        echo "FOUND " . count($results) . " results in table " . strtoupper($CFG->prefix . $table) . " \n";
                        printf ("%10s %s\n", 'id', $colname);
                        foreach ($results as $result) {
                            printf ("%10s %s\n", $result->id, $result->$colname);
                        }
                    }
                } catch (Exception $e){
                }
            }
        }
    }
}

db_grep($options['search']);

