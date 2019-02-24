<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <p>
      For a guide and recipes on how to configure / customize this project,<br>
      check out the
      <a href="https://cli.vuejs.org" target="_blank" rel="noopener">vue-cli documentation</a>.
    </p>
    <h3>Installed CLI Plugins</h3>
    <ul>
      <li><a href="https://github.com/vuejs/vue-cli/tree/dev/packages/%40vue/cli-plugin-babel" target="_blank" rel="noopener">babel</a></li>
      <li><a href="https://github.com/vuejs/vue-cli/tree/dev/packages/%40vue/cli-plugin-eslint" target="_blank" rel="noopener">eslint</a></li>
    </ul>
    <h3>Essential Links</h3>
    <ul>
      <li><a href="https://vuejs.org" target="_blank" rel="noopener">Core Docs</a></li>
      <li><a href="https://forum.vuejs.org" target="_blank" rel="noopener">Forum</a></li>
      <li><a href="https://chat.vuejs.org" target="_blank" rel="noopener">Community Chat</a></li>
      <li><a href="https://twitter.com/vuejs" target="_blank" rel="noopener">Twitter</a></li>
      <li><a href="https://news.vuejs.org" target="_blank" rel="noopener">News</a></li>
    </ul>
    <h3>Ecosystem</h3>
    <h1>USUARIO: {{ user }}</h1>
    <ul>
      <li><a href="https://router.vuejs.org" target="_blank" rel="noopener">vue-router</a></li>
      <li><a href="https://vuex.vuejs.org" target="_blank" rel="noopener">vuex</a></li>
      <li><a href="https://github.com/vuejs/vue-devtools#vue-devtools" target="_blank" rel="noopener">vue-devtools</a></li>
      <li><a href="https://vue-loader.vuejs.org" target="_blank" rel="noopener">vue-loader</a></li>
      <li><a href="https://github.com/vuejs/awesome-vue" target="_blank" rel="noopener">awesome-vue</a></li>
    </ul>
  </div>
</template>

<script>

import { mapGetters, mapActions } from 'vuex'
import {
  getProvider,
  getWallet,
  getWalletAddress,
  Contract,
  utils
} from '../store/ethers/ethersConnect';

import helloContract from '../../build/contracts/NotarizeArba.json'

export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  async mounted() {

    const wallet = await getWallet()
    if(!wallet){
      console.log('Error no hay billetera')
    }
    const walletAddress = await getWalletAddress()
console.log('wallet', wallet)
console.log('walletAddress', walletAddress)

  const provider = await getProvider()

  console.log('quien es el provider:', provider)

const balance = await provider.getBalance(walletAddress)
 let etherString = utils.formatEther(balance);
  console.log('Balance', etherString)
   // console.log('provider', provider)
   // const c = new Contract('0x75840F2926c93b20852346E9E7a7143D08AE1b7e', helloContract.abi, provider)

     const c = new Contract('0x70f5320D48aC098C9B33105442EcF7f8c2044d73', helloContract.abi, provider)
     console.log(c)
    //const d = await c.getDocument(0)
    //console.log(d)
    //console.log('contract', c)
//['0x5805039B783ab293FdcFcD3E561ee62Eda40f38E'], dateString, inputAsunto, inputDesc, inputHash)
   console.log('notarizando...')
   const newDoc = await c.newNotarize(['0x75840F2926c93b20852346E9E7a7143D08AE1b7e'], '10-12-2019', 'asunto', 'texto', 'hashComplicado', 0)
   console.log(newDoc)
   // let receipt = await newDoc.wait(2)
    //console.log('enviaMsg', receipt)

//    const mensaje = await c.getMessage()
  //  console.log('getMensaje', mensaje)
  },
  methods: {
    //...mapActions({
    //  getProvider: 'ethers/getProvider'
    //})
  },
  computed: {
    ...mapGetters({
      user: 'ethers/userInfo'
    })
}
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
