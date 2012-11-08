%%%=============================================================================
%%% @doc Main file for the VBoxBodies
%%% @copyright 2012 Filipe Cristóvão
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(vbox_body).

%%%_* Exports ==================================================================
-export([ new/2
        ]).
-compile(export_all).
%%%_* Includes =================================================================


%%%_* Constants definition =====================================================


%%%_* Types definition =========================================================

-record(vbox_body, {version = 0 :: non_neg_integer(),
                    value       :: any()}).

%%%_* Code =====================================================================
new(InitialValue) ->
  new(0, InitialValue).

new(Version, Value) ->
  #vbox_body{version = Version,
             value   = Value}.

version(#vbox_body{version = Version}) ->
  Version.

value(#vbox_body{value = Value}) ->
  Value.

is_vbox_body(#vbox_body{}) ->
  true;
is_vbox_body(_AnythingElse) ->
  false.

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
