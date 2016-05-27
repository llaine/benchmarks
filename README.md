# Benchmarks

Tiny comparison between dlang using Vibe.d, nodejs using express and Ruby with Sinatra

The all three project do the same thing which is :  

- Connecting to postgresql, fetch rows from a table and display them as json through a HTTP Server.  

All the benchmarks are made with [wg](https://github.com/wg/wrk)

# Env for all benchmarks

- OS : Fedora 23 x86_64
- Kernel : 4.4.9-300.fc23.x86_64
- Computer : Lenovo thinkpad t460s


# 10 users per second

`wrk -t10 -c10 -d10s http://localhost:3000`

- Node : v5.11.0 with express `node app.js`
- Ruby : 2.2.3 with sinatra and Puma `rackup -E production;`
- Dlang : DMD64 D Compiler v2.071.0 with vibe.d `dub build --config=application --build=release ; ./vibed`

Seconds | Dlang         | Node              | Ruby           |
--------| ------------- |:-----------------:| --------------:|
10s     | Req/Sec 10.41 | Req/Sec 223.25  | Req/Sec 31.40  |
30s     | Req/Sec 4.37k | Req/Sec 272.95  | Req/Sec 31.56 |
1m      | Req/Sec 3.49  | Req/Sec 293.03  | Req/Sec 29.44 |


# 
