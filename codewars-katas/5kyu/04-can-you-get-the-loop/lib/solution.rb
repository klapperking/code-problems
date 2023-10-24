# frozen_string_literal: true

def loop_size(node)

  seen = [node]
  current_node = node

  count = 0
  loop do
    next_node = current_node.next

    if seen.include?(next_node)
      loop_start_pos = seen.index(next_node)
      return seen.slice!(loop_start_pos..).size
    end

    seen.push(next_node)
    current_node = next_node
  end
end
