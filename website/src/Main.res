// Vite injects the deploy base ("/" locally, "/prescriptive/" on Pages).
// The router uses it as its base path so client-side navigation and deep
// links resolve correctly under a subpath.
let baseUrl: string = %raw(`import.meta.env.BASE_URL`)

Router.init(~basePath=baseUrl, ())

View.mountById(<App />, "app")
