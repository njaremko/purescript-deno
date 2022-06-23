import * as mod from "https://deno.land/std@0.145.0/log/mod.ts";

export function _critical(message) {
    return () => mod.critical(message);
}

export function _debug(message) {
    return () => mod.debug(message);
}

export function _error(message) {
    return () => mod.error(message);
}

export function _info(message) {
    return () => mod.info(message);
}

export function _warning(message) {
    return () => mod.warning(message);
}

export function _setup(config) {
    return () => mod.setup(config);
}

export function _getLogger(name) {
    return mod.getLogger(name);
}

const { BaseHandler, ConsoleHandler, WriterHandler, FileHandler, RotatingFileHandler } = mod.handlers;

export function _createConsoleHandler(logLevel) {
    return function (options) {
        return new ConsoleHandler(logLevel, options);
    }
}

export function _createWriterHandler(logLevel) {
    return function (options) {
        return new WriterHandler(logLevel, options);
    }
}

export function _createFileHandler(logLevel) {
    return function (options) {
        return new FileHandler(logLevel, options);
    }
}

export function _createRotatingFileHandler(logLevel) {
    return function (options) {
        return new RotatingFileHandler(logLevel, options);
    }
}
