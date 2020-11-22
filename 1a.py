# --
# 1a.py -- a table of the statistics
# --

import numpy as np
import pandas as pd
import nltk
import textblob
import math

TOP_MOST = 10
DATA_DIR = 'txt/'
DATA_FILES = ['benjamin-bunny.txt', 'ginger-pickles.txt', 'jeremy-fisher.txt', 'jungle-book.txt', 'just-so-stories.txt', 'kim.txt', 
              'man-who-would-be-king.txt', 'peter-rabbit.txt', 'puck-of-pooks-hill.txt', 'squirrel-nutkin.txt']
freq_words = [ dict() for j in range( len( DATA_FILES )) ]  # initalise list of dictionaries of most frequent words in each verse
word_counts = {}
term_counts = {}

#--get a list of "stopwords" (words to skip over)
with open("txt/english-stop-words-large.txt") as f:
    stopwords = f.read().split('\n')
    f.close()
print('fetching list of stopwords...')
print('number of stopwords = ' + str( len( stopwords )))

#--loop to read in the verses
for ( j, myfile ) in zip( range( len( DATA_FILES )), DATA_FILES ):
    with open( DATA_DIR+myfile ) as f:
        raw_verse = f.read()
    f.close()
# initialise a TextBlob object using the verse (this will decode any UTF-8 characters in the file)
    verse = textblob.TextBlob( raw_verse) 

#--create a dictionary of words for this verse, removing the stopwords
    words = {}    
    for w in verse.word_counts:
        if ( w not in stopwords ):
            words[w] = verse.word_counts[w]
    word_counts[myfile] = sum(words.values())
    term_counts[myfile] = len(words.keys())
 
    # sort the words in order to find the TOP_MOST most frequent
    sorted_words = sorted( words, key=words.__getitem__, reverse=True )
    for ( i, w ) in zip( range( TOP_MOST ), sorted_words ):
        freq_words[j][w] = verse.word_counts[w]        


# (a) polarity
polarity = {}
for ( j, myfile ) in zip( range( len( DATA_FILES )), DATA_FILES ):
    with open( DATA_DIR+myfile ) as f:
        raw_verse = f.read()
    f.close()
    blob = textblob.TextBlob(raw_verse)
    polarity[myfile] = blob.sentiment.polarity
print("Polarity: ", polarity)

# (b) subjectivity
subjectivity = {}
for ( j, myfile ) in zip( range( len( DATA_FILES )), DATA_FILES ):
    with open( DATA_DIR+myfile ) as f:
        raw_verse = f.read()
    f.close()
    blob = textblob.TextBlob(raw_verse)
    subjectivity[myfile] = blob.sentiment.subjectivity
print("Subjectivity: ", subjectivity)

# (c) word counts
print("word counts: ", word_counts)

# (d) most frequent word in the book
most_freq_term = [list(i.keys())[0] for i in freq_words]

# (e) normalised frequency of most frequent word (normalised by the word count)
freq_counts = [list(i.values())[0] for i in freq_words]
word_counts_list = list(word_counts.values())
normalised = []
for i in range(len(freq_counts)):
    normalised.append(round(freq_counts[i]/word_counts_list[i],4))
print("normalised freq: ",normalised)

# (f) term frequency of the most frequent word in the book
term_counts_list = list(term_counts.values())
tf = []
for i in range(len(freq_counts)):
    tf.append(round(freq_counts[i]/term_counts_list[i],4))
print("tf: ",tf)

# (g) inverse document frequency of the most frequent word in the book
lst =[]
for ( j, myfile ) in zip( range( len( DATA_FILES )), DATA_FILES ):
    with open( DATA_DIR+myfile ) as f:
        raw_verse = f.read()
    f.close()
    verse = textblob.TextBlob(raw_verse)    
    for w in verse.word_counts:
        if ( w not in stopwords ):
            lst.append(w)
def countX(lst, x): 
    count = 0
    for ele in lst: 
        if (ele == x): 
            count = count + 1
    return count
IDF = []
DF = {}
M = 10
for term in most_freq_term:
    DF[term] = countX(lst, term)
    idf = math.log((M-DF[term]+0.5)/DF[term]+0.5)
    IDF.append(idf)
print("idf: ",IDF)

# (h) TF-IDF for the most frequent word in the book
tf_idf = np.asarray(tf)* np.asarray(IDF)

# table of the statistics above
table = pd.DataFrame.from_dict(polarity, orient = 'index', columns = ['polarity'])
table['subjectivity'] = subjectivity.values()
table['word counts'] = word_counts.values()
table['most_freq_term'] = most_freq_term
table['normalised freq'] = normalised
table['tf'] = tf
table['idf'] = IDF
table['tf_idf'] = tf_idf
print(table)           

