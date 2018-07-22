import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)
const store = new Vuex.Store({
  state: {
    cartCount:0
  },
  mutations: {
    updateCartCount(state,cartCount){
      state.cartCount = cartCount;
    },
    updateCartCount1(state,cartCount){
      state.cartCount += cartCount;
    }
  }
});
export default store
