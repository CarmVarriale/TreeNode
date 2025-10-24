function children = getChildren(node)
% Retrieve the children of the specified node.
arguments (Input)
	node (1,1) TreeNode
end
arguments (Output)
	children (:,1) TreeNode
end
children = vertcat(node.children);
end