# Benchmarks

Tiny comparison between dlang using Vibe.d, nodejs using express and Ruby with Sinatra.

My point here is to do a benchmark on a real daily use case, such as loading n entries from a DB and showing them as JSON using a normal framework. By normal I mean something that is not too much low level.

## Sql dump 

1500 entries in a database selecting only 100

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
