extends Node

signal clock_updated
signal time_up

var hours := 24
var minutes := 0
var seconds := 0

func subtract_time(h := 0, m := 0, s := 0):
	seconds -= s
	minutes -= m
	hours -= h

	while seconds < 0:
		seconds += 60
		minutes -= 1

	while minutes < 0:
		minutes += 60
		hours -= 1

	if hours < 0:
		hours = 0
		minutes = 0
		seconds = 0
		time_up.emit()
	clock_updated.emit()
