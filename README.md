# http-benchmarks

This repo is for comparing [mist](https://github.com/rawhat/mist) to some other webserver libraries.

NOTE:  I just updated the test runner to use a different program.  The data
hasn't been updated to reflect that, so just keep that in mind until I get
to that.  Thanks!

## Setup

This initial pass, which likely will be redone at some point, was run with both the client and servers on the same machine.  The specs are:

|Part|Spec|
|---|---|
|OS|   Arch Linux 5.17.9|
|CPU|  i7-11800H (16 thread)|
|RAM|  32GB|

The frameworks tested are:
  - Express (non-cluster)
  - Flask + Gunicorn (6 workers)
  - Bandit
  - Cowboy
  - Mist

You can view the tests in `run.sh` but the cases are:

    - GET / -> ""
    - GET /user/:id -> id
    - POST /user -> <body>

Each application was tested with [Apache Bench](https://httpd.apache.org/docs/2.4/programs/ab.html) with 200,000 requests for each case noted above.  These tests were repeated with the concurrency flag set to 1, 2, 4, 6, 8, 12, and 16.

## Results

#### `GET /`

|Framework|Concurrency 1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|8952.97 req/s|10398.35 req/s|10453.25 req/s|10726.25 req/s|10954.96 req/s|11140.63 req/s|11371.71 req/s
|Flask|4722.5 req/s|9277.17 req/s|16023.98 req/s|21834.93 req/s|24013.25 req/s|24965.03 req/s|25074.79 req/s
|Bandit|10557.88 req/s|17027.62 req/s|28056.04 req/s|34736.18 req/s|37160.05 req/s|35765.72 req/s|34239.14 req/s
|Cowboy|12428.26 req/s|13945.09 req/s|27476.05 req/s|34111.56 req/s|35330.74 req/s|34133.07 req/s|33449.08 req/s
|Mist|13811.33 req/s|19193.43 req/s|31206.05 req/s|35070.37 req/s|35175.94 req/s|34335.81 req/s|33713.62 req/s

#### `GET /user/:id`

|Framework|Concurrency 1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|8476.3 req/s|9949.01 req/s|9860.32 req/s|9879.97 req/s|10179.87 req/s|10464.82 req/s|10776.43 req/s
|Flask|4484.78 req/s|8886.25 req/s|15448.45 req/s|21158.42 req/s|23167.78 req/s|23578.02 req/s|23846.8 req/s
|Bandit|10104.61 req/s|16774.07 req/s|26835.23 req/s|32081.17 req/s|34386.5 req/s|34628.57 req/s|33622.31 req/s
|Cowboy|11684.54 req/s|18342.67 req/s|28752.03 req/s|34206.92 req/s|33481.84 req/s|33029.61 req/s|32071.79 req/s
|Mist|13140.68 req/s|17425.42 req/s|32065.74 req/s|34504.78 req/s|34178.63 req/s|32732.24 req/s|31909.85 req/s

#### `POST /user`

|Framework|Concurrency 1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|10528.1 req/s|12473.9 req/s|12698.34 req/s|13029.17 req/s|13339.65 req/s|13573.34 req/s|13739.57 req/s
|Flask|3922.71 req/s|7752.45 req/s|13396.61 req/s|15671.91 req/s|17333.76 req/s|17734.77 req/s|17883.44 req/s
|Bandit|9942.05 req/s|16444.54 req/s|25495.91 req/s|32302.55 req/s|34317.92 req/s|34563.48 req/s|33021.81 req/s
|Cowboy|10736.79 req/s|17348.6 req/s|26738.27 req/s|32619.88 req/s|33145.65 req/s|31880.68 req/s|31114.89 req/s
|Mist|10614.53 req/s|16528.11 req/s|28484.6 req/s|32541.95 req/s|32069.02 req/s|31475.89 req/s|30745.45 req/s

![GET /](/results/GET%20_.png)

![GET /user/:id](/results/GET%20_user_%20id.png)

![POST /user](/results/POST%20_user.png)
