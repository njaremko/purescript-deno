

export function _listen(options) {
    return () => Deno.listen(options);
}

export function _listenTls(options) {
    return () => Deno.listenTls(options);
}
