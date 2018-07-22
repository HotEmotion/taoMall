<template>
  <div class="modal_container">
    <div class="modal" >
      <a href="javascript:(0)" class="md_close" @click="closeModal">×</a>

      <div class="md_content" >
        <div class="confirm_tip"  >
          <slot name="message"></slot>
        </div>
        <div class="btn_container">
          <slot name="btnGroup"></slot>
        </div>
      </div>
    </div>
    <div class="mask" @click="closeModal" ></div>
  </div>
</template>

<script>
    export default {
      prpos:["modalShow"],
      data(){
        return{};
      },
      methods:{
        closeModal(){
          this.$emit("close")
        }
      }
    }
</script>

<style>
  @font-face {
    font-family: 'iconfont';  /* project id 701002 */
    src: url('https://at.alicdn.com/t/font_701002_32vkaafrbd7.eot');
    src: url('https://at.alicdn.com/t/font_701002_32vkaafrbd7.eot?#iefix') format('embedded-opentype'),
    url('https://at.alicdn.com/t/font_701002_32vkaafrbd7.woff') format('woff'),
    url('https://at.alicdn.com/t/font_701002_32vkaafrbd7.ttf') format('truetype'),
    url('https://at.alicdn.com/t/font_701002_32vkaafrbd7.svg#iconfont') format('svg');
  }
  .modal{
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto;
    padding: 40px;
    width: 520px;
    height: 330px;
    background-color: white;
    z-index: 999;
    transition: all 2s ;
  }
  .mask{
    position: fixed;
    top: 0;
    right:0;
    bottom:0;
    left:0;
    width:100%;
    height:100%;
    opacity: 0.4;
    background:rgb(0, 0, 0);
    z-index: 50;
    transition: all 2s ;
  }
  .md_close{
    position: absolute;
    top: 0px;
    right: 5px;
    font-size: 30px;
    color: grey;
  }
  .md_content{
    width: 100%;
  }
  .confirm_tip{
    display: flex;
    width: 100%;
    height: 80px;
    line-height: 80px;
    text-align: center;
    padding-top: 30px;
  }
  .confirm_tip span{
    font-family: iconfont;
    font-size: 26px;
    padding-left: 146px;
    color: #ee7a23;
  }
  .confirm_tip p{
    margin: 0;
    padding: 0;
    font-size: 24px;
    padding-left: 10px;
  }
  .btn_container{
    display: flex;
    justify-content: space-between;
    width: 380px;
    height: 40px;
    padding: 0 100px;
    margin-top: 40px;
  }
  .md_btn{
    width: 150px;
    height: 40px;
    border: 0;
    background-color: dodgerblue;
    color: white;
    font-size: 18px;
    cursor: pointer;
  }
  .md_btn:hover{
    background-color: rgba(30,144,255,.8);
  }
  .mg_r{
    margin-left: 20px;
  }

</style>
