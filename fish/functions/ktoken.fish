# Obtain a K8S service account token for an service token
# Example> ktoken <ns> <account name>
function ktoken
  set acc $argv[1]
  set secret (k get serviceaccount/$acc -o jsonpath='{.secrets[0].name}')
  k get secret $secret -o jsonpath='{.data.token} ' | base64 -d
end
