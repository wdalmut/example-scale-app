<?php
class IndexController extends Controller
{
    public function indexAction()
    {
        $this->view->helloText = "Ciao Mondo Aggiornato!";
    }
}



