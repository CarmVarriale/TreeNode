classdef TreeNode < handle
	% Hierarchical tree data structure.
	%
	% This class implements a hierarchical tree data structure, where each
	% node is represented by a TreeNode object. The tree structure allows for
	% efficient organization and traversal of nodes in a parent-child
	% relationship.
	%
	% Each node can have zero or one parent, and zero or one or multiple
	% children. Some definitions:
	%	- Parent: a node 1 level up in the hierarchy.
	%	- Child: a node 1 level down in the hierarchy.
	%	- Siblings: nodes with the same parent, therefore at the same level
	%	of the hierarchy
	%	- Ancestor: a node N levels up in the hierarchy (N >=1).
	%	- Descendant: a node N levels down in the hierarchy (N >=1).
	%	- Root: the top-most Ancestor, it does not have a parent.

	properties

		parent TreeNode {mustBeScalarOrEmpty}
		children TreeNode
		
	end

	methods

		%% Constructor
		function node = TreeNode(parent)
			% TreeNode constructor
			%
			% Initializes a TreeNode object.
			% If a parent is provided, it is a child node of that parent.
			% Otherwise, it is a root node of a new tree.
			%
			arguments
				parent TreeNode {mustBeScalarOrEmpty} = TreeNode.empty(1,0)
			end
			if nargin > 0
				node.parent = parent;
			end
		end


		%% Property Management
		function set.parent(node, parent)
			% Set the parent of the node and the child of the
			%	parent.
			%
			% Set-method that runs everytime the parent property is assigned.
			% The assigned parent must be different from the node itself.
			% If the current node already has a parent, the node is detached
			% from its parent, and assigned to the new parent.
			arguments (Input)
				node (1,1) TreeNode
				parent TreeNode {mustBeScalarOrEmpty} = TreeNode.empty
			end
			assert(parent ~= node, ...
				"TreeNode:set:parent", ...
				"Node cannot be its own parent");
			if ~isempty(node.parent)
				node.parent.remChild(node)
			end
			node.parent = parent;
			parent.addChild(node);
		end

	end

	%% Methods
	methods (Static)

		flag = isPropValueUnique(nodes, value, property)

	end

	methods (Sealed)

		ancestors = getAncestors(node, upTo)
		root = getRoot(node)
		children = getChildren(node)
		descendants = getDescendants(node)
		siblings = getSiblings(node)
		tree = getTree(node)
		subTree = getBranch(node)

		flag = isParentOf(node, checkNode)
		flag = isChildOf(node, checkNode)
		flag = isAncestorOf(node, checkNode)
		flag = isDescendantOf(node, checkNode)
		flag = isSiblingOf(node, checkNode)

	end

	methods (Access = private)

		addChild(node, child)
		remChild(node, child)
		remChildren(node)

	end

end