# http-benchmarks

This repo is for comparing [mist](https://github.com/rawhat/mist) to some other webserver libraries.

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

|Framework|1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|8952.97|10398.35|10453.25|10726.25|10954.96|11140.63|11371.71
|Flask|4722.5|9277.17|16023.98|21834.93|24013.25|24965.03|25074.79
|Bandit|10557.88|17027.62|28056.04|34736.18|37160.05|35765.72|34239.14
|Cowboy|12428.26|13945.09|27476.05|34111.56|35330.74|34133.07|33449.08
|Mist|13811.33|19193.43|31206.05|35070.37|35175.94|34335.81|33713.62

#### `GET /user/:id`

|Framework|1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|8476.3|9949.01|9860.32|9879.97|10179.87|10464.82|10776.43
|Flask|4484.78|8886.25|15448.45|21158.42|23167.78|23578.02|23846.8
|Bandit|10104.61|16774.07|26835.23|32081.17|34386.5|34628.57|33622.31
|Cowboy|11684.54|18342.67|28752.03|34206.92|33481.84|33029.61|32071.79
|Mist|13140.68|17425.42|32065.74|34504.78|34178.63|32732.24|31909.85

#### `POST /user`

|Framework|1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|10528.1|12473.9|12698.34|13029.17|13339.65|13573.34|13739.57
|Flask|3922.71|7752.45|13396.61|15671.91|17333.76|17734.77|17883.44
|Bandit|9942.05|16444.54|25495.91|32302.55|34317.92|34563.48|33021.81
|Cowboy|10736.79|17348.6|26738.27|32619.88|33145.65|31880.68|31114.89
|Mist|10614.53|16528.11|28484.6|32541.95|32069.02|31475.89|30745.45

![GET /](/results/GET%20_.png)

![GET /user/:id](/results/GET%20_user_%20id.png)

![POST /user](/results/POST%20_user.png)
