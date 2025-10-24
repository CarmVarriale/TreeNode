function tree = getTree(node)
% Retrieve all nodes in the tree of the specified node
%
% Returns all nodes in in the tree where the specified node belongs,
% exploring all branches from the root to every last descendant, and
% including the specified node itself.
arguments (Input)
	node (1,1) TreeNode
end
arguments (Output)
	tree (:,1) TreeNode
end
root = node.getRoot();
tree = [root; root.getDescendants()];
end