#!/usr/bin/env bash

#
# add kubeconfig info to tmux status line
#

kube_tmux() {
  local ctx=$(kubectl config current-context 2>/dev/null)
  local ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
  local out="⎈"
  if [[ -n "$ctx" ]]; then
    ctx="${ctx#arn:aws:eks:}"
    region="${ctx%%:*}"
    name="${ctx##*/}"
    out="$out $region/$name"
  fi
  if [[ -n "$ns" ]]; then
    out="$out:$ns"
  fi
  echo "| $out |"
}

kube_tmux
