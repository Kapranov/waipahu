build: deps
	rebar3 compile
deps:
	rebar3 deps
run: build
	./start.sh
test: build
	rebar3 ct skip_deps=true
test_full: build
	rebar3 eunit
	rebar3 ct
clean:
	rebar3 clean
