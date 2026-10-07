build
docker build -t x11-test .



run
docker run --name x11-test -p 6080:6080 x11-test
