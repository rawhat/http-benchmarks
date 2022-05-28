# http-benchmarks

This repo is for comparing [mist](https://github.com/rawhat/mist) to some other webserver libraries.

## Setup

This was run with both the client and servers on the same machine.  The specs are:

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
|Express|17549.7 req/s|17295.07 req/s|17313.4 req/s|17225.33 req/s|16600.9 req/s|17155.63 req/s|17036.07 req/s
|Express Cluster|17165.53 req/s|32899.63 req/s|52555.47 req/s|66321.77 req/s|69829.2 req/s|79016 req/s|81722.9 req/s
|Bandit|41269.83 req/s|48816.6 req/s|92471.17 req/s|122576.6 req/s|147419.1 req/s|176916.63 req/s|182736.93 req/s
|Cowboy|32874.47 req/s|40446.03 req/s|68811.27 req/s|86630.23 req/s|97340.2 req/s|124425.13 req/s|152099.87 req/s
|Mist|54891.1 req/s|71473.1 req/s|125455.2 req/s|162082.07 req/s|195681.13 req/s|215054.93 req/s|227644.3 req/s
|Go|60487.63 req/s|106932.23 req/s|156950 req/s|184724.03 req/s|194572.5 req/s|225728.97 req/s|256995.6 req/s

#### `GET /user/:id`

|Framework|Concurrency 1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|15812.73 req/s|15960.47 req/s|16090.83 req/s|15299.13 req/s|15301.27 req/s|15722.7 req/s|15101.33 req/s
|Express Cluster|14420.83 req/s|27856.5 req/s|44224.5 req/s|56401.47 req/s|54391.03 req/s|61523.63 req/s|64558.33 req/s
|Bandit|38364.1 req/s|47729.1 req/s|84233.17 req/s|115218.97 req/s|140101.8 req/s|169721.87 req/s|175133.5 req/s
|Cowboy|28977.7 req/s|36823.47 req/s|65675.07 req/s|84792.73 req/s|95764.33 req/s|116876.1 req/s|130122.13 req/s
|Mist|47370.87 req/s|85973.33 req/s|123312.2 req/s|137837.8 req/s|155174.2 req/s|181289.77 req/s|193269.7 req/s
|Go|55997.8 req/s|93639.93 req/s|151421.67 req/s|178652.5 req/s|188503.83 req/s|220090.2 req/s|249689.37 req/s

#### `POST /user`

|Framework|Concurrency 1|2|4|6|8|12|16
|---|---|---|---|---|---|---|---
|Express|22111.67 req/s|22433.23 req/s|22401.27 req/s|22309.57 req/s|21989.8 req/s|21713.4 req/s|20879.53 req/s
|Express Cluster|18704.03 req/s|35970.53 req/s|55305.4 req/s|62016.03 req/s|64739.73 req/s|70418.07 req/s|73917.3 req/s
|Bandit|32241.9 req/s|40495.73 req/s|72393.33 req/s|95072.53 req/s|113830.7 req/s|124198.2 req/s|126024.1 req/s
|Cowboy|14277.53 req/s|17917.47 req/s|26195.47 req/s|30797.63 req/s|35437.47 req/s|43443 req/s|49795.6 req/s
|Mist|43464.8 req/s|74902 req/s|107876 req/s|133412 req/s|148325.4 req/s|167869.5 req/s|182376.73 req/s
|Go|27744.8 req/s|38511.33 req/s|48847.07 req/s|43422.13 req/s|39789.93 req/s|37867.4 req/s|36186 req/s

![GET /](/results/GET%20_.png)

![GET /user/:id](/results/GET%20_user_%20id.png)

![POST /user](/results/POST%20_user.png)
