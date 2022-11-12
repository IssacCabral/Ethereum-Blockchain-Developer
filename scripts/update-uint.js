async function updateUint() {
  // endereço do nosso contrato
  const address = "0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8";
  // codificando parametros para a abi do contrato
  const abiArray = [
    {
      inputs: [],
      name: "myUint",
      outputs: [
        {
          internalType: "uint256",
          name: "",
          type: "uint256",
        },
      ],
      stateMutability: "view",
      type: "function",
    },
    {
      inputs: [
        {
          internalType: "uint256",
          name: "_newUint",
          type: "uint256",
        },
      ],
      name: "setMyUint",
      outputs: [],
      stateMutability: "nonpayable",
      type: "function",
    },
  ];

  // instanciando o nosso contrato
  const contractInstance = new web3.eth.Contract(abiArray, address);

  // chamando a função myUint do nosso contrato, que retorna o valor do meu inteiro
  console.log(await contractInstance.methods.myUint().call());

  // obtendo todas as accounts do ambiente remix
  let accounts = await web3.eth.getAccounts();
  // usando a função setMyUint do meu contrato
  let transactionResult = await contractInstance.methods
    .setMyUint(345)
    .send({ from: accounts[0] });
  // resultado da transação
  console.log(transactionResult);
}

updateUint();
