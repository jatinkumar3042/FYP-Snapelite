const mongoose = require('mongoose');

const connection =mongoose.createConnection('mongodb://127.0.0.1:27017/snape').on('open',()=>{
    console.log('Mongodb Connected');
}).on('error',()=>{
    console.log('Mongodb Connection error');
});


module.exports = connection;
