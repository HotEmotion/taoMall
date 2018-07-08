<!-- 展示模板 -->
<template>
    <div>
      <!--顶部-->
      <nav-header></nav-header>
      <!--面包屑部分-->
      <nav-bread>
        <a href="">商品</a>
      </nav-bread>
      <!--主体部分-->
      <main class="main">
        <section class="main_main">
          <div class="main_sort">
            <div class="sort_content">
              <span class="sort_jiantou" v-show="orderFlag">&#xe765;</span>
              <span class="sort_jiantou" v-show="!orderFlag">&#xe660;;</span>
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
                <p class="item_price">{{item.productPrice}}</p>
                <div class="item_buy">加入购物车</div>
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
    </div>
</template>

<script>
    // 导入组件
    import './../assets/css/goodList.css'
    import NavHeader from '@/components/NavHeader.vue'
    import NavFooter from '@/components/NavFooter.vue'
    import NavBread from '@/components/NavBread.vue'
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
            priceLevel:'all'
          }
        },
        components: {
          NavHeader,
          NavFooter,
          NavBread,
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
            axios.get("/goods",{
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
          }

        }
    }
</script>

