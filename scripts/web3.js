async function main(){
  const accounts = await web3.eth.getAccounts()
  const balance = await web3.eth.getBalance(accounts[0]);

  console.log(web3.utils.fromWei(balance, "ether"))
}

main()