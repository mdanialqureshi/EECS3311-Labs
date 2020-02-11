note
	description: "Summary description for {STUDENT_TEST}."
	author: "Muhammad Danial Qureshi"
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TEST

inherit
	ES_TEST

create
	make
feature {NONE} -- Initialization

	make
		do
			add_boolean_case(agent t1)
			add_boolean_case(agent t2)
			add_boolean_case(agent t3)
			add_boolean_case(agent t4)
			add_boolean_case(agent t5)
		end

feature -- Tests

	t1: BOOLEAN
		local
			i_g: LIST_GRAPH[INTEGER]
			i_a: ARRAY[TUPLE[INTEGER, INTEGER]]
		do
			comment("t1: Advanced Queries - topologically_sorted - linear graph (already in topological ordering)")
			i_a := << [1, 2], [2, 3], [3, 4], [4, 5], [5,6] >>
			i_a.compare_objects
			create i_g.make_from_array (i_a)
			assert_equal ("correct vertices & edges", "[1:2][2:3][3:4][4:5][5:6][6]", i_g.out)
			Result := i_g.edge_count ~ 5 and i_g.vertex_count ~ 6
			check Result end

			Result := i_g.is_topologically_sorted (i_g.topologically_sorted)
			check Result end
		end

	t2: BOOLEAN
		local
			i_g: LIST_GRAPH[INTEGER]
			i_a: ARRAY[TUPLE[INTEGER, INTEGER]]
		do
			comment("t2: Advanced Queries - topologically_sorted - graph with one source vertex with all outgoing edges")
			i_a := << [1, 2], [1, 3], [1, 4], [1, 5], [1,6] >>
			i_a.compare_objects
			create i_g.make_from_array (i_a)
			assert_equal ("correct vertices & edges", "[1:2,3,4,5,6][2][3][4][5][6]", i_g.out)
			Result := i_g.edge_count ~ 5 and i_g.vertex_count ~ 6
			check Result end

			Result := i_g.is_topologically_sorted (i_g.topologically_sorted)
			check Result end
		end

	t3: BOOLEAN
		local
			i_g: LIST_GRAPH[INTEGER]
			i_a: ARRAY[TUPLE[INTEGER, INTEGER]]
		do
			comment("t3: Advanced Queries - topologically_sorted - graph with one destination vertex with all incoming edges")
			i_a := << [2,1], [3, 1], [4, 1], [5, 1], [6, 1] >>
			i_a.compare_objects
			create i_g.make_from_array (i_a)
			assert_equal ("correct vertices & edges", "[2:1][1][3:1][4:1][5:1][6:1]", i_g.out)
			Result := i_g.edge_count ~ 5 and i_g.vertex_count ~ 6
			check Result end

			Result := i_g.is_topologically_sorted (i_g.topologically_sorted)
			check Result end
		end

	t4: BOOLEAN
		local
			i_g: LIST_GRAPH[INTEGER]
			i_a: ARRAY[TUPLE[INTEGER, INTEGER]]
		do
			comment("t4: Advanced Queries - topologically_sorted - Linear graph with alternating edge directions")
			i_a := << [1,2], [3, 2], [3, 4], [5, 4], [5, 6] >>
			i_a.compare_objects
			create i_g.make_from_array (i_a)
			assert_equal ("correct vertices & edges", "[1:2][2][3:2,4][4][5:4,6][6]", i_g.out)
			Result := i_g.edge_count ~ 5 and i_g.vertex_count ~ 6
			check Result end

			Result := i_g.is_topologically_sorted (i_g.topologically_sorted)
			check Result end
		end



	t5: BOOLEAN
		local
			i_g: LIST_GRAPH[INTEGER]
			i_a: ARRAY[TUPLE[INTEGER, INTEGER]]
		do
			comment("t5: Advanced Queries - topologically_sorted - multistage graph")
			i_a := << [1,2], [1, 3], [1, 4], [2, 5], [2, 6], [2,7], [3, 5], [3, 6], [3, 7],[4, 5], [4, 6], [4, 7] >>
			i_a.compare_objects
			create i_g.make_from_array (i_a)
			assert_equal ("correct vertices & edges", "[1:2,3,4][2:5,6,7][3:5,6,7][4:5,6,7][5][6][7]", i_g.out)
			Result := i_g.edge_count ~ 12 and i_g.vertex_count ~ 7
			check Result end

			Result := i_g.is_topologically_sorted (i_g.topologically_sorted)
			check Result end
		end
end
