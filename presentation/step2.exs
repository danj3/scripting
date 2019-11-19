#!/usr/bin/env elixir

IO.puts("hello world")

# Make myself executable:
File.chmod( __ENV__.file, 0o755 )
