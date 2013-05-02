<?php
class PingController extends Controller
{
    public function indexAction()
    {
        // Remove the attached view
        $this->setNoRender();
        // Remove the layout
        $this->disableLayout();

        echo "OK";
    }
}
