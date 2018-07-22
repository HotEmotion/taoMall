<!-- 展示模板 -->
<template>
  <header class="header">
    <div class="header_main">
      <div class="header_logo">
        <a href=""><img src="/static/logo.jpg" alt=""></a>
      </div>
      <div class="header_login" >
        <router-link  href="javascript:;" to="/car" class="shoppingcar" v-if="nickName">&#xe63f;</router-link>
        <a @click="modelFlag=true" v-if="!nickName">登录</a>
        <a @click="logout" v-if="nickName">退出</a>
        <span v-text="nickName" v-if="nickName"></span>
        <div class="carCount" v-if="carCount>0"><router-link  href="javascript:;" to="/car" class="carCount1">{{carCount}}</router-link></div>
      </div>
    </div>
    <div class="modal" v-if="modelFlag" >
      <a href="javascript:(0)" class="md_close" @click="modelFlag=false">×</a>
      <div class="md_title">
        <h2>登 录</h2>
      </div>
      <div class="md_content" >
        <div class="confirm_tip1" v-if="errorTip" >
          <span class="tip_icon" >&#xe616;</span>用户名或密码错误
        </div>
        <ul>
          <li>
            <span>&#xe600;</span>
            <input type="text" placeholder="用户名" v-model="userName">
          </li>
          <li>
            <span>&#xe603;</span>
            <input type="password" placeholder="密码" v-model="userPwd">
          </li>
        </ul>
        <button class="md_btn1" @click="login"> 登录</button>
      </div>
    </div>
    <div class="mask" v-if="modelFlag"></div>
  </header>
</template>
<script>
  import './../assets/css/login.css'
  import axios from 'axios'
  import store from './../Vuex/store'
  export default {
    data(){
      return{
        userName:'',
        userPwd:'',
        errorTip:false,
        modelFlag:false,
        nickName:''
      }
    },
    mounted(){
      this.checkLogin();
    },
    computed:{
      carCount(){
        return store.state.cartCount;
      }
    },
    methods:{
      checkLogin(){
        axios.get("/users/checkLogin").then((response)=>{
          let res=response.data;
          if(res.status=='0'){
            this.nickName=res.result.userName;
            this.getCarCount();
          }
        })
      },
      login(){
        axios.post("/users/login",{
          userName:this.userName,
          userPwd:this.userPwd,
        }).then((response)=>{
          let res=response.data;
          if(res.status=="0"){
            this.errorTip=true;
            this.modelFlag=false;
            this.nickName=res.result.userName;
            this.getCarCount();
          }else {
            this.errorTip=true;
          }
        })
      },
      logout(){
        axios.post("/users/logout").then((response)=>{
          let res=response.data;
          if(res.status=="0"){
            this.nickName=0;
            this.userName='';
            this.userPwd='';
            this.errorTip=false;
            store.commit("updateCartCount",0);
          }
        })
      },
      getCarCount(){
        var carCount=0;
        axios.get('/users/carList').then((response)=> {
          var res= response.data;
          var carList=[];
          if(res.status=='0'){
            carList=res.result;
            carList.forEach((item)=>{
                carCount+=item.productNum;
            });
           store.commit("updateCartCount",carCount);
          }
        })

      }
    }
  }
</script>


