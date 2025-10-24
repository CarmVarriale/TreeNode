function root = getRoot(node)
% Retrieve the root in the tree of the node
%
% Returns the root of the given node by recursively looking for
% parents. A node is considered a root if it has an empty parent.
arguments (Input)
	node (1,1) TreeNode
end
arguments (Output)
	root (1,1) TreeNode
end
if isempty(node.parent)
	root = node;
else
	root = node.parent.getRoot();
end
end