type client
type connector
type abi = JSON.t
type value = BigInt.t

module Chain = {
  type blockExplorers
  type contracts
  type rpcUrls

  type t = {
    id: int,
    blockExplorers: blockExplorers,
    contracts: contracts,
    name: string,
    testnet: bool,
    rpcUrls: rpcUrls,
  }
}

@module("wagmi/chains") external mainnet: Chain.t = "mainnet"

type wagmiProvider
type publicClient
type configureChainsReturn = {
  publicClient: publicClient,
}
@module("wagmi")
external configureChains: (array<Chain.t>, array<wagmiProvider>) => configureChainsReturn = "configureChains"

type wagmiConnectors
type createConfigParameters = {
  autoConnect: bool,
  connectors: wagmiConnectors,
  ...configureChainsReturn,
}
type wagmiConfig
@module("wagmi")
external createConfig: createConfigParameters => wagmiConfig = "createConfig"

type transactionResponse = { hash: string }
type mode = | @as("prepared") Prepared | @as("signing") Signing | @as("sending") Sending
type writeContractParameters
type preparedResult
type preparedResponse = {
  mode: mode,
  request: writeContractParameters,
  result: option<preparedResult>,
}

type accountStatus =
  | @as("connecting") Connecting
  | @as("reconnecting") Reconnecting
  | @as("connected") Connected
  | @as("disconnected") Disconnected

type account = {
  address: Nullable.t<string>,
  connector: Nullable.t<connector>,
  isConnecting: bool,
  isReconnecting: bool,
  isConnected: bool,
  isDisconnected: bool,
  status: accountStatus,
}

type input = {
  chainId?: int,
  cacheTime?: int,
  enabled?: bool,
  scopeKey?: string,
  staleTime?: int,
  suspense?: bool,
}

type queryInput<'data> = {
  onSuccess?: Nullable.t<'data> => unit,
  onError?: Nullable.t<Exn.t> => unit,
  onSettled?: (Nullable.t<'data>, Nullable.t<Exn.t>) => unit,
  ...input,
}

type status = | @as("idle") Idle | @as("error") Error | @as("loading") Loading | @as("success") Success

type result<'data> = {
  data: Nullable.t<'data>,
  error: Nullable.t<Exn.t>,
  isIdle: bool,
  isLoading: bool,
  isSuccess: bool,
  isError: bool,
  status: status,
}

type queryResult<'data> = {
  isFetched: bool,
  isFetchedAfterMount: bool,
  isRefetching: bool,
  ...result<'data>,
}

type overrides = {
  from?: string,
  gasPrice?: string,
  gasLimit?: string,
  nonce?: string,
  value?: string,
}

type onMutateInput<'args> = {
  args: 'args,
  overrides: overrides,
}

type mutationInput<'args> = {
  args?: 'args,
  account?: string,
  value?: value,
  onMutate?: onMutateInput<'args> => unit,
  onSuccess?: Nullable.t<transactionResponse> => unit,
  onError?: Nullable.t<Exn.t> => unit,
  onSettled?: (Nullable.t<transactionResponse>, Nullable.t<Exn.t>) => unit,
  ...input,
}

type mutationReturn<'args> = {
  write?: (~config: mutationInput<'args>=?) => unit,
  writeAsync?: (~config: mutationInput<'args>=?) => Promise.t<transactionResponse>,
  reset?: unit => unit,
  ...result<string>,
}

module WagmiConfig = {
  @react.component @module("wagmi")
  external make: (~config: wagmiConfig, ~children: React.element) => React.element = "WagmiConfig"
}

@module("wagmi")
external useAccount: unit => account = "useAccount"

type signMessageReturn = {
  signMessage: unit => unit,
  ...queryResult<string>,
}
@module("wagmi")
external useSignMessage: 'a => signMessageReturn = "useSignMessage"

type balanceData = {
  decimals: int,
  formatted: string,
  symbol: string,
  value: string,
}
@module("wagmi")
external useBalance: 'a => queryResult<balanceData> = "useBalance"

type contractConfig<'args> = {
  address?: string,
  abi: abi,
  functionName: string,
  ...mutationInput<'args>
}
type prepareContractWriteReturn<'args> = { config: contractConfig<'args> }
@module("wagmi")
external usePrepareContractWrite: (~config: contractConfig<'args>=?) => prepareContractWriteReturn<'args> = "usePrepareContractWrite"

@module("wagmi")
external useContractWrite: contractConfig<'args> => mutationReturn<'args> = "useContractWrite"

type chainWithUnsupportedFlag = { unsupported: bool, ...Chain.t }
type networkReturn = { chain?: chainWithUnsupportedFlag, chains: array<Chain.t> }
@module("wagmi")
external useNetwork: unit => networkReturn = "useNetwork"

module UseContractEvent = {
  type eventLog<'args> = {
    address: string,
    args: 'args,
    blockHash: string,
    blockNumber: BigInt.t,
    data: string,
    eventName: string,
    logIndex: int,
    removed: bool,
    topics: array<string>,
    transactionHash: string,
    transactionIndex: int,
  }
  type input<'args> = {
    address: string,
    abi: JSON.t,
    eventName: string,
    listener: array<eventLog<'args>> => unit,
    chainId?: int,
  }
  @module("wagmi")
  external make: input<'args> => unit = "useContractEvent"
}