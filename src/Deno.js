export function _listen(options) {
    return () => Deno.listen(options);
}

export function _listenTls(options) {
    return () => Deno.listenTls(options);
}

export function _env() {
    return Object.entries(Deno.env.toObject());
}