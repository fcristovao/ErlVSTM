%% -*- erlang-indent-level: 2 -*-
%%%=============================================================================
%%% @doc Main file for the STM operations
%%%
%%% @copyright 2012 Filipe Cristóvão
%%%
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(stm).

%%%_* Exports ==================================================================
-export([ atomic/1
        ]).

%%%_* Includes =================================================================
-include("include/stm.hrl").

%%%_* Constants definition =====================================================
-define(STM_TRANSACTION_KEY, stm_transaction_key).

%%%_* Types definition =========================================================
-type stm() :: integer().

%%%_* Code =====================================================================

%%------------------------------------------------------------------------------
%% Function: atomic(Fun) -> _
%%------------------------------------------------------------------------------

atomic(Fun) ->
  %% Execute Fun in a transactional context
  case get_current_transaction() of
    none -> % No transaction has been started yet
      NewTransaction = create_transaction(),
      set_current_transaction(NewTransaction),

    CurrentTransaction -> % There's already a transaction running.
      
  end,
  Fun().


create_transaction() ->
  transaction:new(1).

get_current_transaction() ->
  case get(?STM_TRANSACTION_KEY) of
    undefined -> % No transaction has been started yet
      none;
    CurrentTransaction ->
      CurrentTransaction
  end.

set_current_transaction(Transaction) ->
  put(?STM_TRANSACTION_KEY, Transaction).
