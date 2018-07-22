<template>
  <div>
    <!--顶部-->
    <nav-header></nav-header>
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
              <span class="ad_pro_title_active">支付</span>
              <div class="ad_line ad_line_active">
                <div class="ad_cirle ad_cirle_active"></div>
              </div>
            </li>
            <li>
              <span class="ad_pro_title_active">订单完成</span>
              <div class="ad_line ad_line_active">
                <div class="ad_cirle ad_cirle_active"></div>
              </div>
            </li>
          </ul>
          <div class="suc_img">
            <img src="./../../static/orderSuccess.png" alt="">
          </div>
          <div class="suc_cong">恭喜您！</div>
          <div class="suc_cong">您的订单已完成！</div>
          <div class="suc_xinxi">
            <p>订单号：{{orderId}}</p>
            <p class="suc_p" >订单合计：{{OrderTotal| currency('￥')}}</p>
          </div>
          <div class="suc_xinxi suc_xinxi1">
            <div class="ad_next"><router-link class="ad_next_a" to="/car">购物车</router-link></div>
            <div class="ad_next suc_next"><router-link class="ad_next_a" to="/">商品列表</router-link></div>
          </div>
        </div>
      </div>
    <nav-footer></nav-footer>
  </div>
</template>

<script>
    import NavHeader from '@/components/NavHeader.vue'
    import NavFooter from '@/components/NavFooter.vue'
    import './../assets/css/OrderSuccess.css'
    import axios from 'axios'
    export default {
      data(){
        return{
          orderId:'',
          OrderTotal:''
        }
      },
      components: {
        NavHeader,
        NavFooter,
      },
      mounted(){
        this.init();
      },
      methods:{
        init(){
          this.orderId=this.$route.query.orderId;
          axios.get('/users/getOrderTotal',{
            params:{orderId:this.orderId}
          }).then((response)=>{
            var res=response.data;
            if(res.status=='0'){
              this.OrderTotal=res.result.OrderTotal;
            }
          })
        }
      }
    }
</script>

