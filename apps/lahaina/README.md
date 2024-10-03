lahaina
=====

An OTP application

Build
-----

    $ rebar3 compile

Run
-----

    $ ENV="dev"
    $ rebar3 shell --apps lahaina --config "apps/lahaina/config/$ENV/sys.config"
