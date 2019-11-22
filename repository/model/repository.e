note
	description: "[
		The REPOSITORY ADT consists of data sets (tuples).
		Each data set maps from a key to two data items (which may be of different types).
		There should be no duplicates of keys. 
		However, multiple keys might map to equal data items.
		]"
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

-- Requirements:
-- The only contract in which you can refer to the three implementation attributes
-- `keys`, `data_items_1`, and `data_items_2` is the postcondition of `model`.
-- Contracts of all other features in this class MUST be defined in terms of `model`.

-- Any reference to the three implementation attributes in the contract for a feature
-- that is not `model` will result an immediate ZERO of this lab.

class
	-- Here the -> means constrained genericity:
	-- client of REPOSITORY may instantiate KEY to any class,
	-- as long as it is a descendant of HASHABLE (i.e., so it can be used as a key in hash table).
	REPOSITORY[KEY -> HASHABLE, DATA1, DATA2]
inherit
	ITERABLE[TUPLE[DATA1, DATA2, KEY]]

create
	make

feature {ES_TEST} -- Do not modify this export status!
	-- Implementations of all repository features using these three attributes are given to you.
	-- You are only required to specify their contracts using `model`.

	-- For any valid index i, a data set is composed of keys[i], data_items_1[i], and data_items_2[keys[i]].
	keys: LINKED_LIST[KEY]
	data_items_1: ARRAY[DATA1]
	data_items_2: HASH_TABLE[DATA2, KEY]

feature -- Abstraction Function

	model: FUN[KEY, TUPLE[d1: DATA1; d2: DATA2]]
			-- Return the current repository as a function mapping from keys to tuples of data items.
			-- Each function can be viewed as a set of pairs.
			-- In this case, the first element of each pair is the key, whereas the second element is a tuple,
			-- whose `d1` field refers to a value of type DATA1 and `d2` field refers to a value of type DATA2.
		local
			pair: PAIR[KEY, TUPLE[d1: DATA1; d2: DATA2]]
		do
			-- TODO: Implement the abstraction function.
			create Result.make_empty
			across 1 |..| keys.count is i loop
				check attached data_items_2.at (keys.i_th (i)) as key then
					create pair.make (keys.i_th (i), [data_items_1.item (i), key])
					Result.extend (pair)
				end
			end
		ensure
			-- This is the only place where you can refer to the three implementation attributes
			-- `keys`, `data_items_1`, and `data_items_2`.

			-- Warning: You should not use `model` in the postcondition of `model`.
			-- You should use `Result` to refer to the resulting model function.
			all_data_sets_in_model: -- TODO:
				-- Hint: Each data set (tuple [k, d1, d2]) in the current repository is in the Result function.
				-- If you can't get this postcondition to work, simply put TRUE here.
				across 1 |..| keys.count is i all
					(Result.item (keys.i_th (i)) ~ [data_items_1.item (i), data_items_2.at (keys.i_th (i))])
				 	and (Result.domain.has (keys.i_th (i)))
				end

			all_model_pairs_in_repository: -- TODO:
				-- Hint: Each (key, [data1, data2]) pair in the Result function is in the repository.
				-- Also look at the type of `new_cursor` in FUN.
				-- If you can't get this postcondition to work, simply put TRUE here.
				across Result is i all
					keys.has (i.first) and data_items_1.has (i.second.d1) and data_items_2.has (i.first)
				end
		end

feature -- feature(s) required by ITERABLE
	-- Implemented for you.
	-- Do not touch.
	-- No need to implement pre- and post-condition here.
	-- Also, there is no need to touch class TUPLE_ITERATION_CURSOR.
	new_cursor: ITERATION_CURSOR[TUPLE[d1: DATA1; d2: DATA2; k: KEY]]
		do
			create {TUPLE_ITERATION_CURSOR[KEY, DATA1, DATA2]} Result.make (data_items_2, keys, data_items_1)
		end

feature -- Constructor
	make
			-- Initialize an empty repository.
		do
			-- Implemented for you.
			-- Do not touch.
			create keys.make
			create data_items_1.make_empty
			keys.compare_objects
			data_items_1.compare_objects
			create data_items_2.make (100)
			data_items_2.compare_objects
		ensure
			empty_repository: -- TODO:
				model.is_empty
		end

