type projectId = string
type w3mProviderParameters = {
  projectId: projectId,
}
@module("@web3modal/ethereum") 
external w3mProvider: w3mProviderParameters => Wagmi.wagmiProvider = "w3mProvider"

type w3mConnectorsParameters = {
  chains: array<Wagmi.Chain.t>,
  ...w3mProviderParameters,
}
@module("@web3modal/ethereum")
external w3mConnectors: w3mConnectorsParameters => Wagmi.wagmiConnectors = "w3mConnectors"

type ethereumClientInstance
@module("@web3modal/ethereum") @new
external ethereumClient: (Wagmi.wagmiConfig, array<Wagmi.Chain.t>) => ethereumClientInstance = "EthereumClient"

module Web3Modal = {
  @react.component @module("@web3modal/react")
  external make: (~projectId: projectId, ~ethereumClient: ethereumClientInstance) => React.element = "Web3Modal"
}

module Web3Button = {
  type showOrHide = | @as("show") Show | @as("hide") Hide

  @react.component @module("@web3modal/react")
  external make: (~icon: showOrHide=?, ~label: string=?, ~balance: showOrHide=?) => React.element = "Web3Button"
}