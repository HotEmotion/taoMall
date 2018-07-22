var express = require('express');
var router = express.Router();
const mysql=require('mysql');
require('./../util/util')
const db=mysql.createPool({host:'localhost',user:'root',password:'123456',database:'taomall'});
/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});
//检查是否登录
router.get('/checkLogin',function (req,res,next) {
    if(req.cookies.userId){
        res.json({
            status:'0',
            msg:'',
            result:{userName:req.cookies.userName}
        })
    }else {
        res.send('未登录');
    }
})
//登录接口
router.post('/login',function (req,res,next) {
  var userName=req.body.userName;
  var userPwd=req.body.userPwd;

  db.query(`select * from userlist where userName='${userName}' and userPwd='${userPwd}'`,(err,data)=>{
    if(err){
      res.status(500).json({status:1,msg:err.message}).end();
    }else {
        if(data[0]!=undefined){
            res.cookie("userId",data[0].UserId,{
                path:'/',
                maxAge:1000*60*60,
            });
            res.cookie("userName",data[0].UserName,{
                path:'/',
                maxAge:1000*60*60,
            });
            console.log(data[0]);
            res.json({status:0,msg:'',result:{userName:data[0].UserName}});
        }else {
            res.json({status:1,msg:''});
        }
    }
  })

})
//登出接口
router.post('/logout',(req,res,next)=>{
    res.cookie("userId","",{
        path:"/",
        maxAge:-1
    });
    res.json({
        status:"0",
        msg:"",
        result:""
    })
})
//购物车列表接口
router.get('/carlist',function (req,res,next) {
    var userId=req.cookies.userId;
    if(userId){
        db.query(`select * from carlist where userId=${userId}`,(err,data)=>{
            if(err){
                res.status(500).json({status:1,msg:err.message}).end();
            }else {
                console.log(data);
                res.json({
                    status:"0",
                    msg:'',
                    result:data
                })
            }
        })
    }
})
//购物车删除商品接口
router.post('/carDel',function (req,res,next) {
    var userId=req.cookies.userId;
    var productId=req.body.productId;
    db.query(`delete from carlist where productId=${productId} and userId=${userId}`,(err,data)=>{
        if(err){
            res.status(500).json({status:1,msg:err.message}).end();
        }else {
            res.json({
                status:"0",
                msg:'',
                result:''
            })
        }
    })

})
//编辑购物车接口
router.post('/carEdit',function (req,res,next) {
    var Id=req.body.Id;
    var productNum=req.body.productNum;
    var checked=req.body.checked;
    db.query(`update carlist set productNum='${productNum}',checked=${checked} where Id=${Id}`,(err,data)=>{
        if(err){
            res.status(500).json({status:1,msg:err.message}).end();
        }else {
            console.log(data);
            res.json({
                status:"0",
                msg:'',
                result:''
            })
        }
    })
})
//全部选中接口
router.post('/carCheckAll',(req,res,next)=>{
    var userId=req.cookies.userId;
    var checked=req.body.checked;
    db.query(`update carlist set checked = ${checked} where userId=${userId}`,(err,data)=>{
        if(err){
            res.status(500).json({status:1,msg:err.message}).end();
        }else {
            res.json({
                status:"0",
                msg:'',
                result:''
            })
        }
    })
})
//查询地址列表
router.get('/addressList',(req,res,next)=>{
    var userId=req.cookies.userId;
    console.log(userId);
    db.query(`select * from addresslist where UserId='${userId}'`,(err,data)=>{
        if(err){
            res.status(500).json({status:1,msg:err.message}).end();
        }else {
            console.log(data);
            res.json({
                status:"0",
                msg:'',
                result:data
            })
        }
    })
})
//修改默认地址
router.post('/setDefault',(req,res,next)=>{
    var userId=req.cookies.userId;
    var Id=req.body.Id;
    db.query(`update addresslist set isDefault=0 where UserId=${userId}`,(err,data)=>{
        if(err){
            res.status(500).json({status:1,msg:err.message}).end();
        }else {
            db.query(`update addresslist set isDefault=1 where Id=${Id}`,(err,data)=>{
                if(err){
                    res.status(500).json({status:1,msg:err.message}).end();
                }else {
                    res.json({
                        status:"0",
                        msg:'',
                        result:''
                    })
                }
            })
        }
    })
})
//删除地址
router.post('/addrDel',(req,res,next)=>{
    var Id = req.body.Id;
    db.query(`delete from addresslist where Id='${Id}'`,(err,data)=>{
        if(err){
            res.status(500).json({status:1,msg:err.message}).end();
        }else {
            res.json({
                status:"0",
                msg:'',
                result:''
            })
        }
    })
})
//确认支付接口
router.post('/payMent',(req,res,next)=> {
    var userId = req.cookies.userId;
    var productList = req.body.productList;
    var addressId = req.body.addressId;
    var orderTotal = req.body.orderTotal;
    var shipping = req.body.shipping;
    var discount = req.body.discount;

    var platform = '305';
    var r1 = Math.floor(Math.random() * 10);
    var r2 = Math.floor(Math.random() * 10);
    var sysDate = new Date().Format('yyyyMMddhhmmss');
    var createdTime = new Date().Format('yyyy-MM-dd hh:mm:ss');
    var orderId = platform + r1 + sysDate + r2;
    db.query(`insert into orderinfo (OrderId,UserId,AddressId,CreatedTime,Shipping,Discount,OrderTotal,OrderStatus) values ('${orderId}','${userId}','${addressId}','${createdTime}','${shipping}','${discount}','${orderTotal}','1')`, (err1, data1) => {
        if (err1) {
            res.status(500).json({status: 1, msg: err.message}).end();
        } else {
            productList.forEach((item) => {
                if (item.checked == '1') {
                    db.query(`insert into orderlist (OrderId,UserId,ProductId,ProductNum) values ('${orderId}','${userId}','${item.productId}','${item.productNum}')`, (err2, data2) => {
                        if (err2) {
                            res.status(500).json({status: 1, msg: err2.message}).end();
                        }
                    })
                }
            })
        }
        res.json({
            status:0,
            msg:'',
            result:orderId
        })
    })
})
//查询订单总金额接口
router.get('/getOrderTotal',(req,res,next)=>{
    var userId=req.cookies.userId;
    var orderId=req.query.orderId;
    db.query(`select * from orderinfo where UserId='${userId}' and OrderId='${orderId}'`,(err,data)=>{
        if(err){
            res.status(500).json({status:1,msg:err.message}).end();
        }else {
            console.log(data);
            res.json({
                status:"0",
                msg:'',
                result:data[0]
            })
        }
    })
})

module.exports = router;
