pig:
	@if [ ! -d pig-0.17.0 ]; then \
		wget http://www-us.apache.org/dist/pig/pig-0.17.0/pig-0.17.0.tar.gz && \
		tar xf pig-0.17.0.tar.gz ; \
	fi

tutorial: pig
	@mkdir -p output
	@rm -rf output/tutorial
	@pig -d ERROR -x local -f examples/tutorial.pig

word-count: pig
	@mkdir -p output
	@rm -rf output/word-count
	@pig -d ERROR -x local -f examples/word-count.pig
