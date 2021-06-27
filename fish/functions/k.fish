function k --description "A context aware kubectl"
  if set -q KUBE_CTX && test -n "$KUBE_CTX"
    set ctx $KUBE_CTX
  else
    set ctx (kubectl config current-context)
  end
  if set -q KUBE_NS && test -n "$KUBE_NS"
    kubectl --context=$ctx -n $KUBE_NS $argv
  else
    kubectl --context=$ctx $argv
  end
end
