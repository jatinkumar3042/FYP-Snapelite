const mongoose = require('mongoose');
const db = require('../config/db');
const { Schema } = mongoose;

const workSchema = new Schema({
    uid:{
        type:String,
    },
    img:{
        type:String,
    },
    name:{
        type:String,
    }
});

const workModel = db.model('work',workSchema);
module.exports = workModel;