classdef testTreeNode < matlab.unittest.TestCase
	% testTreeNode: test class for the TreeNode class

	
	properties

		root, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10
	
	end

	methods (TestClassSetup)

		function addClassToPath(testCase)
			testCase.applyFixture( ...
				matlab.unittest.fixtures.PathFixture(".."));
		end
		
	end
	
	methods (TestMethodSetup)

		function createTreeNode(testCase)
			% Create tree of tree nodes with testCase.root at its root
			% The tree has the folllowing structure:
			%
			% Root
			% ├── Node1
			% │   ├── Node3
			% │   ├── Node4
			% │   │   ├── Node8
			% │   │   └── Node9
			% │   └── Node5
			% └── Node2
			%     ├── Node6
			%     │   └── Node10
			%     └── Node7

			testCase.root = TreeNode();
			testCase.n1 = TreeNode(testCase.root);
			testCase.n2 = TreeNode(testCase.root);
			testCase.n3 = TreeNode(testCase.n1);
			testCase.n4 = TreeNode(testCase.n1);
			testCase.n5 = TreeNode(testCase.n1);
			testCase.n6 = TreeNode(testCase.n2);
			testCase.n7 = TreeNode(testCase.n2);
			testCase.n8 = TreeNode(testCase.n4);
			testCase.n9 = TreeNode(testCase.n4);
			testCase.n10 = TreeNode(testCase.n6);

			testCase.addTeardown(@clear, "World", "getWorld")
		end

	end

	%%
	methods (Test)

		function testWorldIsParentValue(testCase)
			testCase.verifyEqual(testCase.n1.parent, testCase.root);
			testCase.verifyEqual(testCase.n2.parent, testCase.root);
		end


		function testIsParentValue(testCase)
			testCase.verifyEqual(testCase.n3.parent, testCase.n1);
			testCase.verifyEqual(testCase.n4.parent, testCase.n1);
			testCase.verifyEqual(testCase.n5.parent, testCase.n1);
			testCase.verifyEqual(testCase.n6.parent, testCase.n2);
			testCase.verifyEqual(testCase.n7.parent, testCase.n2);
			testCase.verifyEqual(testCase.n8.parent, testCase.n4);
			testCase.verifyEqual(testCase.n9.parent, testCase.n4);
			testCase.verifyEqual(testCase.n10.parent, testCase.n6);
		end


		function testRootHasNoParent(testCase)
			testCase.verifyEmpty(testCase.root.parent);
		end


		function testRootHasNoAncestors(testCase)
			testCase.verifyEmpty(testCase.root.getAncestors());
		end


		function testWorldIsRootForEveryNode(testCase)
			testCase.verifyEqual(testCase.root.getRoot(), testCase.root);
			testCase.verifyEqual(testCase.n1.getRoot(), testCase.root);
			testCase.verifyEqual(testCase.n2.getRoot(), testCase.root);
			testCase.verifyEqual(testCase.n3.getRoot(), testCase.root);
			testCase.verifyEqual(testCase.n4.getRoot(), testCase.root);
			testCase.verifyEqual(testCase.n5.getRoot(), testCase.root);
			testCase.verifyEqual(testCase.n6.getRoot(), testCase.root);
			testCase.verifyEqual(testCase.n7.getRoot(), testCase.root);
			testCase.verifyEqual(testCase.n8.getRoot(), testCase.root);
			testCase.verifyEqual(testCase.n9.getRoot(), testCase.root);
			testCase.verifyEqual(testCase.n10.getRoot(), testCase.root);
        end


        function testGetParentOfArrayOfNodes(testCase)
            nodes = [testCase.n7, testCase.n4, testCase.n2];
            testCase.verifyEqual( ...
				[nodes.parent]', ...
				[testCase.n2; testCase.n1; testCase.root]);

			 nodes = [testCase.n1, testCase.n4, testCase.n2];
			 testCase.verifyEqual( ...
				 unique([nodes.parent]', "stable"), ...
				 [testCase.root; testCase.n1]);
		end


        function testSetParentOfArrayOfNodes(testCase)
            nodes = [testCase.n7, testCase.n4, testCase.n2];
            newParent = TreeNode(testCase.root);
            [nodes.parent] = deal(newParent);
            testCase.verifyEqual(unique([nodes.parent]), newParent);
		end


		function testGetAncestorsOfNode(testCase)
            testCase.verifyEqual( ...
				testCase.n10.getAncestors(), ...
				[testCase.n6; testCase.n2; testCase.root]);
			testCase.verifyEqual( ...
				testCase.n10.getAncestors(upTo=testCase.n2), ...
				[testCase.n6; testCase.n2]);
		end


        function testGetChildrenOfNode(testCase)
            testCase.verifyEqual( ...
				testCase.n1.getChildren(), ...
				[testCase.n3; testCase.n4; testCase.n5] ...
				);
		end


		function testGetDescendantsOfNode(testCase)
			testCase.verifyEqual( ...
				testCase.n1.getDescendants(), ...
				[testCase.n3; testCase.n4; testCase.n5;
				testCase.n8; testCase.n9]);
		end
        

		function testAllFramesAreDescendantsOfWorld(testCase)
			testCase.verifyEqual( ...
				testCase.root.getDescendants(), ...
				[testCase.n1; testCase.n2; testCase.n3; testCase.n4; ...
				testCase.n5; testCase.n8; testCase.n9; testCase.n6; ...
				testCase.n7; testCase.n10]);
		end

		
        function testGetSiblingsOfNode(testCase)
            testCase.verifyEqual( ...
				testCase.n4.getSiblings(), ...
				[testCase.n3; testCase.n5]);
			testCase.verifyEqual( ...
				testCase.n10.getSiblings(), ...
				TreeNode.empty(0,1));
		end


		function testCannotAssignItselfAsParent(testCase)
			try
				testCase.n1.parent = testCase.n1;
			catch ME
				testCase.verifyMatches( ...
					ME.identifier, ...
					"TreeNode:set:parent");
				testCase.verifyMatches( ...
					ME.message, ...
					"Node cannot be its own parent");
			end
		end
	

		function testCannotAssignChildAsParent(testCase)
			try
				testCase.n1.parent = testCase.n3;
			catch ME
				testCase.verifyMatches( ...
					ME.identifier, ...
					"TreeNode:set:parent");
				testCase.verifyMatches( ...
					ME.message, ...
					"Child node cannot become the parent to one of its " + ...
					"ancestors");
				testCase.verifyError(@() testCase.n1.setParent(testCase.n3), ...
					"TreeNode:set:parent");
			end
		end


		function testGetTree(testCase)
			testCase.verifyEqual( ...
				testCase.n4.getTree, ...
				[testCase.root; ...
				testCase.n1; testCase.n2; testCase.n3; testCase.n4; ...
				testCase.n5; testCase.n8; testCase.n9; testCase.n6; ...
				testCase.n7; testCase.n10]);
		end


		function testGetBranch(testCase)
			testCase.verifyEqual( ...
				testCase.n2.getBranch(), ...
				[testCase.root; testCase.n2; testCase.n6; 
				testCase.n7; testCase.n10]);
		end


		function testIsParentOf(testCase)
			testCase.verifyTrue(testCase.n1.isParentOf(testCase.n3));
			testCase.verifyTrue(testCase.n1.isParentOf(testCase.n4));
			testCase.verifyTrue(testCase.n1.isParentOf(testCase.n5));
			testCase.verifyFalse(testCase.n1.isParentOf(testCase.n6));
			testCase.verifyFalse(testCase.n1.isParentOf(testCase.n7));
			testCase.verifyFalse(testCase.n1.isParentOf(testCase.n8));
			testCase.verifyFalse(testCase.n1.isParentOf(testCase.n9));
			testCase.verifyFalse(testCase.n1.isParentOf(testCase.n10));
		end


		function testIsAncestorOf(testCase)
			testCase.verifyTrue(testCase.n1.isAncestorOf(testCase.n3));
			testCase.verifyTrue(testCase.n1.isAncestorOf(testCase.n4));
			testCase.verifyTrue(testCase.n1.isAncestorOf(testCase.n5));
			testCase.verifyTrue(testCase.n1.isAncestorOf(testCase.n8));
			testCase.verifyTrue(testCase.n1.isAncestorOf(testCase.n9));
			testCase.verifyFalse(testCase.n1.isAncestorOf(testCase.n6));
			testCase.verifyFalse(testCase.n1.isAncestorOf(testCase.n7));
			testCase.verifyFalse(testCase.n1.isAncestorOf(testCase.n10));
		end


		function testIsChildOf(testCase)
			testCase.verifyTrue(testCase.n3.isChildOf(testCase.n1));
			testCase.verifyTrue(testCase.n4.isChildOf(testCase.n1));
			testCase.verifyTrue(testCase.n5.isChildOf(testCase.n1));
			testCase.verifyFalse(testCase.n3.isChildOf(testCase.n2));
			testCase.verifyFalse(testCase.n4.isChildOf(testCase.n2));
			testCase.verifyFalse(testCase.n5.isChildOf(testCase.n2));
			testCase.verifyFalse(testCase.n3.isChildOf(testCase.root));
		end


		function testIsDescendantOf(testCase)
			testCase.verifyTrue(testCase.n3.isDescendantOf(testCase.n1));
			testCase.verifyTrue(testCase.n4.isDescendantOf(testCase.n1));
			testCase.verifyTrue(testCase.n5.isDescendantOf(testCase.n1));
			testCase.verifyTrue(testCase.n8.isDescendantOf(testCase.n1));
			testCase.verifyTrue(testCase.n9.isDescendantOf(testCase.n1));
			testCase.verifyFalse(testCase.n3.isDescendantOf(testCase.n2));
			testCase.verifyFalse(testCase.n4.isDescendantOf(testCase.n2));
			testCase.verifyFalse(testCase.n5.isDescendantOf(testCase.n2));
			testCase.verifyFalse(testCase.n8.isDescendantOf(testCase.n2));
			testCase.verifyFalse(testCase.n9.isDescendantOf(testCase.n2));
		end


		function testIsSiblingOf(testCase)
			testCase.verifyTrue(testCase.n3.isSiblingOf(testCase.n4));
			testCase.verifyTrue(testCase.n3.isSiblingOf(testCase.n5));
			testCase.verifyFalse(testCase.n3.isSiblingOf(testCase.n6));
			testCase.verifyFalse(testCase.n3.isSiblingOf(testCase.n7));
			testCase.verifyFalse(testCase.n3.isSiblingOf(testCase.n8));
			testCase.verifyFalse(testCase.n3.isSiblingOf(testCase.n9));
			testCase.verifyFalse(testCase.n3.isSiblingOf(testCase.n10));
		end


		function testIsPropValueUnique(testCase)
			testCase.verifyTrue( ...
				TreeNode.isPropValueUnique( ...
				"children", testCase.n7, testCase.n1.getTree()));
			testCase.verifyTrue( ...
				TreeNode.isPropValueUnique( ...
				"parent", [1;1;1], testCase.n7.getTree()));
			testCase.verifyTrue( ...
				TreeNode.isPropValueUnique( ...
				"parent", testCase.root, testCase.n9.getBranch()));
			testCase.verifyTrue( ...
				TreeNode.isPropValueUnique( ...
				"parent", testCase.root, testCase.n1.getSiblings()));
		end

	end

end