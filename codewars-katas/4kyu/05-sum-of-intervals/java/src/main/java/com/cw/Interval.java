package com.cw;

import java.util.Arrays;

public class Interval {

  public static int sumIntervals(int[][] intervals) {

    if (intervals.length == 0) {
      return 0;
    }

    // sort outer array as to only have to account for 'ascending' overlap
    Arrays.sort(intervals, (a, b) -> a[0] - b[0]);

    int result = 0;
    int[] current_interval = intervals[0];

    // iterate outer array
    for (int i = 1; i < intervals.length; i++) {

      int[] next_interval = intervals[i];

      if (current_interval[1] >= next_interval[0]) {
        // if overlapping, only keep the bigger right limit
        current_interval[1] = Math.max(current_interval[1], next_interval[1]);
      }
      else {
        // if not overlapping, add the distance of current and prepare for next iteration
        result += current_interval[1] - current_interval[0];
        current_interval = next_interval;
      }
    }

    // add size of last considered interval to result
    result += current_interval[1] - current_interval[0];

    return result;
  }
}
