import Vue from 'vue'
import Router from 'vue-router'
import GoodsList from '@/view/GoodsList'
import Car from '@/view/Car'
import Address from '@/view/Address'
import OrderConfirm from '@/view/OrderConfirm'
import OrderSuccess from '@/view/OrderSuccess'

Vue.use(Router);
export default new Router({
  routes: [
    {
      path: '/',
      name: 'GoodsList',
      component: GoodsList
    },
    {
      path: '/car',
      name: 'car',
      component: Car
    },
    {
      path: '/address',
      name: 'address',
      component: Address
    },
    {
      path: '/orderConfirm',
      name: 'orderConfirm',
      component: OrderConfirm
    },
    {
      path: '/orederSuccess',
      name: 'orderSuccess',
      component: OrderSuccess
    },
  ]
})
