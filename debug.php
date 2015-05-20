<?php
/*

Behold ...  the 'UBER' LOGGER


This is useful in debugging the White Screen of Death, or cases where the there
 is no error log, or if the error log doesn't tell you where the error came from.

It tells php to really *really*, no just f$#%^ing really, log your error, srzly.

It also gives you a full stack trace and the URL which caused it (good for
isolating when it is actually an image or js request which is causing the error,
not the main page)

Just add this early in your page, it's already in local moodle config just uncomment it:

include_once('/var/www/common/dev-conf/debug.php');
include_once('/home/haywoodb/scripts/debug.php');

NOTE: If Moodle/drupal/whatever also creates it own handlers, add this script AFTER them
as this will chain to the existing handler.


*/


/**
 * A convenience log function
 *
 * @$d an object or var to dump to error log with extra context info
 * @$t if true also print a nice stack trace
 *
 * If you commit a call to this you need to buy someone a beer, BAD!
 */
function e($d, $t = false){
    $trace = debug_backtrace();

    $stack = 'DEBUG: '.$trace[0]['file'] . ':'.$trace[0]['line'] .' => '. print_r($d,1);

    if ($t){
        unset($trace[0]); //Remove call to this function from stack trace
        $stack .= PHP_EOL;
        $i = 0;
        $len = 0;
        foreach($trace as $node) {
            $part = "    #$i ".$node['file'] ."(" .$node['line']."): ";
            $len = max($len, strlen($part));
        }
        foreach($trace as $node) {
            $stack .= sprintf("%-".$len."s", "    #$i ".$node['file'] .":" .$node['line']." ");
            if(isset($node['class'])) {
                $stack .= $node['class'] . "->";
            }
            $stack .= $node['function'] . "()" . PHP_EOL;
            $i++;
        }
        $stack .= "\n URL: ".$_SERVER['REQUEST_URI'];
    }
    error_log($stack);
}

error_reporting(-1);

// ----------------------------------------------------------------------------------------------------
// - Shutdown Handler
// ----------------------------------------------------------------------------------------------------
function ShutdownHandler()
{
    if(@is_array($error = @error_get_last()))
    {
        return(@call_user_func_array('UberErrorHandler', $error));
    };

    return(TRUE);
};

register_shutdown_function('ShutdownHandler');

// ----------------------------------------------------------------------------------------------------
// - Error Handler
// ----------------------------------------------------------------------------------------------------

$old_error_handler = null;

function UberErrorHandler($type, $message='', $file='unknownfile', $line=0)
{
    $_ERRORS = Array(
        0x0001 => 'E_ERROR',
        0x0002 => 'E_WARNING',
        0x0004 => 'E_PARSE',
        0x0008 => 'E_NOTICE',
        0x0010 => 'E_CORE_ERROR',
        0x0020 => 'E_CORE_WARNING',
        0x0040 => 'E_COMPILE_ERROR',
        0x0080 => 'E_COMPILE_WARNING',
        0x0100 => 'E_USER_ERROR',
        0x0200 => 'E_USER_WARNING',
        0x0400 => 'E_USER_NOTICE',
        0x0800 => 'E_STRICT',
        0x1000 => 'E_RECOVERABLE_ERROR',
        0x2000 => 'E_DEPRECATED',
        0x4000 => 'E_USER_DEPRECATED'
    );

    if(!@is_string($name = @array_search($type, @array_flip($_ERRORS))))
    {
        $name = 'E_UNKNOWN:'.$type;
    };
    if ($name != 'E_NOTICE'
         && substr($message, 0, 6) != 'unlink'
         && substr($message, 0, 5) != 'chmod'
    ){
        error_log(@sprintf("UberErrorHandler: %s Error in %s:%d  %s\n URL: %s\n", $name, $file, $line, $message, $_SERVER['REQUEST_URI']));
    }
};

$old_error_handler = set_error_handler("UberErrorHandler");



// ----------------------------------------------------------------------------------------------------
// - Exception Handler
// ----------------------------------------------------------------------------------------------------

$old_exception_handler = null;

function UberExceptionHandler($ex) {

    global $old_exception_handler;
    error_log (sprintf('UberExceptionHandler: %s', $_SERVER['REQUEST_URI']));

    // Now call the old error handler. Moodle registers it's own default handler which does
    // stuff like closing DB transactions, so we just want to augment that instead of replace it
    call_user_func( $old_exception_handler, $ex);
}


$old_exception_handler = set_exception_handler("UberExceptionHandler");


function sql($sql){

    global $CFG;

    $sql = preg_replace("/\{(.*?)\}/", $CFG->prefix . "$1", $sql);

    print $sql."\n";

}


