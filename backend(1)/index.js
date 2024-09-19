
const app = require('./app');
const db =require('./config/db');
const Usermodel =require('./model/user.model');


const port = 4000;

app.get('/',(req,res)=>{
    res.send("hello world");
});
app.listen(port, () => {
    console.log('server api is running');
});
