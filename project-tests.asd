(defsystem "project-tests"
  :class :package-inferred-system
  :pathname "tests"
  :depends-on ("rove"
               "project-tests/lib/routes")
  :perform (test-op (o c) (symbol-call :rove '#:run c :style :dot)))
