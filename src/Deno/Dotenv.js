import { config, configSync } from "https://deno.land/std@0.144.0/dotenv/mod.ts";

export function _config(options) {
    const cleanOptions = Object.fromEntries(
        Object.entries(options)
            .filter(([_key, val]) => val !== undefined)
    );
    return () => config(cleanOptions).then(v => Object.entries(v));
}

export function _configSync(options) {
    const cleanOptions = Object.fromEntries(
        Object.entries(options)
            .filter(([_key, val]) => val !== undefined)
    );
    return () => Object.entries(configSync(cleanOptions));
}