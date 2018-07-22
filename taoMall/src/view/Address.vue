<!-- 展示模板 -->
<template>
  <div>
    <!--顶部-->
    <nav-header></nav-header>
    <!--面包屑部分-->
    <nav-bread>
      <a href="javascript:;">收货地址确认</a>
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
            <span>查看订单</span>
            <div class="ad_line">
              <div class="ad_cirle"></div>
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
        <div class="ad_content">
          <h3 class="ad_title">收货地址</h3>
          <ul class="ad_items">
            <li  v-for="(item,index) in addrListFilter" :class="{'li_active':activeIndex==index}" @click="activeIndex=index;selectedId=item.Id">
              <h3 class="ad_name">{{item.Name}}</h3>
              <p class="ad_address">{{item.Address}}</p>
              <p class="ad_tel">{{item.Tel}}</p>
              <div>
                <h5 class="ad_default" v-show="item.isDefault">默认地址</h5>
                <h5 class="ad_default set_default" v-show="!item.isDefault" @click="setDefalt(item.Id)">设为默认地址</h5>
                <span @click="itemId=item.Id;delConfirm=true">&#xe613;</span>
              </div>
            </li>
            <li class="ad_addAdr">
              <span>+</span>
              <p>添加新地址</p>
            </li>
          </ul>
        </div>
        <div class="ad_more" @click="expand " :class="{'ad_more_expand':limit>3}">more<span>&#xe60c;</span></div>
        <div class="ad_next">
          <router-link class="ad_next_a" :to="{path:'orderConfirm',query:{addressId:selectedId}}">下一步</router-link>
        </div>
      </div>
    </div>
    <modal v-show="delConfirm" @close="delConfirm=false">
      <div slot="message" class="confirm_tip" >
        <p style="margin-left: 123px">您确认删除此地址吗？</p>
      </div>
      <div slot="btnGroup" >
        <button class="md_btn" @click="addrDel">确认</button>
        <button class="md_btn" @click="delConfirm=false" style="margin-left: 20px">关闭</button>
      </div>
    </modal>
    <nav-footer></nav-footer>
  </div>
</template>

<script>
    // 导入组件
    import './../assets/css/address.css'
    import NavHeader from '@/components/NavHeader.vue'
    import NavFooter from '@/components/NavFooter.vue'
    import NavBread from '@/components/NavBread.vue'
    import Modal from '@/components/Modal.vue'
    import axios from 'axios'

    export default {
      data(){
        return{
          addrList:[],
          limit:3,
          activeIndex:0,
          delConfirm:false,
          itemId:'',
          selectedId:'0',
        }
      },
      components: {
        NavHeader,
        NavFooter,
        NavBread,
        Modal,
      },
      mounted(){
        this.getAddressList();
      },
      computed:{
        addrListFilter(){
          return this.addrList.slice(0,this.limit);
        }
      },
      methods:{
        getAddressList(){
          axios.get('/users/addressList').then((response)=>{
            var res =response.data;
            if(res.status=='0'){
              this.addrList=res.result;
            }
          })
        },
        expand(){
          if(this.limit==3){
            this.limit=this.addrList.length;
          }else {
            this.limit=3
          }
        },
        setDefalt(Id){
          axios.post('/users/setDefault',{
            Id:Id
          }).then((response)=>{
            var res =response.data;
            if(res.status=='0'){
              this.getAddressList()
            }
          })
        },
        addrDel(){
          axios.post('/users/addrDel',{
            Id:this.itemId
          }).then((response)=>{
            var res= response.data;
            if(res.status=='0'){
              this.delConfirm=false;
              this.getAddressList();
            }
          })
        }
      }
    }

</script>
<!-- 样式代码 -->

