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
-behavior(gen_server).

%%%_* Exports ==================================================================
-export([ new/0
        ]).

%%%_* Includes =================================================================
-include("include/stm.hrl").

%%%_* Constants definition =====================================================


%%%_* Types definition =========================================================
                                                %-type tvar() :: integer().

-record(tvar, {pid :: pid()
              }).

-record(vBox, {vBoxBodies :: list(vBoxBody())}).

-record(vBoxBody, {version = 0 :: non_neg_integer(),
                   value       :: any()}).
                
%%%_* Code =====================================================================

%%------------------------------------------------------------------------------
%% Function: new
%% Creates a new Transactional Variable
%%------------------------------------------------------------------------------
-spec new() -> tvar().
new(InitialValue) ->
  {ok, Pid} = gen_server:start(tvar,[InitialValue],[]),
  #tvar{pid = Pid}.

init([InitialValue]) ->
  #vBoxBody{version = 0,
            value = InitialValue
          
          
          

              
