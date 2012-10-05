%%%=============================================================================
%%% @doc Main file for the STM operations
%%%
%%% @copyright 2012 Filipe Cristóvão
%%%
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(STM).

%%%_* Exports ==================================================================
-export([ transaction/1
        ]).

%%%_* Includes =================================================================
%-include("").

%%%_* Constants definition =====================================================
-define(STM_TRANSACTION_ID, stm_transaction_id).

%%%_* Code =====================================================================

%%------------------------------------------------------------------------------
%% Function: transaction(Fun) -> _
%%------------------------------------------------------------------------------

transaction(Fun) ->
    % Execute Fun in a transactional context
    case get(?STM_key) of
        undefined -> % No transaction has been started yet
            create_transaction();
        CurrentTransaction -> 
            

