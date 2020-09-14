#!/usr/bin/env bash

#
# add kubeconfig info to tmux status line
#

kube_tmux() {
  local ctx=$(kubectl config current-context 2>/dev/null)
  local ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
  if [[ -n "$ctx" && -n "$ns" ]]; then
    local symbol=$'\u2388'
    echo "$symbol $ctx:$ns | "
  fi
}

kube_tmux
