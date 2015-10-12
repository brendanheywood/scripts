<?php
define('CLI_SCRIPT', true);

require(dirname(dirname(dirname(__FILE__))).'/config.php');
require_once($CFG->libdir.'/clilib.php');      // cli only functions

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
                try {
                    $sql = "SELECT * FROM $tab WHERE {$column->name} like '%$search%'\n";
                    // echo $sql;
                    $results = $DB->get_records_sql($sql);
                    if ($results) {
                        var_dump($results);
                    }
                } catch (Exception $e){
                }
            }
        }
    }
}

db_grep('test');

