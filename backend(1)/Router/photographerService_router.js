const router = require('express').Router();
const photoservicecontroller =require('../controller/photographerservice_controller');


router.post("/registerphotoservice",photoservicecontroller.registerphotoservice);
router.post("/getbyid",photoservicecontroller.getbyid);
router.post("/getallservices",photoservicecontroller.getallservices);
router.post('/getbyuidservices',photoservicecontroller.getbyuidservices);
router.post('/getoneservices',photoservicecontroller.getoneservices);
router.post('/deleteservices',photoservicecontroller.deleteservices);
router.post('/updateservice',photoservicecontroller.updateservice);

module.exports =router;
