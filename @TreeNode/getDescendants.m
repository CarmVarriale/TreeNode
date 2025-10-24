function descendants = getDescendants(node)
% Retrieve the descendants of the specified nodes.
%
% Returns all the descendants of the given nodes, starting from
% their children and proceeding recursively until there are no
% children anymore. The initial node is not included in the
% descendants.
arguments (Input)
	node (1,1) TreeNode
end
arguments (Output)
	descendants (:,1) TreeNode
end
descendants = node.getChildren();
if ~isempty(descendants)
	for i = 1:numel(descendants)
		descendants = [
			descendants;
			descendants(i).getDescendants()]; %#ok
	end
end
end