#!/usr/bin/env racket
#lang racket

;; Advent of Code 2018 - Åsmund Ødegård

(define (check-line line)
  (let* ((counts (for/fold ([counts (hash)])
                   ([chr (string->list line)])
                   (hash-update counts chr (lambda (i) (+ i 1)) 0)))
         (hash-vals (hash-values counts)))
    (values 
      (if (member 2 hash-vals) 1 0)
      (if (member 3 hash-vals) 1 0))))

(define (checksum)
  (let-values ([(dupe trip) 
               (for/fold ([dupe 0]
                          [trip 0])
                 ([line (file->lines "input.txt")])
                 (let-values ([(d t) (check-line line)])
                   (values 
                     (+ dupe d ) 
                     (+ trip t))))])
   (* dupe trip)))

;; Part 1 - day2
(displayln (checksum))
