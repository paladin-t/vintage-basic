module BasicLineScanner_test where

import Test.HUnit
import BasicAsserts
import BasicLineScanner
import BasicResult

assertRawParseResult = assertParseResult withLineAndCol ScanError rawLinesP
assertRawParseError  = assertParseError  withLineAndCol ScanError rawLinesP

test_LineScanner = TestCase $ do
  let text = unlines ["10SKDJF@#"," 5   ASJDKFdf "]
  assertRawParseResult text [(10, 3, "SKDJF@#"), (5, 6, "ASJDKFdf ")]
 
test_reports_error_if_line_doesn't_start_with_number = TestCase $ do
  let text = unlines ["10SKDJF@#","ASJD4KFdf "]
  assertRawParseError text "EXPECTING LINE NUMBER OR END OF FILE"
 
test_skips_blank_lines = TestCase $ do
  let text = unlines ["","10?","","20?",""]
  assertRawParseResult text [(10, 3, "?"), (20, 3, "?")]
 
test_reports_error_if_file_doesn't_end_in_newline = TestCase $ do
  let text = "10SKDJF@#"
  assertRawParseError text "UNEXPECTED END OF FILE\n EXPECTING NEW-LINE OR CHARACTER"
 
test_accepts_blank_line = TestCase $ do
  let text = unlines ["10"]
  assertRawParseResult text [(10, 3, "")]
