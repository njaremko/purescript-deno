export function body(req) {
    return req.body;
}

export function bodyUsed(req) {
    return req.bodyUsed;
}

export function cache(req) {
    return req.cache;
}

export function credentials(req) {
    return req.credentials;
}

export function destination(req) {
    return req.destination;
}

export function _headers(req) {
    return req.headers.entries();
}

export function integrity(req) {
    return req.integrity;
}

export function method(req) {
    return req.method;
}
export function mode(req) {
    return req.mode;
}
export function priority(req) {
    return req.priority;
}
export function redirect(req) {
    return req.redirect;
}
export function referrer(req) {
    return req.referrer;
}

export function referrerPolicy(req) {
    return req.referrerPolicy;
}

export function url(req) {
    return req.url;
}

export function _json(req) {
    return () => req.json();
}

export function _text(req) {
    return () => req.text();
}
