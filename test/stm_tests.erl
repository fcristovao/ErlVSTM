%%%=============================================================================
%%% @doc STM tests
%%% @copyright 2012 Filipe Cristóvão
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(stm_tests).

%%%_* Exports ==================================================================
-compile(export_all).

%%%_* Includes =================================================================

-include_lib("eunit/include/eunit.hrl").

%%%_* Constants definition =====================================================

%%%_* Types definition =========================================================

%%%_* Code =====================================================================

simple_test() ->
  %application:start(sasl),
  application:start(erlvstm),

  TInt = tvar:new(0),
  TBool = tvar:new(false),
  TList = tvar:new([]),

  stm:atomic(
  	fun() ->
  		tvar:set(TInt, 1)
  	end
  	),

  ?debugFmt("~w~n", [tvar:get(TInt)]).

  %tvar:set(TInt, 1).

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
