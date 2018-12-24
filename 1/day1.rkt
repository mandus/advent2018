#!/usr/bin/env racket
#lang racket

;; Advent of Code 2018 - Åsmund Ødegård

;; Part 1

(define (read-next-line-accumulate file sum)
    (let ((line (read-line file 'any)))
      (if (eof-object? line)
        ;; Display final sum:
        (printf "part 1: ~a~%" sum)
        (read-next-line-accumulate file (+ sum (string->number line))))))

(define (read-by-line file)
  (read-next-line-accumulate file 0))

(call-with-input-file "input.txt" read-by-line)

;; Part 2 - keep list in memory, and loop over and over..

(define (read-next-line-list file numbers)
  (let ((line (read-line file 'any)))
    (if (eof-object? line)
      (reverse numbers)
      (read-next-line-list file (cons (string->number line) numbers)))))

(define (read-by-line-to-list file)
  (read-next-line-list file null))

(define (accumulate-numbers numlist acc seen)
  (if (hash-has-key? seen acc)
    ;; If accumulated sum already in dict, we're done
    (cons acc #t)
    ;; Else, set the new accumulator in dict as 'true, pop off and add next value from
    ;; list and recurse
    (let ()
      (hash-set*! seen acc #t)
      (if (empty? numlist)
        (cons acc #f)
        (accumulate-numbers (rest numlist) (+ acc (first numlist)) seen)))))

(define (sum-numbers)
  (let ((numbers (call-with-input-file "input.txt"  read-by-line-to-list))
        (seen (make-hash)))

    (define (loop-till-done state)
      (if (cdr state)
        (car state)
        (loop-till-done 
          (accumulate-numbers (rest numbers) 
                              (+ (first numbers) (car state)) 
                              seen))))
    (loop-till-done (cons 0 #f))))

(printf "part 2: ~a~%" (sum-numbers))
