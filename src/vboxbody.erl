%%% -*- erlang-indent-level: 2 -*-
%%%=============================================================================
%%% @doc Main file for the VBoxBodies
%%% @copyright 2012 Filipe Cristóvão
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(vboxbody).

%%%_* Exports ==================================================================
-export([ new/2
        ]).
-compile(export_all).
%%%_* Includes =================================================================


%%%_* Constants definition =====================================================


%%%_* Types definition =========================================================

-record(vBoxBody, {version = 0 :: non_neg_integer(),
                   value       :: any()}).

%%%_* Code =====================================================================
new(InitialValue) ->
  new(0, InitialValue).

new(Version, Value) ->
  #vBoxBody{version = Version,
            value   = Value}.

version(#vBoxBody{version = Version}) -> Version.

value(#vBoxBody{value = Value}) -> Value.

