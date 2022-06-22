import { config } from "https://deno.land/std@$STD_VERSION/dotenv/mod.ts";

export function _config(options) {
    return () => config(options);
}