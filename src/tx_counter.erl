%%%=============================================================================
%%% @doc 
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================

-module(tx_counter).

%%%_* Exports ==================================================================
-export([ get/0
        , get_and_increment/0
        , increment_and_get/0
        ]).

%%%_* Includes =================================================================

-include_lib("tx_counter_gen_server_messages.hrl").

%%%_* Constants definition =====================================================

%%%_* Types definition =========================================================

%%%_* Code =====================================================================

get() ->
  gen_server:call(tx_counter_gen_server, {?get}).

get_and_increment() ->
  gen_server:call(tx_counter_gen_server, {?get_and_increment}).

increment_and_get() ->
  gen_server:call(tx_counter_gen_server, {?increment_and_get}).

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
