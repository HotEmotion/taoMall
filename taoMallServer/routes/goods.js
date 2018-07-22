const express=require('express');
const mysql=require('mysql');
const router=express.Router();
const db=mysql.createPool({host:'localhost',user:'root',password:'123456',database:'taomall'});
//获得商品列表接口
router.get('/list',(req,res)=>{
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
        db.query(`select * from goodslist where productPrice>=${priceFrom} and productPrice<=${priceTo} order by productPrice limit ${page*pageSize},${pageSize}`,(err,data)=>{
            if(err){
                res.status(500).send(err.message).end();
            }else {
                res.send(data);
            }
        });
    }else {
        db.query(`select * from goodslist where productPrice>=${priceFrom} and productPrice<=${priceTo} order by productPrice DESC limit ${page*pageSize},${pageSize}`,(err,data)=>{
            if(err){
                res.status(500).send(err.message).end();
            }else {
                res.send(data);
            }
        });
    }
})
//加入购物车接口
router.post('/addCar',function (req,res,next) {
    var productId=req.body.productId;
    var userId=req.cookies.userId;
    db.query(`select * from carlist where productId=${productId} and userId=${userId}`,(err,hasProduct)=>{
        if(err){
            res.status(500).send(err.message).end();
        }else {
            console.log(hasProduct);
            if(hasProduct[0]!=undefined){
                var num =hasProduct[0].productNum+1;
                db.query(`update carlist set productNum=${num} where productId=${productId} and userId=${userId}`,(err)=>{
                    if(err){
                        res.status(500).send(err.message).end();
                    }else {
                        res.json({
                            status:"0",
                            msg:"加入成功"
                        });
                    }
                })
            }else {
                db.query(`select * from goodslist where productId=${productId}`,(err,proDoc)=>{
                    if(err){
                        res.status(500).send(err.message).end();
                    }else {
                        if(proDoc){
                            db.query(`insert into carlist(productId,userId,productName,salePrice,productImage,checked,productNum) values('${productId}','${userId}','${proDoc[0].productName}','${proDoc[0].productPrice}','${proDoc[0].productImg}','1','1')`,(err,data)=>{
                                if(err){
                                    res.status(500).send(err.message).end();
                                }else {
                                    console.log(data);
                                    res.json({
                                        status:"0",
                                        msg:"加入成功"
                                    });
                                }
                            })
                        }
                    }
                })
            }
        }
    })

})
module.exports=router;