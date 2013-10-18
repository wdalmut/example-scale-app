<?php
class IndexController extends Controller
{
    public function indexAction()
    {
        $this->view->helloText = "Abbiamo finito il corso!";
    }
}



