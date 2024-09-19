const express = require('express');
const body_parser = require("body-parser");

const userRouter =require('./Router/user.router');
const photographerRouter = require ('./Router/photographer_Router');
const photographerServiceRouter =require ('./Router/photographerService_router')
const workRouter =require ('./Router/work_Router')
const chatRoute = require("./Router/chat.route");
const bookRoute = require("./Router/book.route");
const ratingRoute = require("./Router/rating.route");

const app = express();
app.use(body_parser.json());
app.use('/',userRouter);
app.use('/',photographerRouter);
app.use('/',photographerServiceRouter)
app.use('/',workRouter)
app.use("/",chatRoute);
app.use("/",bookRoute);
app.use("/",ratingRoute);

module.exports = app;
