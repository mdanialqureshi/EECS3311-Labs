note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	MAZE

inherit
	ANY
		redefine
			out
		end

create {MAZE_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create msg.make_from_string ("ok")
			state := 0
			game_number := 0
			total_score :=0
			in_game := false
			used_solve := false
			aborted := false
			create maze_generator.make
			create maze_drawer.make_empty
			create player_location.make (1,1)
			valid_move := true
		end

feature{NONE} -- model attributes

	msg : STRING
	state : INTEGER
	maze_generator: MAZE_GENERATOR
	du: DIRECTION_UTILITY
	maze_drawer: MAZE_DRAWER
	game_number : INTEGER
	points : INTEGER
	total_score : INTEGER
	in_game : BOOLEAN
	difficulty : INTEGER
	used_solve : BOOLEAN
	aborted : BOOLEAN
	player_location : COORDINATE
	valid_move : BOOLEAN

feature -- model operations

	new_game(a_level: INTEGER_32)
		do
			state := state + 1
			create maze_drawer.make (maze_generator.generate_new_maze (a_level))
			game_number := game_number + 1
			total_score := total_score + a_level
			difficulty := a_level
			in_game := True
			aborted := false
		end

	move(a_direction: INTEGER_32)

			do
			-- call is this a valid move
			next_state
			valid_move := is_valid_move (a_direction)
				if valid_move then
					msg := "ok"
					inspect a_direction
					when 4 then
						maze_drawer.move_player (du.n)
					when 5 then
						maze_drawer.move_player (du.e)
					when 6 then
						maze_drawer.move_player (du.s)
					when 7 then
						maze_drawer.move_player (du.w)
					else
						msg := "Error! Not a valid move."
					end
				else
					msg := "Error! Not a valid move."
				end


			-- award the user points if they completed the maze without using the solve command
			if maze_drawer.check_win_bool and not used_solve then
				points := points + difficulty
				msg := "ok"
			end
			-- if the user used the solve command then do not award them points
			if maze_drawer.check_win_bool and used_solve then
				msg := "ok"
			end

		end


	solve
		local
			src : VERTEX[COORDINATE]
			dst : VERTEX[COORDINATE]
			win_vertex_cor : COORDINATE
			shortest : SEQ [VERTEX[COORDINATE]]
			next_cor : COORDINATE
			counter : INTEGER

		do
			msg := "ok"
			next_state

			-- create the vertex where player currently is
				create src.make (player_location)
				across 1 |..| maze_drawer.maze_graph.vertices.count as i loop
					if maze_drawer.maze_graph.vertices[i.item].item ~ player_location then
						src := maze_drawer.maze_graph.vertices[i.item]
					end
				end
			-- the destination vertex of the maze
			create win_vertex_cor.make (maze_drawer.size,maze_drawer.size)
			create dst.make (win_vertex_cor)
			across 1 |..| maze_drawer.maze_graph.vertices.count as i loop
				if maze_drawer.maze_graph.vertices[i.item].item ~ win_vertex_cor then
					dst := maze_drawer.maze_graph.vertices[i.item]
				end
			end
				-- if there is a solution to the maze
			if maze_drawer.maze_graph.is_reachable (src, dst) then
				used_solve := true
				shortest := maze_drawer.maze_graph.shortest_path (src,dst)

				-- where the player starts off is initial cordinate
				create next_cor.make (1,1)
				counter := 2

				across 2 |..| shortest.upper as i loop
					create next_cor.make (shortest[i.item].item.row - shortest[i.item - 1].item.row,
					shortest[i.item].item.col - shortest[i.item - 1].item.col)

--					print("row : " + next_cor.row.out +  " col :" + next_cor.col.out + " ")
--					maze_drawer.maze_ascii[2, 1][3] := 'o'
--					maze_drawer.maze_ascii[3, 1][3] := 'o'
--					maze_drawer.maze_ascii[4, 1][3] := 'o'

--					maze_drawer.maze_ascii[2, 2][3] := 'W'
--					maze_drawer.maze_ascii[2, 3][3] := 'W'
--					maze_drawer.maze_ascii[2, 4][3] := 'W'

					if next_cor ~ du.e or next_cor ~ du.w then -- If east or west then
							maze_drawer.maze_ascii[shortest[i.item].item.row + counter - 1, shortest[i.item].item.col][3] := 'o'

					else -- north or south
						maze_drawer.maze_ascii[shortest[i.item].item.row + counter, shortest[i.item].item.col][3] := 'o'
						counter := counter + 1
					end


				end

			else
				msg := "Error! Maze is not solvable, you may abort with no penalty."
			end
		end

	Abort
		do
			msg := "ok"
			next_state
			aborted := true
			reset
			if not(is_solvable) then
				total_score := total_score - difficulty
			end
		end

	reset
			-- Reset model state.
		do
			used_solve := false
			in_game := false
		end

	set_msg (new_msg : STRING)
		do
			msg := new_msg
		end

	set_abort (set_aborted : BOOLEAN)
		do
			aborted := set_aborted
		end

	next_state
		do
			state := state + 1
		end

feature -- queries

	is_in_game : BOOLEAN
		do
			Result := in_game
		end

	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("State: " + state.out + " -> " + msg)
			if not (state = 0) and not (aborted) then

				if in_game and not (msg.at (1).is_equal ('E')) and valid_move then
					Result.append (maze_drawer.out + "%N  ")
				end

				if msg.at (1).is_equal ('E') then
					Result.append ("%N  ")
				end

				if maze_drawer.check_win_bool and not (msg.is_equal("Error! Not in a game.")) then
						Result.append("Congratulations! You escaped the maze!")
						Result.append ("%N  ")
						in_game := false
						msg := "ok"
				end

				if used_solve then
					Result.append("Since you used the solution, no points are awarded.")
					Result.append ("%N  ")
					if maze_drawer.check_win_bool then
						used_solve := false
						abort
					end
				end
				if not(aborted) then
					Result.append ("Game Number: " + game_number.out + "%N")
					Result.append ("  ")
					Result.append ("Score: " + points.out + " / " + total_score.out + "%N")
				end

			end
		end

feature{NONE} -- private queries

	-- is this move a valid move
	is_valid_move(a_direction : INTEGER_32) : BOOLEAN
			local
				move_tuple : TUPLE[row : INTEGER_32; column : INTEGER_32]
				co : COORDINATE
				a_edge: EDGE[COORDINATE]
				s_vertex : VERTEX[COORDINATE]
				d_vertex : VERTEX[COORDINATE]
				co2 : COORDINATE
			do

				move_tuple := du.num_dir ((a_direction - 3))
				create co.make (move_tuple)
				create co2.make (player_location.row + co.row, player_location.col + co.col)
				create s_vertex.make (player_location)
				create d_vertex.make (co2)
				create a_edge.make (s_vertex, d_vertex)
				create player_location.make (player_location.row + co.row, player_location.col + co.col)
				if maze_drawer.maze_graph.has_edge (a_edge) or maze_drawer.maze_graph.has_edge (a_edge.reverse_edge) then
					Result := true
				else
					Result := false
					create player_location.make (player_location.row - co.row, player_location.col - co.col)
				end
		end


	is_solvable : BOOLEAN
		-- is this maze solvable ?
		local
			src : VERTEX[COORDINATE]
			dst : VERTEX[COORDINATE]
			win_vertex_cor : COORDINATE
		do
			-- create the vertex where player currently is
				create src.make (player_location)
				across 1 |..| maze_drawer.maze_graph.vertices.count as i loop
					if maze_drawer.maze_graph.vertices[i.item].item ~ player_location then
						src := maze_drawer.maze_graph.vertices[i.item]
					end
				end
			-- the destination vertex of the maze
			create win_vertex_cor.make (maze_drawer.size,maze_drawer.size)
			create dst.make (win_vertex_cor)
				-- if there is a solution to the maze
			if maze_drawer.maze_graph.is_reachable (src, dst) then
				Result := true
			else
				Result := false
			end
		end

end




