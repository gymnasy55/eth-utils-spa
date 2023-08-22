@react.component
let make = (~children: React.element) => {
  <div className="w-full h-full bg-black text-white flex items-center justify-center">{children}</div>
}