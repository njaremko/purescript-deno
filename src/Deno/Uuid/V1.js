import { v1 } from "https://deno.land/std@0.145.0/uuid/mod.ts";

const { generate, validate } = v1;

export function _generate(options) {
    return function (buf) {
        return function (offset) {
            return generate(options, buf, offset);
        }
    }
}

export function _validate(uuid) {
    return validate(uuid);
}