cd "$(dirname "$0")"

cd ..

set -eu

gleam clean

gleam build

clear

erl -pa ./build/dev/erlang/*/ebin -noshell -eval 'gleam@@main:run(glychee_example_benchmark_module)'
