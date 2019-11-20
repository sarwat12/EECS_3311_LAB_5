note
	description: "Tests created by student"
	author: "You"
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS

inherit
	ES_TEST

create
	make

feature -- Add tests

	make
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
			add_boolean_case (agent t6)
			add_boolean_case (agent t7)
			add_boolean_case (agent t8)
			add_boolean_case (agent t9)
			add_boolean_case (agent t10)
		end

feature -- Tests

	t1: BOOLEAN
		do
			comment ("t1: comment of t1")
			-- Add your own test on heap and scheduler.
			Result := true
		end

	t2: BOOLEAN
		do
			comment ("t2: comment of t2")
			-- Add your own test on heap and scheduler.
			Result := true
		end

	t3: BOOLEAN
		do
			comment ("t3: comment of t3")
			-- Add your own test on heap and scheduler.
			Result := true
		end
		
	t4: BOOLEAN
		do
			comment ("t4: comment of t4")
			-- Add your own test on heap and scheduler.
			Result := true
		end
		
	t5: BOOLEAN
		do
			comment ("t5: comment of t5")
			-- Add your own test on heap and scheduler.
			Result := true
		end
		
	t6: BOOLEAN
		do
			comment ("t6: comment of t6")
			-- Add your own test on heap and scheduler.
			Result := true
		end
		
	t7: BOOLEAN
		do
			comment ("t7: comment of t7")
			-- Add your own test on heap and scheduler.
			Result := true
		end
		
	t8: BOOLEAN
		do
			comment ("t8: comment of t8")
			-- Add your own test on heap and scheduler.
			Result := true
		end
		
	t9: BOOLEAN
		do
			comment ("t9: comment of t9")
			-- Add your own test on heap and scheduler.
			Result := true
		end
		
	t10: BOOLEAN
		do
			comment ("t10: comment of t10")
			-- Add your own test on heap and scheduler.
			Result := true
		end
end
