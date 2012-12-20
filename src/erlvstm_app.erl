%%%=============================================================================
%%% @doc ErlVSTM Application
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================

-module(erlvstm_app).
-behaviour(application).

%%%_* Exports ==================================================================

-export([ start/2
        , stop/1
        ]).

%%%_* Application callbacks ====================================================

start(_StartType, _StartArgs) ->
    erlvstm_sup:start_link().

stop(_State) ->
    ok.

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
