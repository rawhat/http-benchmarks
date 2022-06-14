# http-benchmarks

This repo is for comparing [mist](https://github.com/rawhat/mist) to some other webserver libraries.

## Setup

This was run with both the client and servers on the same machine.

The specs are:

|Part|Spec|
|---|---|
|OS|   Arch Linux 5.17.9|
|CPU|  i7-11800H (16 thread)|
|RAM|  32GB|

The frameworks tested are:
  - Express (18.3.0?)
  - Express 16-cluster (18.3.0?)
  - Bandit (OTP 25.0.1 / Elixir 1.13.4)
  - Cowboy (OTP 25.0.1)
  - Mist (OTP 25.0.1)
  - Go (1.18)

Each of these sample projects has a `run.sh` file in its respective directory.
That's what I have been executing to start up the server.  These should
hopefully cover the "production" build for these.  Obviously please tell me
if you think I should be running something differently!  I want these results
to be as fair and explanatory as possible (for a relatively synthetic
benchmark, obviously).

NOTE:  I previously had flask + gunicorn in the test results, but was unable
to get the runner script executions to pass.  I'm not really sure why that's
happening at the moment, but for now I just omitted that case.

You can view the tests in `run.sh` but the cases are:

    - GET / -> ""
    - GET /user/:id -> id
    - POST /user -> <body>

Each application was tested with [h2load](https://nghttp2.org/documentation/h2load-howto.html) with 30s for each case noted above.  These tests were repeated with the concurrency flag set to 1, 2, 4, 6, 8, 12, and 16.

## Results

#### `GET /`

|Framework|Concurrency 1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|17184 req/s|16193.47 req/s|16971.07 req/s|16946.93 req/s|16815.9 req/s|16877.07 req/s|16913.47 req/s
|Express Cluster|16612.93 req/s|31835.1 req/s|52126.37 req/s|65902.03 req/s|69222.5 req/s|78587.9 req/s|82738.83 req/s
|Bandit|41622.87 req/s|50579.63 req/s|92149 req/s|116914.7 req/s|148518.73 req/s|180819.17 req/s|187722.13 req/s
|Cowboy|33481.43 req/s|41912.3 req/s|70215.47 req/s|91740.57 req/s|100475.73 req/s|131264.6 req/s|154639.97 req/s
|Mist|55268.87 req/s|72065.57 req/s|123361.47 req/s|167484.27 req/s|197281.13 req/s|220354.27 req/s|242388.17 req/s
|Go|60466.37 req/s|108339.5 req/s|155894.77 req/s|185027.13 req/s|194863 req/s|226281 req/s|257714.13 req/s
							
#### `GET /user/:id`

|Framework|Concurrency 1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|15690.17 req/s|15718.67 req/s|15633.17 req/s|15404.17 req/s|15534.03 req/s|15117.8 req/s|15197.07 req/s
|Express Cluster|14059.97 req/s|26459.97 req/s|47776.2 req/s|53187.03 req/s|53674.5 req/s|60694.4 req/s|64454.93 req/s
|Bandit|38236.63 req/s|47075.03 req/s|89549.5 req/s|116914.7 req/s|135168.3 req/s|148915.97 req/s|155122.33 req/s
|Cowboy|29778.4 req/s|36562.7 req/s|66019.6 req/s|88782.07 req/s|102135.43 req/s|116457.77 req/s|129921.97 req/s
|Mist|51840.1 req/s|89592.57 req/s|131851.4 req/s|157122.17 req/s|156627.9 req/s|181680.07 req/s|191441.47 req/s
|Go|55842.4 req/s|93958.8 req/s|151009.3 req/s|177738.43 req/s|188326.63 req/s|220403.4 req/s|250316.67 req/s
							
#### `POST /user`

|Framework|Concurrency 1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|21904.07 req/s|21728.5 req/s|21406.9 req/s|21289.97 req/s|20960.03 req/s|21088.23 req/s|21557.93 req/s
|Express Cluster|18093.77 req/s|33629.87 req/s|53670.23 req/s|62223.87 req/s|66794 req/s|72450.97 req/s|75638.7 req/s
|Bandit|33234.4 req/s|39841.9 req/s|66952.2 req/s|85157.2 req/s|104610.17 req/s|124608.17 req/s|126364.5 req/s
|Cowboy|14431.3 req/s|18652.87 req/s|26055 req/s|31390.5 req/s|35715.57 req/s|43732.97 req/s|49530.67 req/s
|Mist|41025.9 req/s|65517.67 req/s|89817.23 req/s|109170.87 req/s|122290.8 req/s|140194.8 req/s|152122.57 req/s
|Go|31869 req/s|53810.17 req/s|83249.23 req/s|98007.67 req/s|98963.8 req/s|101635.4 req/s|109319.5 req/s

![GET /](/results/GET%20_.png)

![GET /user/:id](/results/GET%20_user_%20id.png)

![POST /user](/results/POST%20_user.png)
