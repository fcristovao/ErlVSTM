%%% -*- erlang-indent-level: 2 -*-
%%%=============================================================================
%%% @doc Main file for the VBoxes
%%% @copyright 2012 Filipe Cristóvão
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

-record(vBox, {vBoxBodies}).


%%%_* Code =====================================================================

%%------------------------------------------------------------------------------
%% Function: new
%% Creates a new Transactional Variable
%%------------------------------------------------------------------------------
%%-spec new() -> vBox().
new(InitialValue) ->
  VBoxBody = vboxbody:new(InitialValue),
  #vBox{vBoxBodies = [VBoxBody]}.

put(VBox, Transaction, NewValue) ->
  NewVBoxBody = vboxbody:new(transaction:txNumber(Transaction), NewValue),
  #vBox{vBoxBodies = [NewVBoxBody | vBoxBodies(VBox)]}.

get(VBox, VersionNr) ->
  Pred = fun(VBoxBody) ->
             vboxbody:version(VBoxBody) > VersionNr
         end,
  VBoxBody = first(Pred,vBoxBodies(VBox)),
  vboxbody:value(VBoxBody).


vBoxBodies(#vBox{vBoxBodies = VBoxBodies}) -> VBoxBodies.

addVBoxBody(VBox#vBox{vBoxBodies = VBoxBodies}, NewVBoxBody) ->
  %% TODO: There should be some sort of verification that indeed it is
  %% a VBoxBody being sent.
  NewVBoxBody
  



%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
