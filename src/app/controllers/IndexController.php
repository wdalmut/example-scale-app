<?php
class IndexController extends Controller
{
    public function indexAction()
    {
        $this->view->helloText = "E faccio la mia sessione";
    }
}



