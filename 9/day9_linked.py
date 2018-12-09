#!/usr/bin/env python3
# Advent of Code 2018 - Åsmund Ødegård

import sys


class node:
    def __init__(s, val, nn, pn):
        s.val = val
        s.next = nn
        s.prev = pn

    def __repr__(s):
        return '%s (%s) %s' % (s.prev.val, s.val, s.next.val)

    def show(s, mark):
        if s == mark:
            return '(%s) ' % s.val
        return '%s ' % s.val


def read_line(fn):
    with open(fn, 'r') as f:
        line = f.readline().split()
    players = int(line[0])
    lastmarble = int(line[6])
    return (players, lastmarble)


def showall(base, mark):
    tmp = base
    show = []
    while tmp.next != base:
        show += tmp.show(mark)
        tmp = tmp.next
    show += tmp.show(mark)
    return ''.join(show)


def main(fn, mul=1):
    players, lastmarble = read_line(fn)
    lastmarble = lastmarble*int(mul)

    root = node(0, None, None)
    cur = node(1, root, root)
    root.next = cur
    root.prev = cur

    next_marble = 2
    cur_player = 2
    scores = {}

    while next_marble <= lastmarble:
        if next_marble % 23 == 0:
            # follow links 7 steps back
            for i in range(7):
                cur = cur.prev
            scores[cur_player] = scores.get(cur_player, 0) + next_marble + cur.val
            cur.prev.next = cur.next
            cur.next.prev = cur.prev
            cur = cur.next
        else:
            # insert new
            cur = cur.next
            link = cur.next
            cur.next = node(next_marble, link, cur)
            link.prev = cur.next
            cur = cur.next

        cur_player += 1 % players
        if cur_player > players:
            cur_player = 1
        next_marble += 1

    max_score = max([v for k, v in scores.items()])
    print([(k, v) for k, v in scores.items() if v == max_score])


if __name__ == '__main__':
    main(*sys.argv[1:])
