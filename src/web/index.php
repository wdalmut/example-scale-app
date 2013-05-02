<?php
require_once __DIR__ . '/../../vendor/autoload.php';

define ("APPLICATION_ENV", 'development');

$app = new Application();
$app->setControllerPath(__DIR__ . '/../app/controllers');

$app->bootstrap("config", function() {
    $config = new Config();
    $config->load(__DIR__ . '/../app/configs/application.ini');

    return $config;
});

$app->bootstrap("view", function(){
    $view = new View();
    $view->setViewPath(__DIR__ . '/../app/views');

    return $view;
});

$app->bootstrap("layout", function(){
    $layout = new Layout();
    $layout->setViewPath(__DIR__ . '/../app/layouts');

    return $layout;
});

$app->run();

