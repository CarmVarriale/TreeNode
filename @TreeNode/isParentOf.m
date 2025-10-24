function flag = isParentOf(node, checkNode)
% Check if a node is parent of another node
arguments (Input)
	node (1,1) TreeNode
	checkNode (1,1) TreeNode
end
arguments (Output)
	flag (1,1) logical
end
flag = node == checkNode.parent();
end