#!/bin/bash
set -eu

cd typing
mix compile
mix dialyzer > log/dialyzer.log 2> log/dialyzer.err.log