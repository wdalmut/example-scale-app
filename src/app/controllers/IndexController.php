<?php
class IndexController extends Controller
{
    public function indexAction()
    {
        $this->view->helloText = "Ciao dal corso!";
    }
}



