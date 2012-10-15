%% -*- erlang-indent-level: 2 -*-
%%%=============================================================================
%%% @doc Transactions
%%%
%%% @copyright 2012 Filipe Cristóvão
%%%
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(transaction).

%%%_* Exports ==================================================================
-export([
        ]).

%%%_* Includes =================================================================


%%%_* Constants definition =====================================================

%%%_* Types definition =========================================================
-record(txObject, {txNumber,
                    pid :: pid()}).

%%%_* Code =====================================================================

%%------------------------------------------------------------------------------
%% Function: transaction(Fun) -> _
%%------------------------------------------------------------------------------

new(TxNumber) ->
  {ok, Pid} = gen_server:start(transaction_gen_server,TxNumber,[]),
  TxNr = gen_server:call(Pid, getTransactionNumber),
  new(TxNr, Pid).

getTVarValue(Transaction, TVar) ->
  gen_server:call(pid(Transaction), {getTVarValue, Transaction, TVar}).
    
new(TxNumber, Pid) ->
  #txObject{txNumber = TxNumber, pid = Pid}.

pid(Transaction) ->
  TxObject#txObject.pid

txNumber(Transaction) ->
  TxObject#txObject.txNumber  