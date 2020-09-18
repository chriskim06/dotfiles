#!/usr/bin/env bash

#
# add kubeconfig info to tmux status line
#

kube_tmux() {
  local ctx=$(kubectl config current-context 2>/dev/null)
  local ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
  local out=""
  if [[ -n "$ctx" ]]; then
    out="$ctx"
  fi
  if [[ -n "$ns" ]]; then
    out="$out:$ns"
  fi
  if [[ -n "$out" ]]; then
    local symbol=$'\u2388'
    echo "$symbol $out | "
  fi
}

kube_tmux
