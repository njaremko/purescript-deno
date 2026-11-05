# purescript-deno

Deno bindings for Purescript

Implemented:
- [ ] [Std](https://deno.land/std@0.144.0)
  - [x] crypto (basic functionality)
  - [x] datetime
  - [x] dotenv
  - [x] fs
  - [x] http 
  - [x] log
  - [x] uuid


# Example Deno web server

An example deno web server can be found [here](https://github.com/njaremko/purescript-deno-example)

## Tests

The runtime tests use Deno 2.5.6, including the library's pinned remote standard
library imports. Build with Spago 1.0.5, then run the compiled tests with Deno
(not Node's `spago test` runner):

```sh
spago build
PURESCRIPT_DENO_TEST=runtime-fixture deno eval 'import { main } from "./output/Test.Main/index.js"; main()'
```

The fixture environment variable is checked by the environment binding test.
The tests also cover UUID validation and date parsing, formatting, and leap years.
