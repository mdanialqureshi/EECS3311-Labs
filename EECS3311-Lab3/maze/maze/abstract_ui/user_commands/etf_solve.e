note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SOLVE
inherit
	ETF_SOLVE_INTERFACE
create
	make
feature -- command
	solve
    	do
			-- perform some update on the model state
			if model.is_in_game then
				model.solve
			else
				model.set_msg ("Error! Not in a game.")
				model.next_state
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
