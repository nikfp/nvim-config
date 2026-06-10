;; whole do/end block as text object
(do_block) @do_block.outer

;; Inner body of do/end block
(do_block
  (call) @do_block.inner
  )
