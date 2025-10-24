function subTree = getBranch(node)
% Retrieve all nodes in the branch of the specified
% node
%
% Returns the nodes from the root to the last descendant only on
% the same branch of the specified node, including the node itself.
arguments (Input)
	node (1,1) TreeNode
end
arguments (Output)
	subTree (:,1) TreeNode
end
subTree = [node.getAncestors(); node; node.getDescendants()];
end