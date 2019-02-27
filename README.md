# LocalFetch

LocalFetch is a library that extends standard [Fetch Api](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) to work with native apps (iOS/macOS) It's built on top [XWKWebView](https://github.com/phongnlu/XWKWebView) library that allows bridging the JS fetch into local fetch to enable fetching data from native

## Example

There's an example project [LocalFetch Demo](https://github.com/phongnlu/localFetch-ios-macos-demo) to showcase how to use LocalFetch

## Minimum deployment target

- iOS: 10.3
- macOS: 10.14

## Build

```cmd
> scripts/build
```

Note: [Carthage required](https://github.com/Carthage/Carthage)

## Usage

- A local fetch call will looks like this

```jvascript
fetch('local://os/info', {
    method: 'GET',
    headers: {},
    body: {}
}).then(function(result) {
    // result is data that sent back from native
    console.log(result);
}).catch(function(error) {
    // error is data that sent back from native
    console.log(error);
});
```

As you can see, local fetch is seemlessly integrated into standard fetch by keeping all the spec of standard fetch. The only different is uri starts with local:// in stead of http(s)://

- The above uri will be handled by Swift as followed

```swift
let webView = WKWebView(frame: view.frame)
xwkWebView = XWKWebView(webView)
localFetch = LocalFetch(xwkWebView)
localFetch?.registerRouteBase(System(), routeBase: "os")
```

System class defined as

```swift
public class System: NSObject {
    @objc func getInfo(_ payload: AnyObject?, _ promise: XWKWebViewPromise) {
        print("payload from JS: \(payload)")
        
        let os = ProcessInfo().operatingSystemVersion
        let osStr = String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
        let nativePayload = "{\"data\": \"\(osStr)\"}"
        promise.resolve(nativePayload)
    }
}
```

## Native code registration to handle uri and mapping convention

- There's some automatic mapping between fetch uri value and Swift class method. So following convention is put in place

```jvascript
fetch('local://{routeBase}/{route}', {
    method: {method}    // either GET or POST
    headers: {},
    body: {}
}).then(function(result) {    
}).catch(function(error) {    
});
```

In order for Native to correctly handle this local:// uri, we need to register a Swift class to manage it

```swift
localFetch?.registerRouteBase({nativeClass}, routeBase: {routeBase})
```

Here, we say {nativeClass} class will manage all {routeBase} uri. Each {route} will be mapped to different method of class {nativeClass}. Note: {route} method name will have first character capitalized

- For example

```jvascript
fetch('local://fileManager/read/?param1=123&param2=test', {
    method: POST
    headers: {},
    body: {}
}).then(function(result) {    
}).catch(function(error) {    
});
```

will be mapped to

```swift
localFetch?.registerRouteBase(NativeFileManager(), routeBase: "fileManager")
```

```swift
public class NativeFileManager: NSObject {
    @objc func postRead(_ payload: AnyObject?, _ promise: XWKWebViewPromise) {
        ...
    }    
}

```