task :default => "texto/HashSlash-w2.html"
file "texto/HashSlash-w2.html" => ["texto/HashSlash.md","texto/HashSlash.erb"] do |t|
  sh "kramdown --template #{t.prerequisites[1]} #{t.prerequisites[0]} > #{t.name}"
end
