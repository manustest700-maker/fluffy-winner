// built-in include guard removal
// just in case the user has a local dependency with the same file name
#if defined _inc_requests
	#undef _inc_requests
#endif
// custom include-guard to ensure we don't duplicate
#if defined _requests_included
	#endinput
#endif
#define _requests_included

#include "status_codes"
#include "http_methods"


// -
// Request API
// -

// OnRequestFailure is only called when there is some internal failure/exception
forward OnRequestFailure(Request:id, errorCode, errorMessage[], len);
// OnWebSocketDisconnect is called when any websocket (string or JSON) closes.
forward OnWebSocketDisconnect(WebSocket:ws, bool:isJson, status, reason[], reasonLen, errorCode);

// RequestsClient initialises a new Requests client with an endpoint. The endpoint
// must include a scheme (http or https) and must not contain a path. Any
// headers set on the client are sent with every request from the client but may
// be overwritten on a per-request basis.
native RequestsClient:RequestsClient(const endpoint[], Headers:headers = Headers:-1);

// RequestHeaders constructs a headers object and returns a handle ID. This
// function is designed to only ever be used as an argument to functions that
// take `Headers:` values as those functions handle the garbage collection of
// resources allocated on the heap.
native Headers:RequestHeaders(...);

// Request performs a request to send or receive text data
native Request:Request(
    RequestsClient:id,
    const path[],
    E_HTTP_METHOD:method,
    const callback[],
    body[] = "",
    Headers:headers = Headers:-1
);

// RequestJSON performs a request to send or receive JSON data
native Request:RequestJSON(
    RequestsClient:id,
    const path[],
    E_HTTP_METHOD:method,
    const callback[],
    Node:json = Node:-1,
    Headers:headers = Headers:-1
);

// WebSocketClient creates a websocket client and establishes a connection at
// specified address. Received messages are sent to the callback which must have
// the signature: (WebSocket:ws, const data[], dataLen)
native WebSocket:WebSocketClient(const address[], const callback[]);
native WebSocketSend(WebSocket:ws, const data[]);

// JsonWebSockets are the same as above but the callback signature is:
// (JsonWebSocket:jws, Node:node)
native JsonWebSocket:JsonWebSocketClient(const address[], const callback[]);
native JsonWebSocketSend(JsonWebSocket:ws, Node:node);

// -
