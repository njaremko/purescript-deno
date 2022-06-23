import { v4 } from "https://deno.land/std@0.145.0/uuid/mod.ts";

const { validate } = v4;

export function _validate(uuid) {
    return validate(uuid);
}