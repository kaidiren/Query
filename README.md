use example

```js
const QueryJSON = require('./build/contracts/Query.json')
const Web3 = require('web3')

const web3 = new Web3('http://127.0.0.1:8545')

async function main () {
  const id = await web3.eth.net.getId()
  const QueryAddress = QueryJSON.networks[id].address

  const Query = new web3.eth.Contract(QueryJSON.abi, QueryAddress, {
    gasPrice: 1000000000, // 10gwei
    gasLimit: 4000000
  })

  let accounts = await web3.eth.getAccounts()

  if (accounts.length < 1) {
    await web3.eth.personal.newAccount('')
    accounts = await web3.eth.getAccounts()
  }

  const account = accounts[0]
  try {
    console.log(await Query.methods.query(account).call({ from: account }))
  } catch (e) {
    const code = await web3.eth.getCode(account)
    if (code === '0x0') {
      console.log(`${account} is an account!`)
    } else {
      console.log(account, e, code)
    }
  }

  const tokenAddress = '0xaaf19e86695e74b44d70345ee9794dc21aa94f6b'
  console.log(tokenAddress, await Query.methods.query(tokenAddress).call({ from: account }))
};

main().then(() => {
  process.exit()
}).catch((e) => {
  console.log('error', e)
})

```
result

```sh
0xEB453FB2c1f5B9F9739B2B07A8052a5cb170a9aA is an account!
0xaaf19e86695e74b44d70345ee9794dc21aa94f6b Result {
  '0': 'Tether USD',
  '1': 'USDT',
  '2': '6',
  '3': '60109970000000',
  name: 'Tether USD',
  symbol: 'USDT',
  decimals: '6',
  totalSupply: '60109970000000' }
```
