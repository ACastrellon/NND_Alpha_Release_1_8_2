extends Node
#StaticData.gd

var word_list ={}

#var word_list_path ="res://StaticData/word_list.json" # initial build
#var word_list_path ="res://StaticData/word_list_v2.json" builds before alpha release
var word_list_path ="res://StaticData/word_list_alpha.json"

func load_json_file(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile =FileAccess.open(filePath,FileAccess.READ)
		var parsedResult =JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("Error reading file")
		
	else:
		print("File does not exist")

func _ready() -> void:
	word_list =load_json_file(word_list_path)
	pass # Replace with function body.

var CarriageBadges= {
	1: "が",#\u304c", # GA Hiragana
	2: "を",#\u3092", # WO Hiragana
	3: "に",#\u306B" # NI Hiragana
	4: "で",
	5: "の",
	6: "\u23F1"
}

var EngineBadges= {
	1: "だ",#\u3060", # DA Hiragana
	2: "い",#\u3044", # I Hiragana
	3: "う"#\u3046" # U Hiragana
}

var PropStampLabelDic={
	"ichidan": "1", 
	"godan": "5",
	"helper":"H",
	"na-adj": "な"
}

func _get_status_label(inputWord:Word)->String:
	var inputWordType = inputWord._get_word_type()
	
	match inputWordType:
		"VERB":
			var verbType =inputWord._get_verb_type()
			match verbType:
				"ichidan":
					return IchidanStampLabelDic[inputWord.formID]
				"godan":
					return GodanStampLabelDic[inputWord.formID]
				_:
					return "!!!"
		"ADJ":
			return IAdjectiveStampLabelDic[inputWord.formID]
		_:
			return "???"
	
func _get_polarity_label(inputString:String)->String:
	match inputString:
		"positive":
				return "+"
		"negative":
			return "-"
		_:
			return "XXX"
			
func _get_time_tense_label(inputString:String)->String:
	match inputString:
		"non-past":
				return "\u23F1"
		"past":
			return "\u23F1"
		_:
			return "???"

func _get_comp_label(inputString:String)->String:
	match inputString:
		"white-plus":
			return "+"
		"red-a":
			return "あ"
		"red-ku":
			return "く"
		"purple-i":
			return "い"
		"rose-te":
			return "て"
		_:
			return "?"

var GodanStampLabelDic={
	0: "あ", 
	1: "い",
	2: "う", 
	3: "え",
	4: "お",
	5: "て"
}

var IchidanStampLabelDic={
	0: "る", 
	1: "+",
	2: "て"
}

var IAdjectiveTable ={
	0: "い",
	1: "く",
	2: "くて",
	3: ""
}

var IAdjectiveStampLabelDic ={
	0: "い",
	1: "く",
	2: "て",
	3: "+"
}

var NounTable ={
	0:"",
	1:"じや",
	2:"で",
	3:"な",
}

var IchidanVerbTable= {
	0: "る",
	1: "",
	2: "て"
}

var GodanVerbTable= {
  0: { # base constant
	0: "わ",
	1: "い",
	2: "う",
	3: "え",
	4: "お",
	5: "って"
  },
  1: { # k-consonant
	0: "か",
	1: "き",
	2: "く",
	3: "け",
	4: "こ",
	5: "いて"
  },
  2: { # s-consonant
	0: "さ",
	1: "し",
	2: "す",
	3: "せ",
	4: "そ",
	5: "して"
  },
  3: { # t-consonant
	0: "た",
	1: "ち",
	2: "つ",
	3: "て",
	4: "と",
	5: "って"
  },
  4: { # n-consonant
	0: "な",
	1: "に",
	2: "ぬ",
	3: "ね",
	4: "の",
	5: "んで"
  },
  5: { # m-consonant
	0: "ま",
	1: "み",
	2: "む",
	3: "め",
	4: "も",
	5: "んで"
  },
  6: { # r-consonant
	0: "ら",
	1: "り",
	2: "る",
	3: "れ",
	4: "ろ",
	5: "って"
  },
  7: { # g-consonant
	0: "が",
	1: "ぎ",
	2: "ぐ",
	3: "げ",
	4: "ご",
	5: "いて"
  },
  8: { # b-consonant
	0: "ば",
	1: "び",
	2: "ぶ",
	3: "べ",
	4: "ぼ",
	5: "んで"
  }
}
