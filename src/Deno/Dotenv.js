import { config, configSync } from "https://deno.land/std@0.144.0/dotenv/mod.ts";

export function _config(options) {
    return () => config(options).then(v => Object.entries(v));
}

export function _configSync(options) {
    return () => Object.entries(configSync(options));
}
