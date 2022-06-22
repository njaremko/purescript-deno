"use strict";

import * as server from "https://deno.land/std@0.144.0/http/server.ts";

export function _serve(request) {
    return function (serveInit) {
        return () => server.serve(request, serveInit);
    }
}

export function _createResponse(body) {
    return function (options) {
        return new Response(body, options);
    }
}

export function _getCookies(headers) {
    return server.getCookies(headers);
}

export function _setCookies(headers) {
    return function (cookie) {
        return () => server.setCookies(headers, cookie);
    }

}

export function _deleteCookie(headers) {
    return function (name) {
        return function (attributes) {
            return () => server.deleteCookie(headers, name, attributes);
        }
    }
}