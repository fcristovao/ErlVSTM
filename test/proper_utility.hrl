%%%=============================================================================
%%% @doc
%%% @copyright 2012 Filipe Cristovao
%%% @end
%%%=============================================================================

%%%_* Constants definition =====================================================

-define(runProperTestsInEUnit,
        [{atom_to_list(F),
          fun() ->
              io:format("Testing property " ++ atom_to_list(F) ++ ":~n~n"),
              PropertyHolds =
                proper:quickcheck(?MODULE:F()
                                  %% [{on_output,
                                  %%   fun(X,Y) -> io:format(user, X, Y) end
                                  %%  }]
                                 ),
              ?assert(PropertyHolds)
          end
         }
         || {F, 0} <- ?MODULE:module_info(exports), F > 'prop_', F < 'prop`']).

%%%_* Emacs ====================================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
