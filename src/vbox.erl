%%%=============================================================================
%%% @doc Main file for the VBoxes
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Module declaration =======================================================

-module(vbox).

%%%_* Exports ==================================================================

-export([ new/1
        ]).

%%%_* Includes =================================================================

%%%_* Constants definition =====================================================

%%%_* Types definition =========================================================

-type vbox_body() :: vbox_body:vbox_body().

-record(vbox, { vbox_bodies :: list(vbox_body())
              }).

-opaque vbox() :: #vbox{}.

-export_type([vbox/0]).

%%%_* Code =====================================================================

-spec new(InitialValue :: any()) -> vbox().
new(InitialValue) ->
  VBoxBody = vbox_body:new(InitialValue),
  #vbox{vbox_bodies = [VBoxBody]}.

put(VBox, Transaction, NewValue) ->
  NewVBoxBody = vbox_body:new(transaction:tx_number(Transaction), NewValue),
  #vbox{vbox_bodies = [NewVBoxBody | vbox_bodies(VBox)]}.

get(VBox, VersionNr) ->
  Pred = fun(VBoxBody) ->
             vbox_body:version(VBoxBody) > VersionNr
         end,
  VBoxBody = utilities:first(Pred, vbox_bodies(VBox)),
  vbox_body:value(VBoxBody).


vbox_bodies(#vbox{vbox_bodies = VBoxBodies}) -> VBoxBodies.

add_vbox_body(VBox = #vbox{vbox_bodies = VBoxBodies}, NewVBoxBody) ->
  %% TODO: There should be some sort of verification that indeed it is
  %% a VBoxBody being sent.
  VBox.


%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
