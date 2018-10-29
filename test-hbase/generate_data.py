#!/usr/bin/env python

from __future__ import print_function

import base64
import sys

if __name__ == '__main__':
  numRows = int(sys.argv[1])
  cf = base64.standard_b64encode(b'a:a').decode('utf-8')
  val = base64.standard_b64encode(b'hello world').decode('utf-8')
  print('{"Row":[')
  for x in range(numRows):
    rowKey = base64.standard_b64encode(str(x).encode()).decode('utf-8')
    print('{"key":"' + rowKey + '", "Cell": [{"column":"' + cf + '", "$":"' + val + '"}]}', end='')
    if(x < (numRows-1)):
      print(',')
    else:
      print()
  print(']}')
