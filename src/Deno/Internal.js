export const _undefined = undefined;

export function _removeUndefinedPairs(object) {
    if (typeof object === 'object' && object !== null) {
        return Object.fromEntries(
            Object.entries(object)
                .filter(([_key, val]) => val !== undefined)
        );
    }
    return object;
}
