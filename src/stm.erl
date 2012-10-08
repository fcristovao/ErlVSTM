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

%%%_* Types definition =========================================================
-type stm() :: integer().

%%%_* Code =====================================================================

%%------------------------------------------------------------------------------
%% Function: transaction(Fun) -> _
%%------------------------------------------------------------------------------

atomic(Fun) ->
    %% Execute Fun in a transactional context
    case get(?STM_TRANSACTION_ID) of
        undefined -> % No transaction has been started yet
            create_transaction();
        CurrentTransaction -> % There's already a transaction running.
            Fun()
    end.
            

%% -*- erlang-indent-level: 2 -*-
