import { v5 } from "https://deno.land/std@0.145.0/uuid/mod.ts";

const { validate, generate } = v5;

export function _validate(uuid) {
    return validate(uuid);
}

export function _generate(namespace) {
    return function (data) {
        return () => generate(namespace, data);
    }
}