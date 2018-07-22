<!-- 展示模板 -->
<template>
    <div>
      <!--顶部-->
      <nav-header></nav-header>
      <!--面包屑部分-->
      <nav-bread>
        <a href="javascript:;">商品</a>
      </nav-bread>
      <!--主体部分-->
      <main class="main">
        <section class="main_main">
          <div class="main_sort">
            <div class="sort_content">
              <span class="sort_jiantou" :class="{sort_jiantou_turn:!orderFlag}">&#xe765;</span>
              <span v-on:click="sortBy()">价格</span>
              <a href="">默认</a>
              <span>排序：</span>
            </div>
          </div>
          <div class="main_content">
            <div class="content_left">
              <div class="content_title">价 格: </div>
              <ul class="filter">
                <li v-on:click="setPriceLevel('all')"><a href="javascript:void(0)" v-bind:class="{filter_current:priceChecked=='all'}"  v-on:click="priceChecked='all'">全部</a></li>
                <li v-for="(item,index) in price" v-on:click="setPriceLevel(index)"><a href="javascript:void(0)" v-bind:class="{filter_current:priceChecked==index}" v-on:click="priceChecked=index">{{item.startPrice}}-{{item.endPrice}}</a></li>
              </ul>
            </div>
            <div class="content_right">
              <div class="content_item" v-for="item in goodsList">
                <a href=""><img v-lazy="'/static/'+item.productImg" alt="" class="item_img"></a>
                <span class="item_name">{{item.productName}}</span>
                <p class="item_price">{{item.productPrice | currency('￥')}}</p>
                <div class="item_buy" @click="addToCar(item.productId)">加入购物车</div>
              </div>

            </div>

          </div>
          <div v-infinite-scroll="loadMore" infinite-scroll-disabled="busy" infinite-scroll-distance="30">
            <!--加载中...-->
          </div>
        </section>
      </main>
      <!--底部-->
      <nav-footer></nav-footer>
      <modal v-show="modalShow" v-on:close="closeModal">
          <p slot="message" style="margin-left: 87px">请先登录，否则无法加入购物车</p>
          <button slot="btnGroup" class="md_btn" style="margin-left: 90px" @click="modalShow=false">关闭</button>
      </modal>
      <modal v-show="modalCar" v-on:close="closeModal">
        <div slot="message" class="confirm_tip">
          <span>&#xe654;</span>
          <p>加入购物车成功</p>
        </div>

        <div slot="btnGroup">
          <button class="md_btn" @click="modalCar=false">继续购物</button>
          <router-link  href="javascript:;" to="/car"><button class="md_btn mg_r">查看购物车</button></router-link>
        </div>
      </modal>
    </div>
</template>

<script>
    // 导入组件
    import './../assets/css/goodList.css'
    import store from './../Vuex/store'
    import NavHeader from '@/components/NavHeader.vue'
    import NavFooter from '@/components/NavFooter.vue'
    import NavBread from '@/components/NavBread.vue'
    import Modal from '@/components/Modal.vue'
    import axios from 'axios'
    export default {
        data(){
          return{
            goodsList:[],
            price:[
              {
                "startPrice":"0.00",
                "endPrice":"100.00"
              },
              {
                "startPrice":"100.00",
                "endPrice":"500.00"
              },
              {
                "startPrice":"500.00",
                "endPrice":"1000.00"
              },
              {
                "startPrice":"1000.00",
                "endPrice":"8000.00"
              },
            ],
            priceChecked:'all',
            page:0,
            pageSize:8,
            orderFlag:true,
            busy:true,
            priceLevel:'all',
            modalCar:false,
            modalShow:false,
          }
        },
        components: {
          NavHeader,
          NavFooter,
          NavBread,
          Modal,
        },

        mounted:function(){
          this.getGoodsList(false);
        },
        methods:{

          getGoodsList(flag){
            var param={
              page:this.page,
              pageSize:this.pageSize,
              orderFlag:this.orderFlag,
              priceLevel:this.priceLevel,
            };
            axios.get("/goods/list",{
              params:param
            }).then((res)=>{
                if(flag){
                  this.goodsList=this.goodsList.concat(res.data);
                  if(res.data.length!==0){
                    this.busy=false;
                  }else {
                    this.busy=true;
                  }
                }else {
                  this.goodsList=res.data;
                  this.busy=false;
                }
            })
          },
          sortBy(){
            this.orderFlag=!this.orderFlag;
            this.page=0;
            this.getGoodsList(false);
          },
          loadMore(){
            this.busy=true;
            setTimeout(()=>{
              this.page++;
              this.getGoodsList(true);
            })
          },
          setPriceLevel(index){
            this.priceLevel=index;
            this.page=0;
            this.getGoodsList(false);
          },
          addToCar(productId){
            axios.post("/goods/addCar",{
              productId:productId
            }).then((res)=>{
              if(res.data.status=='0'){
                this.modalCar=true;
                store.commit("updateCartCount1",1);
              }else {
                this.modalShow=true
              }
            })
          },
          closeModal(){
            this.modalShow=false;
            this.modalCar=false;
          }

        }
    }
</script>

