%%% -*- erlang-indent-level: 2 -*-
%%%=============================================================================
%%% @doc Main file for the TVar operations
%%%
%%% @copyright 2012 Filipe Cristóvão
%%%
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(tvar).


%%%_* Exports ==================================================================
-export([ new/1
        , get/1
        , set/2
        , getBody/2
        ]).

%%%_* Includes =================================================================

%%%_* Constants definition =====================================================


%%%_* Types definition =========================================================
%%-type tvar() :: integer().

-record(tvarObject, {pid :: pid()}).


%%%_* Code =====================================================================

%%------------------------------------------------------------------------------
%% Function: new
%% Creates a new Transactional Variable
%%------------------------------------------------------------------------------
%-spec new() -> tvarObject().
new(InitialValue) ->
  {ok, Pid} = gen_server:start(tvar_gen_server,InitialValue,[]),
  #tvarObject{pid = Pid}.


get(TVar) ->
  Tmp = fun(Transaction) ->
          gen_server:call(pid(TVar),{get, TVar, Transaction})
        end,
  maybeCreateTransactionAndRun(Tmp).

set(TVar, NewValue) ->
  Tmp = fun(Transaction) ->
          gen_server:call(pid(TVar),{set, TVar, Transaction, NewValue})
        end,
  maybeCreateTransactionAndRun(Tmp).
  
  
maybeCreateTransactionAndRun(Function) ->
  CurrentTransaction = stm:get_current_transaction(),
  case CurrentTransaction of
    none ->
      %% Maybe this can be just stm:atomic(<the gen server call>)
      Transaction = transaction:new(1),
      Result = Function(Transaction),
      %commit(transaction),
      Result;
    Transaction ->
      Function(Transaction)
  end.

getBody(TVar, Transaction)->
  gen_server:call(pid(TVar), {getBody, TVar, Transaction}).


pid(#tvarObject{pid = Pid}) -> Pid.