feature -- Commands

	check_in (d1: DATA1; d2: DATA2; k: KEY)
			-- Insert a new data set into current repository.
		require
			non_existing_key: -- TODO:
				True
		do
			-- Implemented for you.
			-- Do not touch.
			keys.extend (k)
			data_items_1.force (d1, data_items_1.count + 1)
			data_items_2.extend (d2, k)
		ensure
			repository_count_incremented: -- TODO:
				True

			data_set_added: -- TODO:
				-- Hint: At least a pair (k, [d1, d2]) the current model
				-- has its key 'k', data item 1 'd1', and data item 2 'd2'.
				-- If you can't get this postcondition to work, simply put TRUE here.
				True

			others_unchanged: -- TODO:
				-- Hint: Each pair (k, [d1, d2]) in the current model,
				-- if not the same as (`k`, `d1`, `d2`), must also exist in the old model.
				-- If you can't get this postcondition to work, simply put TRUE here.
				True
		end

	check_out (k: KEY)
			-- Delete a data set with key `k` from current repository.
		require
			existing_key: -- TODO:
				True
		local
			i: INTEGER
			new_values: ARRAY[DATA1]
		do
			-- Implemented for you.
			-- Do not touch.
			data_items_2.remove (k)

			create new_values.make_empty
			from
				keys.start
				i := data_items_1.lower
			until
				keys.after
			loop
				if keys.item ~ k then
					keys.remove -- after removal, cursor moves to the right, essentially 'forth'!
				else
					new_values.force (data_items_1 [i], new_values.count + 1)
					keys.forth
				end
				i := i + 1
			end
			data_items_1 := new_values
		ensure
			repository_count_decremented: -- TODO:
				True

			key_removed: -- TODO:
				True

			others_unchanged: -- TODO:
				-- Hint: Each pair (k, [d1, d2]) in the old model,
				-- if not with key `k`, must also exist in the curent model.
				-- If you can't get this postcondition to work, simply put TRUE here.
				True
		end

feature -- Queries

	count: INTEGER
			-- Number of data sets in repository.
		do
			-- Implemented for you.
			-- Do not touch.
			Result := keys.count
		ensure
			correct_result: -- TODO:
				Result = model.count
		end

	matching_keys (d1: DATA1; d2: DATA2): ITERABLE[KEY]
			-- Keys that are associated with data items 'd1' and 'd2'.
		local
			ks: LINKED_LIST[KEY]
			i: INTEGER
		do
			-- Implemented for you.
			-- Do not touch.
			create ks.make
			from
				i := data_items_1.lower
				keys.start
			until
				keys.after
			loop
				if data_items_1[i] ~ d1 and then
					data_items_2 [keys.item] ~ d2
				then
					ks.extend (keys.item)
				end
				i := i + 1
				keys.forth
			end
			Result := ks
		ensure
			result_contains_correct_keys_only: -- TODO:
				-- Hint: Each key in Result has its associated data items 'd1' and 'd2' in model.
				-- Note: across Current ... is forbidden for this postcondition.
				-- If you can't get this postcondition to work, simply put TRUE here.
				True

			correct_keys_are_in_result: -- TODO:
				-- Hint: Each pair in model with data items 'd1' and 'd2' has its key included in Result.
				-- Note: across Current ... is forbidden for this postcondition.
				-- Notice that Result is ITERABLE and does not support the feature 'has',
				-- Use the appropriate across expression instead.
				-- If you can't get this postcondition to work, simply put TRUE here.
				True
		end

invariant
	-- Do not modify the following class invariants.
	unique_keys:
		across
			1 |..| keys.count as i
		all
			across
				1 |..| keys.count as j
			all
				i.item /= j.item implies keys[i.item] /~ keys[j.item]
			end
		end

	implementation_contraint:
		data_items_1.lower = 1

	consistent_keys_data_items_counts:
		keys.count = data_items_1.count
		and
		keys.count = data_items_2.count

	consistent_keys:
		across
			keys is k
		all
			data_items_2.has (k)
		end

	consistent_imp_adt_counts:
		keys.count = count
end
