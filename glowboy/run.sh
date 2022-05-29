#!/usr/bin/env bash

rebar3 release -n prod
./_build/default/rel/prod/bin/prod foreground
