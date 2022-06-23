import * as mod from "https://deno.land/std@0.145.0/datetime/mod.ts";

export function parse(dateString) {
    return function (formatString) {
        return mod.parse(dateString, formatString);
    }
}

export function format(date) {
    return function (formatString) {
        return mod.format(date, formatString);
    }
}

export function isLeap(date) {
    return mod.isLeap(date);
}

export function toIMF(date) {
    return mod.toIMF(date);
}

export function weekOfYear(date) {
    return mod.weekOfYear(date);
}

export function _difference(from) {
    return function (to) {
        return function (options) {
            return Object.entries(mod.difference(from, to, options));
        }
    }
}
