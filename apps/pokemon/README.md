pokemon
=====

An OTP application

Build
-----

    $ rebar3 compile

Run
-----

    $ mkdir -p ebin
    $ rm -f ebin/*.beam
    $ erlc -W0 +debug_info -o ebin/ src/*.erl
    $ erl -pa eberl -pa ebin -shell -eval 'application:start(pokemon_app)'
    erl> pokemon_app:run().
