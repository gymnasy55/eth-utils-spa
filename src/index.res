%%raw("import './index.css';")

switch ReactDOM.querySelector("#root") {
  | Some(rootElement) => {
      ReactDOM.Client.Root.render(ReactDOM.Client.createRoot(rootElement), <App />)
    }
  | None => ()
}