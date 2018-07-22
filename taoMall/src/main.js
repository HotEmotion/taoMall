// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import Vuex from 'vuex'
import VueLazyLoad from 'vue-lazyload'
import infiniteScroll from 'vue-infinite-scroll'
import  {currency} from "./util/currency";

Vue.config.productionTip = false
Vue.use(infiniteScroll);
Vue.filter("currency",currency);


/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>',
  directives: {infiniteScroll}

})


Vue.use(VueLazyLoad,{
  loading:"/static/Loading/loading-balls.svg"
});

