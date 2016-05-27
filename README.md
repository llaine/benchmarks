# Benchmarks
Tiny comparison between dlang using Vibe.d, nodejs using express and Ruby with Sinatra

The all three project do the same thing which is :  
- Connecting to postgresql, fetch rows from a table and display them as json through a HTTP Server.  

All the benchmarks are made with [wg](https://github.com/wg/wrk)

# Env for all benchmarks

OS : Fedora 23 x86_64
Kernel : 4.4.9-300.fc23.x86_64
Computer : Lenovo thinkpad t460s


# First benchmark 
Node : v5.11.0 with express 
Ruby : 2.2.3 with sinatra
Dlang : DMD64 D Compiler v2.071.0 with vibe.d

Seconds | Dlang         | Node          | Ruby  |
--------| ------------- |:-------------:| -----:|
10s     | col 3 is      | right-aligned | $1600 |
30s     | col 2 is      | centered      |   $12 |
1m      | zebra stripes | are neat      |    $1 |
5m      | zebra stripes | are neat      |    $1 |
10m     | zebra stripes | are neat      |    $1 |
