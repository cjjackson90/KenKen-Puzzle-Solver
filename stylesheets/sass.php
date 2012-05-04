<?php
header('Content-Type: text/css');

#include '/var/www/phpsass/SassParser.php';
include 'C:/wamp/www/phpsass/SassParser.php';

$options = array(
  'style' => 'nested',
  'cache' => FALSE,
  'syntax' => 'sass',
  'debug' => FALSE,
  'callbacks' => array(
    'warn' => 'cb_warn',
    'debug' => 'cb_debug',
  ),
);
// Execute the compiler.
$parser = new SassParser($options);
print_r( $parser->toCss( file_get_contents( $_GET['file'] ) ) );
