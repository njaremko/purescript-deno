import { copy, copySync, move, moveSync } from "https://deno.land/std@0.144.0/fs/mod.ts";

export function _copy(src) {
    return function (dest) {
        return function (options) {
            return () => copy(src, dest, options);
        }
    }
}

export function _copySync(src) {
    return function (dest) {
        return function (options) {
            return () => copySync(src, dest, options);
        }
    }
}

export function _move(src) {
    return function (dest) {
        return function (options) {
            return () => move(src, dest, options);
        }
    }
}

export function _moveSync(src) {
    return function (dest) {
        return function (options) {
            return () => moveSync(src, dest, options);
        }
    }
}
