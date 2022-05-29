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
  - Express (non-cluster)
  - Express (cluster of 16)
  - Bandit
  - Cowboy
  - Mist
  - Go (net/http)

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
|Bandit|40636.1 req/s|48616.6 req/s|89218.1 req/s|121324.57 req/s|140692.9 req/s|168422.6 req/s|174439.97 req/s
|Cowboy|32380.2 req/s|41219.6 req/s|66815.17 req/s|87140.67 req/s|88028.17 req/s|114629.37 req/s|134766.27 req/s
|Mist|54537.7 req/s|72473.33 req/s|122451.3 req/s|173601.63 req/s|201595.07 req/s|226361.5 req/s|236711.13 req/s
|Go|60466.37 req/s|108339.5 req/s|155894.77 req/s|185027.13 req/s|194863 req/s|226281 req/s|257714.13 req/s

#### `GET /user/:id`

|Framework|Concurrency 1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|15690.17 req/s|15718.67 req/s|15633.17 req/s|15404.17 req/s|15534.03 req/s|15117.8 req/s|15197.07 req/s
|Express Cluster|14059.97 req/s|26459.97 req/s|47776.2 req/s|53187.03 req/s|53674.5 req/s|60694.4 req/s|64454.93 req/s
|Bandit|36371.9 req/s|43202.97 req/s|76317.23 req/s|114231.53 req/s|135576.4 req/s|167579.63 req/s|171393.03 req/s
|Cowboy|28940.37 req/s|35997.2 req/s|65977.53 req/s|83173.63 req/s|97591.57 req/s|118077.53 req/s|131697.87 req/s
|Mist|51228.93 req/s|73286.4 req/s|124918.53 req/s|145152.7 req/s|161114.8 req/s|185556.97 req/s|196957.47 req/s
|Go|55842.4 req/s|93958.8 req/s|151009.3 req/s|177738.43 req/s|188326.63 req/s|220403.4 req/s|250316.67 req/s

#### `POST /user`

|Framework|Concurrency 1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|21904.07 req/s|21728.5 req/s|21406.9 req/s|21289.97 req/s|20960.03 req/s|21088.23 req/s|21557.93 req/s
|Express Cluster|18093.77 req/s|33629.87 req/s|53670.23 req/s|62223.87 req/s|66794 req/s|72450.97 req/s|75638.7 req/s
|Bandit|29676.73 req/s|35253.47 req/s|67166.4 req/s|90160.87 req/s|101414.43 req/s|118613.2 req/s|124483.13 req/s
|Cowboy|14729.67 req/s|18368.4 req/s|25981.9 req/s|31382.8 req/s|36064.83 req/s|44372.07 req/s|49802.77 req/s
|Mist|41165 req/s|69996.67 req/s|97834 req/s|117165.37 req/s|131711.07 req/s|150727.47 req/s|162182.4 req/s
|Go|31869 req/s|53810.17 req/s|83249.23 req/s|98007.67 req/s|98963.8 req/s|101635.4 req/s|109319.5 req/s

![GET /](/results/GET%20_.png)

![GET /user/:id](/results/GET%20_user_%20id.png)

![POST /user](/results/POST%20_user.png)
