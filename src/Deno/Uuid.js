import * as mod from "https://deno.land/std@0.145.0/uuid/mod.ts";

export function isNil(uuid) {
    return mod.isNil(uuid);
}

export function _validate(uuid) {
    return mod.validate(uuid);
}

export function version(uuid) {
    return mod.version(uuid);
}

export const nil_uuid = mod.NIL_UUID;