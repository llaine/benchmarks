# Benchmarks

Tiny comparison between dlang using Vibe.d, nodejs using express and JRuby with Roda

My point here is to do a benchmark on a real daily use case, such as loading n entries from a DB and showing them as JSON using a normal framework. By normal I mean something that is not too much fancy with early optimisation.

## Sql dump 

1500 entries in a database selecting only 100

All the benchmarks are made with [wrk](https://github.com/wg/wrk)

# Env for all benchmarks

- OS : Fedora 23 x86_64
- Kernel : 4.4.9-300.fc23.x86_64
- Computer : Lenovo thinkpad t460s


# 10 users per second

Command used : `wrk -t10 -c10 -d10s http://localhost:3000`

- Node : v5.11.0 with express `NODE_ENV=production node app.js`
- JRuby : JRuby 9.2.1.0 with roda and torquebox `torquebox jar ; java -jar ruby.jar;`
- Dlang : DMD64 D Compiler v2.071.0 with vibe.d `dub build --config=application --build=release ; ./vibed`

Seconds | Dlang         | Node            | JRuby          |
--------| ------------- |:---------------:|---------------:|
10s     | Req/Sec 717.65| Req/Sec 284.25  | Req/Sec 298.11 |
30s     | Req/Sec 632.92| Req/Sec 300.80  | Req/Sec 290.30 |
1m      | Req/Sec 755.51| Req/Sec 293.72  | Req/Sec 377.86 |


## Dlang with ldc compiler

`dub build --config=application --build=release --compiler=ldc2`

10 threads and 10 connections for 1 minute

Stats |  Avg    |  Stdev  | Max     | +/- Stdev
-----------|---------|---------|---------|----------
Latency    |  640.81us |431.47us  | 33.98ms | 96.38%
Req/Sec    |  1.66k  |103.20   | 1.82k    | 88.50%
    
  496744 requests in 1.00m, 827.61MB read
Requests/sec:   8278.27
Transfer/sec:     13.79MB
