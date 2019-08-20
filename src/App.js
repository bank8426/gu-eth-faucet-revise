import React, { Component } from 'react';
import './App.css';
import Web3 from 'web3'

function getNetworkName (id){
  switch(id){
    case 1: return "Main net"
    case 3: return "Ropsten testnet"
    case 4: return "Rinkeby testnet"
    case 5: return "Goerli testnet"
    case 42: return "Kovan testnet"
    default:
        return "Unknown"
  } 
}

class App extends Component {
  state = {
    userAddress: '',
    currentNetwork: '',
    currentNetworkId: '',
  }

  async componentDidMount(){
    await window.ethereum.enable()
    this.w3 = new Web3(window.ethereum)

    const userAddress = (await this.w3.eth.getAccounts())[0]
    this.setState({userAddress})

    const currentNetworkId = await this.w3.eth.net.getId();
    const currentNetwork = getNetworkName(currentNetworkId)
    this.setState({currentNetwork,currentNetworkId})
  }




  render() {
    return (
      <div className="App">
      <p>Current Network: {this.state.currentNetwork}</p>
      <p>Your Address: {this.state.userAddress}</p>
    </div>
    )
  }
}

export default App;
