test:
	mocha --recursive --reporter nyan

watch:
	mocha --recursive --reporter min --watch

start:
	node server.js

coverage:
	jscoverage src/app src/app-cov
	APPLICATION_COVERAGE=1 mocha --recursive --reporter html-cov > test/coverage.html
	rm -rf src/app-cov

.PHONY: test