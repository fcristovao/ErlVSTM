%%% -*- erlang-indent-level: 2 -*-
%%%=============================================================================
%%% @doc Main file for the TVar operations
%%%
%%% @copyright 2012 Filipe Cristóvão
%%%
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(tvar_gen_server).
-behavior(gen_server).

%%%_* Exports ==================================================================
-export([ new/0
        ]).

%%%_* Includes =================================================================
-include("include/stm.hrl").

%%%_* Constants definition =====================================================


%%%_* Types definition =========================================================
%%-type tvar() :: integer().

-record(tvar, {pid :: pid()
              }).

-record(vBox, {vBoxBodies :: list(vBoxBody())}).

-record(vBoxBody, {version = 0 :: non_neg_integer(),
                   value       :: any()}).

%%%_* Code =====================================================================


init([InitialValue]) ->
  FirstBody = #vBoxBody{version = 0,
                        value = InitialValue},
  {ok, [FirstBody]}.


read() ->
  CurrentTransaction = getCurrentOrCreateTransaction()


getCurrentOrCreateTransaction(Readonly = false) ->
  CurrentTransaction = stm:get_current_transaction(),
  case CurrentTransaction of
    none ->
      transaction:new(Readonly);
    Transaction ->
      Transaction
  end.
