const router = require('express').Router();
const photographercontroller =require('../controller/photographer_controller');

router.post('/photographerservice',photographercontroller.registerphotographer);
router.post('/getone',photographercontroller.getone);
router.post('/getall',photographercontroller.getall);
router.post('/updatephoto',photographercontroller.updatephoto);


module.exports =router;