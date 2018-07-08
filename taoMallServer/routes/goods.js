const express=require('express');
const mysql=require('mysql');
const router=express.Router();
const db=mysql.createPool({host:'localhost',user:'root',password:'123456',database:'taomall'});
router.get('/',(req,res)=>{
    var page=req.query.page;
    var pageSize=req.query.pageSize;
    var orderFlag=req.query.orderFlag;
    var priceLevel=req.query.priceLevel;
    var priceFrom=0,priceTo=100000000;
    switch (priceLevel){
        case '0':priceFrom=0;priceTo=100;break;
        case '1':priceFrom=100;priceTo=500;break;
        case '2':priceFrom=500;priceTo=1000;break;
        case '3':priceFrom=1000;priceTo=8000;break;
        default:break;
    }
    if(orderFlag==='true'){
        db.query(`select * from goodsList where productPrice>=${priceFrom} and productPrice<=${priceTo} order by productPrice limit ${page*pageSize},${pageSize}`,(err,data)=>{
            if(err){
                res.status(500).send('服务器错误').end();
            }else {
                console.log(req.query);
                console.log(data);
                res.send(data);
            }
        });
    }else {
        db.query(`select * from goodsList where productPrice>=${priceFrom} and productPrice<=${priceTo} order by productPrice DESC limit ${page*pageSize},${pageSize}`,(err,data)=>{
            if(err){
                res.status(500).send('服务器错误').end();
            }else {
                console.log(data);
                res.send(data);
            }
        });
    }
})
module.exports=router;