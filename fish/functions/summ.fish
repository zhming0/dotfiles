function summ --description "Use chatgpt to summarize a webpage"
  https $argv[1] \
    | npx readability-cli \
    | chatblade -c 4 --extract "parse the main content out of this html and summarize it for me"
end
