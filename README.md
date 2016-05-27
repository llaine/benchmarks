# Benchmarks

Tiny comparison between dlang using Vibe.d, nodejs using express and Ruby with Sinatra.

My point here is to try to figure it out with 

The all three project do the same thing which is :  

- Connecting to postgresql, fetch rows from a table and display them as json through a HTTP Server.  

## Sql dump 

50 rows in a database

All the benchmarks are made with [wg](https://github.com/wg/wrk)

# Env for all benchmarks

- OS : Fedora 23 x86_64
- Kernel : 4.4.9-300.fc23.x86_64
- Computer : Lenovo thinkpad t460s


# 10 users per second

`wrk -t10 -c10 -d10s http://localhost:3000`

- Node : v5.11.0 with express `NODE_ENV=production node app.js`
- Ruby : 2.2.3 with sinatra and Puma `rackup -E production;`
- Dlang : DMD64 D Compiler v2.071.0 with vibe.d `dub build --config=application --build=release ; ./vibed`

Seconds | Dlang         | Node            | Ruby           |
--------| ------------- |:---------------:| --------------:|
10s     | Req/Sec 717.65| Req/Sec 284.25  | Req/Sec 32.74  |
30s     | Req/Sec 632.92| Req/Sec 300.80  | Req/Sec 33.13 |
1m      | Req/Sec 755.51| Req/Sec 293.72  | Req/Sec 32.92 |


# 
