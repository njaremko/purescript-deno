import { crypto } from "https://deno.land/std@0.144.0/crypto/mod.ts";

export function _encrypt(algorithm) {
    const cleanedAlgorithm = Object.fromEntries(
        Object.entries(algorithm)
            .filter(([_key, val]) => val !== undefined)
    );
    return function (key) {
        return function (data) {
            return () => crypto.encrypt(cleanedAlgorithm, key, data);
        }
    }
}

export function _decrypt(algorithm) {
    const cleanedAlgorithm = Object.fromEntries(
        Object.entries(algorithm)
            .filter(([_key, val]) => val !== undefined)
    );
    return function (key) {
        return function (data) {
            return () => crypto.decrypt(cleanedAlgorithm, key, data);
        }
    }
}

export function _sign(algorithm) {
    const cleanedAlgorithm = Object.fromEntries(
        Object.entries(algorithm)
            .filter(([_key, val]) => val !== undefined)
    );
    return function (key) {
        return function (data) {
            return () => crypto.sign(cleanedAlgorithm, key, data);
        }
    }
}

export function _verify(algorithm) {
    const cleanedAlgorithm = Object.fromEntries(
        Object.entries(algorithm)
            .filter(([_key, val]) => val !== undefined)
    );
    return function (key) {
        return function (signature) {
            return function (data) {
                return () => crypto.sign(cleanedAlgorithm, key, signature, data);
            }
        }

    }
}

export function _generateKey(algorithm) {
    const cleanedAlgorithm = Object.fromEntries(
        Object.entries(algorithm)
            .filter(([_key, val]) => val !== undefined)
    );
    return function (extractable) {
        return function (usages) {
            return () => crypto.generateKey(cleanedAlgorithm, extractable, usages);
        }
    }
}