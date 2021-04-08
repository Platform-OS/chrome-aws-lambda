.PHONY: clean

clean:
	rm -f $(lastword $(MAKECMDGOALS))

%.zip:
	mkdir -p nodejs/
	npm install  --prefix nodejs/ lambdafs@~1.3.0 puppeteer-core@~5.5.0 --no-bin-links --no-optional --no-package-lock --no-save --no-shrinkwrap && cd -
	mkdir -p nodejs/node_modules/chrome-aws-lambda/
	npm pack
	tar --directory nodejs/node_modules/chrome-aws-lambda/ --extract --file chrome-aws-lambda-*.tgz --strip-components=1
	rm chrome-aws-lambda-*.tgz
	mkdir -p $(dir $@)
	zip -9 --filesync --move --recurse-paths $@ nodejs/

.DEFAULT_GOAL := chrome_aws_lambda.zip
