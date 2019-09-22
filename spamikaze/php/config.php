<?php

/*
 * config.php, part of spamikaze.
 * Copyright 2003 Hans Wolters, <h-wolters@nl.linux.org>
 * Released under the GNU GPL
 *
 * This file is part of the spamikaze project:
 *     http://spamikaze.surriel.com/
 */


/*
 * Some setting to make sure it will not
 * not have path disclosures and isn't
 * able to open remote files.
 */

ini_set("display_errors",1);
ini_set("allow_url_fopen", 0);

$octa = 0;
$octb = 0;
$octc = 0;
$octd = 0;

$host   = "db";
$port   = 3306;
$dbuser = "usr";
$dbpwd  = "pwd";
$dba    = "root@localhost";
$dbname = "dnsbl";


function connect()
{
    global $host, $port, $dbuser, $dbpwd, $dba, $dbname, $msg;
    $link = mysqli_connect($host .":". $port, $dbuser, $dbpwd);

    if (!$link) {
      echo "Error: Unable to connect to MySQL." . PHP_EOL;
      echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
      echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
      // mail (  $dba, 'Connect', "Could not connect the database server");
      exit(22);
    }

    if (!mysqli_select_db( $link, $dbname )) {
        mail (  $dba, 'Selectdb', "Could not select the database");
        exit(23);
    } else {
        return $link;
    }
}
