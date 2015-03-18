<?php

/**
 * A convenience log function
 *
 * @$d an object or var to dump to error log with extra context info
 * @$t if true also print a nice stack trace
 *
 * If you commit a call to this you need to buy someone a beer, BAD!
 */

if (!function_exists('e')){

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
}
