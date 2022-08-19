import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize, sent_tokenize

text = "Jaipur is the capital of India’s Rajasthan state. It evokes the royal family that once ruled the region and that, in 1727, founded what is now called the Old City, or “Pink City” for its trademark building color. At the center of its stately street grid (notable in India) stands the opulent, colonnaded City Palace complex. With gardens, courtyards and museums, part of it is still a royal residence"
def get_summary(text):
  # Tokenizing the text
  stopWords = set(stopwords.words("english"))
  words = word_tokenize(text)
  # Creating a frequency table to keep the 
  # score of each word
  freqTable = dict()
  for word in words:
    word = word.lower()
    if word in stopWords:
      continue
      if word in freqTable:
        freqTable[word] += 1
      else:
        freqTable[word] = 1
  # Creating a dictionary to keep the score
  # of each sentence
  sentences = sent_tokenize(text)
  sentenceValue = dict()
  for sentence in sentences:
    for word, freq in freqTable.items():
      if word in sentence.lower():
        if sentence in sentenceValue:
          sentenceValue[sentence] += freq
        else:
          sentenceValue[sentence] = freq
  sumValues = 0
  for sentence in sentenceValue:
    sumValues += sentenceValue[sentence]
    if len(sentenceValue)!=0:
      # Average value of a sentence from the original text
      average = int(sumValues / len(sentenceValue))
    else:
      average = 1
      # Storing sentences into our summary.
  summary = ''
  for sentence in sentences:
    if (sentence in sentenceValue) and (sentenceValue[sentence] > (1.2 * average)):
      summary += " " + sentence
    else:
      summary = text
  return(summary)

