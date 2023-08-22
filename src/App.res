let chains = [Wagmi.mainnet]
let projectId = Env.projectId
let { publicClient }: Wagmi.configureChainsReturn = Wagmi.configureChains(chains, [Web3Modal.w3mProvider({ projectId: projectId })])
let config = Wagmi.createConfig({
  autoConnect: true,
  connectors: Web3Modal.w3mConnectors({ projectId, chains }),
  publicClient,
})
let ethereumClient = Web3Modal.ethereumClient(config, chains)


@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  let page = React.useMemo(() => {
    switch url.path {
      | list{} => <Home />
      | _ => <PageNotFound />
    }
  }, [url.path])
  
  

  <React.Fragment>
    <Wagmi.WagmiConfig config>
      <Layout>
        {page}
      </Layout>
    </Wagmi.WagmiConfig>
    <Web3Modal.Web3Modal projectId ethereumClient />
  </React.Fragment>
}