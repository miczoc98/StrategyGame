extends Node2D

var actions := {}

func subscribe(action: String, call: FuncRef):
	if action in actions:
		actions[action].append(call)
	else:
		actions[action] = [call]
	
func action(action: String, args: Array):
	for call in actions[action]:
		call.call_funcv(args)
	

