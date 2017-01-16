<?php
header("HTTP/1.1 301 Moved Permanently");
header( 'Location: http://'.$_ENV["APPLICATION_CNAME"] ) ;
?>
<!-- User should be redirected -->