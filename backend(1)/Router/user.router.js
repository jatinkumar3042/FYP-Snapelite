const router =require('express').Router();

const Usercontroller =require('../controller/user.controller');

router.post('/registration',Usercontroller.register);
router.post('/login',Usercontroller.login);
router.post('/getonuser',Usercontroller.getonuser);


module.exports =router;                                 