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
-compile(export_all).

%%%_* Includes =================================================================


%%%_* Constants definition =====================================================


%%%_* Types definition =========================================================


%%%_* Code =====================================================================


init(InitialValue) ->
  {ok, vbox:new(InitialValue)}.

handle_call({get, TVar, Transaction}, _From, _VBox) ->
  Result = get(TVar, Transaction),
  {reply, Result, _VBox};

handle_call({set, TVar, Transaction, NewValue}, _From, _VBox) ->
  Result = set(TVar, Transaction, NewValue),
  {reply, Result, _VBox};

handle_call({getBody, _TVar, Transaction}, _From, VBox) ->
  Result = getBody(VBox, Transaction),
  {reply, Result, VBox}.

get(TVar, Transaction) ->
  transaction:getTVarValue(Transaction, TVar).

set(TVar, Transaction, NewValue) ->
  transaction:setTVarValue(Transaction, TVar, NewValue).

getBody(VBox, Transaction) ->
  vbox:get(VBox, transaction:txNumber(Transaction)).
