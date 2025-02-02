note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_GAME
inherit
	ETF_NEW_GAME_INTERFACE
create
	make
feature -- command
	new_game(a_level: INTEGER_32)
		require else
			new_game_precond(a_level)
    	do
			-- perform some update on the model state
			if model.is_in_game then
				model.set_msg ("Error! In game already.")
				model.next_state
			else
				model.set_msg ("ok")
				model.new_game(a_level)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
