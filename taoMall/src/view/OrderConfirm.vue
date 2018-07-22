<template>
  <div>
    <!--顶部-->
    <nav-header></nav-header>
    <!--面包屑部分-->
    <nav-bread>
      <a href="javascript:;">订单确认</a>
    </nav-bread>
    <div class="ad_main">
      <div class="ad_main_content">
        <ul class="process">
          <li>
            <span class="ad_pro_title_active">确认地址</span>
            <div class="ad_line ad_line_active">
              <div class="ad_cirle ad_cirle_active"></div>
            </div>
          </li>
          <li>
            <span class="ad_pro_title_active">查看订单</span>
            <div class="ad_line ad_line_active">
              <div class="ad_cirle ad_cirle_active"></div>
            </div>
          </li>
          <li>
            <span>支付</span>
            <div class="ad_line">
              <div class="ad_cirle "></div>
            </div>
          </li>
          <li>
            <span>订单确认</span>
            <div class="ad_line">
              <div class="ad_cirle"></div>
            </div>
          </li>
        </ul>
        <h3 class="main_title">订单详情</h3>
        <ul class="main_listTitle">
          <li class="od_long">商品</li>
          <li>价格</li>
          <li>数量</li>
          <li>总价</li>
        </ul>
        <ul class="itemList">
          <li class="item" v-for="item of carList" v-if="item.checked==1">
            <ul>
              <li class="od_li_long">
                <div class="imgBox"><img :src="'../../static/'+item.productImage" alt=""></div>
                <span class="itemName">{{item.productName}}</span>
              </li>
              <li><span class="itemPrice">{{item.salePrice | currency('￥')}}</span></li>
              <li>
                  <span>×{{item.productNum}}</span>
              </li>
              <li>
                <span class="subtotal">{{(item.productNum*item.salePrice)| currency('￥')}}</span>
              </li>
            </ul>
          </li>
        </ul>
        <div class="od_result">
          <ul class="od_result_right ">
            <li>商品总价：<div class="od_li_price">{{subTotal| currency('￥')}}</div></li>
            <li>快递费：<div class="od_li_price">{{shipping| currency('￥')}}</div></li>
            <li>折扣：<div class="od_li_price">{{discount| currency('￥')}}</div></li>
            <li>合计：<div class="od_li_price od_li_price_active">{{subTotal+shipping-discount| currency('￥')}}</div></li>
            <li class="od_btn">
              <div class="ad_next od_next"><router-link class="ad_next_a" :to="{path:'address'}">上一步</router-link></div>
              <div class="ad_next od_next" @click="payMent"><span class="ad_next_a" >确认支付</span></div>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <nav-footer></nav-footer>
  </div>
</template>

<script>
    import './../assets/css/orderConfirm.css'
    import NavHeader from '@/components/NavHeader.vue'
    import NavFooter from '@/components/NavFooter.vue'
    import NavBread from '@/components/NavBread.vue'
    import Modal from '@/components/Modal.vue'
    import axios from 'axios'
    export default {
        name: "",
        data(){
          return{
            carList:[],
            shipping:10,
            discount:200,
          }
        },
        components: {
          NavHeader,
          NavFooter,
          NavBread,
          Modal,
        },
        mounted(){
          this.init();
        },
        computed:{
            subTotal(){
              var sub=0;
              this.carList.forEach((item)=>{
                if(item.checked=='1'){
                  sub+=item.productNum*item.salePrice
                }
              })
              return sub;
            }
        },
        methods:{
          init(){
            axios.get('/users/carList').then((response)=>{
              var res=response.data;
              this.carList=res.result;
            })
          },
          payMent(){
            var addressId=this.$route.query.addressId;
            axios.post('/users/payMent',{
              productList:this.carList,
              addressId:addressId,
              orderTotal:this.subTotal+this.shipping-this.discount,
              shipping:this.shipping,
              discount:this.discount
            }).then((response)=>{
              var res= response.data;
              if(res.status=='0'){
                this.$router.push({
                  path:'/orederSuccess?orderId='+res.result
                })
              }
            })
          }
        }
    }
</script>

<style>

</style>
