note
	description: "Summary description for {STUDENT_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TEST

inherit
	ES_TEST

create
	make
feature {NONE}-- Initialization

	make
		do
			add_boolean_case(agent t1)
			add_boolean_case(agent t2)
			add_boolean_case(agent t3)
			add_boolean_case(agent t4)
			add_boolean_case(agent t5)
		end

feature -- Tests

	t1: BOOLEAN -- Test reachable functionality when source vertex has no outgoing vertices. So it is a deadend for the BFS.
		local
			graph : LIST_GRAPH [STRING]
			src : VERTEX [STRING]
			edge : EDGE [STRING]
			vertex : VERTEX [STRING]
			a : STRING
			reachable_vertices : ARRAY [VERTEX[STRING]]

		do
			comment("t1: Test reachable functionality when source vertex has no outgoing vertices. - String Case.")
			create graph.make_empty

			across 1 |..| 9 as i loop
				a := i.item.out
				create vertex.make (a)
				graph.add_vertex (vertex)
				create edge.make (graph.vertices[1], graph.vertices[i.item])
				graph.add_edge (edge)
			end
			--check if graph is set up right, these are integers as strings.
			assert_equal ("correct vertices & edges", "[1:1,2,3,4,5,6,7,8,9][2][3][4][5][6][7][8][9]", graph.out)
			Result := graph.vertex_count ~ 9 and graph.edge_count ~ 9
			-- make the source vertex one with no outgoing edges
			src := graph.vertices[5]
			reachable_vertices := graph.reachable (src)
			Result := reachable_vertices.count ~ 1
		end

	t2: BOOLEAN -- Adding an edge to a graph which contains a destination vertex sharing an item with a vertex in the graph, but is not actually apart of the graph.
		local
			graph: LIST_GRAPH [INTEGER]
			vertex_1, vertex_2: VERTEX [INTEGER]
			edge_1: EDGE [INTEGER]
		do
			comment ("t2:  Adding and edge command - add_edge - destination vertex is not in graph but shares an item with a vertex in the graph. Also a self loop case in the graph.")
			create graph.make_empty
			across 1 |..| 10 as i loop
				create vertex_1.make (i.item)
				graph.add_vertex (vertex_1)
			end

			across 1 |..| 10 as i loop
			create edge_1.make (graph.vertices[1],graph.vertices[i.item])
			graph.add_edge (edge_1)
			end

			assert_equal ("correct vertices & edges", "[1:1,2,3,4,5,6,7,8,9,10][2][3][4][5][6][7][8][9][10]", graph.out)
			Result := graph.edge_count ~ 10 and graph.vertex_count ~ 10
			check
				Result
			end
			-- An edge with a destination vertex that is not apart of the graph but shares the same value as a vertex
			-- which is present in the graph
			create vertex_2.make (8)
			create edge_1.make (graph.vertices[2], vertex_2)
			graph.add_edge (edge_1)
			assert_equal ("correct vertices & edges", "[1:1,2,3,4,5,6,7,8,9,10][2:8][3][4][5][6][7][8][9][10]", graph.out)
		end

	t3: BOOLEAN -- Test outgoing_sorted functionality in VERTEX with strings
		local
			vertex, vertex_2, vertex_3 : VERTEX [STRING]
			edge: EDGE [STRING]
			sorted_edges: ARRAY [EDGE [STRING]]
		do
			comment ("t3: Test outgoing_sorted functionality in VERTEX -- String case.")
			create vertex.make ("vertex 1")
			create vertex_2.make ("vertex 2")
			create vertex_3.make ("vertex 3")
			create edge.make (vertex, vertex_3)
			vertex.add_edge (edge)
			vertex_3.add_edge (edge)
			create edge.make (vertex, vertex_2)
			vertex.add_edge (edge)
			vertex_2.add_edge (edge)
			create edge.make (vertex_2, vertex_3)
			vertex_2.add_edge (edge)
			vertex_3.add_edge (edge)
			create edge.make (vertex_2, vertex)
			vertex_2.add_edge (edge)
			vertex.add_edge (edge)
			sorted_edges := vertex_2.outgoing_sorted
			Result := sorted_edges.count ~ 2
			assert_equal ("outgoing_sorted_correct", "vertex 2:vertex 1,vertex 3", vertex_2.out)
		end


	t4: BOOLEAN -- remove an edge that has a vertex not in graph but sharing same value as a vertex in the graph
		local
			graph : LIST_GRAPH [INTEGER]
			edge_array : ARRAY[TUPLE[INTEGER,INTEGER]]
			edge : EDGE[INTEGER]
			v_1 : VERTEX[INTEGER]
		do
			comment("t4: Add & Remove Commands - remove_edge - remove an edge that has a vertex not in graph but sharing same value as a vertex in the graph.")
			edge_array := <<[1,1],[1,2],[1,3],[1,4],[1,5]>>
			edge_array.compare_objects
			create graph.make_from_array (edge_array)
			assert_equal("correct vertices and edges", "[1:1,2,3,4,5][2][3][4][5]",graph.out)
			Result := graph.edge_count ~ 5 and graph.vertex_count ~ 5


			create v_1.make (1)
			create edge.make (v_1,graph.vertices[3])
			--remove an edge that has a vertex not in graph but sharing same value as vertex in the graph
			graph.remove_edge (edge)
			assert_equal("correct vertices and edges", "[1:1,2,4,5][2][3][4][5]",graph.out)
			Result := graph.edge_count ~ 4 and graph.vertex_count ~ 5
		end

	t5: BOOLEAN
		local
			graph : LIST_GRAPH [INTEGER]
			edge_array : ARRAY[TUPLE[INTEGER,INTEGER]]
			edge : EDGE[INTEGER]
			v_1,v_2 : VERTEX[INTEGER]
		do
			comment("t4: Add & Remove Commands - remove_edge - remove an edge that has vertices not in graph but sharing values with vertices in the graph.")
			edge_array := <<[1,1],[1,2],[1,3],[1,4],[1,5]>>
			edge_array.compare_objects
			create graph.make_from_array (edge_array)
			assert_equal("correct vertices and edges", "[1:1,2,3,4,5][2][3][4][5]",graph.out)
			Result := graph.edge_count ~ 5 and graph.vertex_count ~ 5

			create v_1.make (1)
			create v_2.make (3)
			create edge.make (v_1,v_2)
			--remove an edge that has both vertices not in graph but sharing same values as vertices in the graph
			graph.remove_edge (edge)
			assert_equal("correct vertices and edges", "[1:1,2,4,5][2][3][4][5]",graph.out)
			Result := graph.edge_count ~ 4 and graph.vertex_count ~ 5
		end
end
