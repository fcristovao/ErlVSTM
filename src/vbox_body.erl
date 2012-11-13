%%%=============================================================================
%%% @doc Main file for the VBox Bodies
%%% @copyright 2012 Filipe Cristóvão
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================
-module(vbox_body).

%%%_* Exports ==================================================================
-export([ new/1
        , new/2
        , version/1
        , value/1
        , is_vbox_body/1
        ]).

%%%_* Includes =================================================================


%%%_* Constants definition =====================================================


%%%_* Types definition =========================================================

-record(vbox_body, {version = 0 :: non_neg_integer(),
                    value       :: any()}).

-opaque vbox_body() :: #vbox_body{}.

%%%_* Code =====================================================================

-spec new(any()) -> vbox_body().
new(InitialValue) ->
  new(0, InitialValue).

-spec new(Version :: non_neg_integer(), Value :: any()) -> vbox_body().
new(Version, Value) ->
  #vbox_body{version = Version,
             value   = Value}.

-spec version(vbox_body()) -> non_neg_integer().
version(#vbox_body{version = Version}) ->
  Version.

-spec value(vbox_body()) -> any().
value(#vbox_body{value = Value}) ->
  Value.

-spec is_vbox_body(any()) -> boolean().
is_vbox_body(#vbox_body{}) ->
  true;
is_vbox_body(_AnythingElse) ->
  false.

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
