--- Helpers generate test text for a variety of situations.
-- @module LoremIpsumUtils

local require = require(game:GetService("ReplicatedStorage"):WaitForChild("Nevermore"))

local RandomUtils = require("RandomUtils")
local String = require("String")

local LoremIpsumUtils = {}

local WORDS = {
	"lorem", "ipsum", "dolor", "sit", "amet", "consectetuer", "adipiscing", "elit", "sed", "diam", "nonummy",
	"nibh", "euismod", "tincidunt", "ut", "laoreet", "dolore", "magna", "aliquam", "erat"}

function LoremIpsumUtils.username(random)
	random = random or Random.new()

	local word = RandomUtils.choice(WORDS, random)
	if random:NextNumber() <= 0.5 then
		word = String.uppercaseFirstLetter(word)
	end

	-- leet speak
	if random:NextNumber() <= 0.5 then
		if random:NextNumber() <= 0.75 then
			word = word:gsub("o", "0")
		end
		if random:NextNumber() <= 0.75 then
			word = word:gsub("i", "1")
		end
		if random:NextNumber() <= 0.75 then
			word = word:gsub("i", "1")
		end
	end

	local number = random:NextNumber()
	if number <= 0.1 then
		return "xXx" .. RandomUtils.choice(WORDS) .. "xXx"
	elseif number <= 0.6 then
		return ("%s%03d"):format(word, random:NextInteger(0, 999))
	else
		return word
	end
end

function LoremIpsumUtils.sentence(numWords, random)
	random = random or Random.new()
	numWords = numWords or random:NextInteger(6, 12)

	local output = ""

	local commaIndexes = {}
	if random:NextNumber() >= 0.3 and numWords >= 8 then
		commaIndexes[random:NextInteger(4, 5)] = true
	end

	for w = 1, numWords do
		local word = RandomUtils.choice(WORDS, random)

		if w == 1 then
			output = output .. String.uppercaseFirstLetter(word)
		else
			if commaIndexes[w] then
				output = output .. ", " .. word
			else
				output = output .. " " .. word
			end
		end
	end

	output = output .. "."
	return output
end

function LoremIpsumUtils.paragraph(numSentences, createSentence, random)
	random = random or Random.new()
	numSentences = numSentences or random:NextInteger(5, 15)
	createSentence = createSentence or function()
		return LoremIpsumUtils.sentence(nil, random)
	end

	local output = ""
	for s=1, numSentences do
		output = output .. createSentence()

		if s ~= numSentences then
			output = output .. " "
		end
	end
	return output
end

function LoremIpsumUtils.document(numParagraphs, createParagraph, random)
	random = random or Random.new()
	numParagraphs = numParagraphs or 5
	createParagraph = createParagraph or function()
		return LoremIpsumUtils.paragraph(nil, nil, random)
	end

	local output = ""
	for p=1, numParagraphs do
		output = output .. createParagraph()
		if p ~= numParagraphs then
			output = output .. "\n\n"
		end
	end

	return output
end

return LoremIpsumUtils