docker-build:
	docker build --rm -t nest .

docker-run:
	docker run -it --rm --init --name nest -p 3000:3000 nest
