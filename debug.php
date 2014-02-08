<?php
/*

This is useful in debugging the White Screen of Death

It tells php to really *really*, no just f$#%^ing really, log your error, srzly

just do this where ever you want:

include('/var/www/common/dev-conf/debug.php');



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
        return(@call_user_func_array('ErrorHandler', $error));
    };

    return(TRUE);
};

register_shutdown_function('ShutdownHandler');

// ----------------------------------------------------------------------------------------------------
// - Error Handler
// ----------------------------------------------------------------------------------------------------
function ErrorHandler($type, $message, $file, $line)
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
        $name = 'E_UNKNOWN';
    };

#    return(print(@sprintf("%s Error in file \xBB%s\xAB at line %d: %s\n", $name, @basename($file), $line, $message)));
    error_log(@sprintf("%s Error in %s:%d  %s\n", $name, $file, $line, $message));
};

$old_error_handler = set_error_handler("ErrorHandler");

