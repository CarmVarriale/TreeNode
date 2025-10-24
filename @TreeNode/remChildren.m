function remChildren(node)
% Remove all children from node.
%
% Removes all children nodes from the specifiednode, clearing the
% children list. Each child's parent is also cleared.
for child = node.children'
	node.remChild(child);
end
end