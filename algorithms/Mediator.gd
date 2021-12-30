class_name Mediator
extends Node2D

var actions := {}

func subscribe(action: String, call: FuncRef):
	if action in actions:
		actions[action].append(call)
	else:
		actions[action] = [call]


func action(action: String, args: Array):
	if not action in actions:
		return
	
	for call in actions[action]:
		if args.empty():
			call.call_func();
		else:
			call.call_funcv(args)
