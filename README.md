# vcmiserver-docker-full

VCMI server image for docker that include all required game assets.

To run the server use:
`$ docker run -d --name=vcmi3031 --restart=always --cpu-period=50000 --cpu-quota=25000 --memory=50M --memory-swap=80M -p 3031:3030 -t -i arseniyshestakov/vcmiserver-docker-full`

Server have very low requirements and shoudn't use a lot of RAM even after dozens of months.
