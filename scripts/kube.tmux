#!/usr/bin/env bash

#
# add kubeconfig info to tmux status line
#

kube_tmux() {
  local ctx=$(kubectl config current-context 2>/dev/null)
  local ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
  local symbol=$'\u2388'
  local out="$symbol"
  if [[ -n "$ctx" ]]; then
    out="$out $ctx"
  fi
  if [[ -n "$ns" ]]; then
    out="$out:$ns"
  fi
  echo "$out | "
}

kube_tmux
