const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const bookSchema = new Schema({
    uid:{
        type:String,
    },
    bid:{
        type:String,
    },
    sid:{
        type:String,
    },
    date:{
        type:String,
    },
    status:{
        type:String,
    },
    lat:{
        type:String,
    },
    lon:{
        type:String,
    },
});

const bookModel = db.model('book',bookSchema);
module.exports = bookModel;
