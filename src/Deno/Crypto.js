import { crypto } from "https://deno.land/std@0.144.0/crypto/mod.ts";

export function _encrypt(algorithm) {
    return function (key) {
        return function (data) {
            return () => crypto.encrypt(algorithm, key, data);
        }
    }
}

export function _decrypt(algorithm) {
    return function (key) {
        return function (data) {
            return () => crypto.decrypt(algorithm, key, data);
        }
    }
}

export function _sign(algorithm) {
    return function (key) {
        return function (data) {
            return () => crypto.sign(algorithm, key, data);
        }
    }
}

export function _verify(algorithm) {
    return function (key) {
        return function (signature) {
            return function (data) {
                return () => crypto.sign(algorithm, key, signature, data);
            }
        }

    }
}

export function _generateKey(algorithm) {
    return function (extractable) {
        return function (usages) {
            return () => crypto.generateKey(algorithm, extractable, usages);
        }
    }
}
