# --
# 1b.py -- Mine the data for patterns
# Code reference to practical 7 solution p1.py
# --

import numpy as np
import pandas as pd
import nltk
import textblob
import sklearn.model_selection as modsel
import sklearn.naive_bayes as nb

TOP_MOST = 10
DATA_DIR = 'txt/'
DATA_FILES = ['benjamin-bunny.txt', 'ginger-pickles.txt', 'jeremy-fisher.txt', 'jungle-book.txt', 'just-so-stories.txt', 'kim.txt', 
              'man-who-would-be-king.txt', 'peter-rabbit.txt', 'puck-of-pooks-hill.txt', 'squirrel-nutkin.txt']
label = ['Potter', 'Potter', 'Potter', 'Kipling', 'Kipling', 'Kipling', 'Kipling', 'Potter', 'Kipling', 'Potter']

#-get a list of "stopwords" (words to skip over)
with open("txt/english-stop-words-large.txt") as f:
    stopwords = f.read().split('\n')
    f.close()
print('fetching list of stopwords...')
print('number of stopwords: ' + str(len(stopwords)))

# -- Read the data, store the verses into a list
verse = []
#--loop to read in the verses
for (j, myfile) in zip(range(len(DATA_FILES)), DATA_FILES):
    with open(DATA_DIR+myfile) as f:
        raw_verse = f.read()
    f.close()
    verse.append(raw_verse)

# -- Split data into training and test dataset
verse_train, verse_test, label_train, label_test = modsel.train_test_split(verse, label, test_size=0.50)

# -- Charactise the training dataset
X = []
for lines in (verse_train):
    # compute stats on message
    blob = textblob.TextBlob(lines)
    polarity = blob.sentiment.polarity
    subjectivity = blob.sentiment.subjectivity
    words = {}
    for w in blob.word_counts:
        if (w not in stopwords):
            words[w] = blob.word_counts[w]
    word_counts = sum(words.values())
    sorted_words = sorted(words, key=words.__getitem__, reverse=True)
    most_freq = sorted_words[0]
    # store attributes in matrix
    X.append((polarity, subjectivity, word_counts))
X = np.array(X)
label_train = np.array(label_train)
print(X)
print(label_train)

#-- Train Classifier
clf = nb.MultinomialNB()
clf.fit( X, label_train )

# test classifier
TP = 0
TN = 0
FP = 0
FN = 0
err = 0
for (lines, label) in zip(verse_test, label_test):

    # compute stats on message
    blob = textblob.TextBlob(lines)
    polarity = blob.sentiment.polarity
    subjectivity = blob.sentiment.subjectivity
    words = {}
    for w in blob.word_counts:
        if (w not in stopwords):
            words[w] = blob.word_counts[w]
    word_counts = sum(words.values())
    sorted_words = sorted(words, key=words.__getitem__, reverse=True)
    most_freq = sorted_words[0]

    # store attributes in vector
    A = np.array((polarity, subjectivity, word_counts))
    A = A.reshape( 1, -1 )

    # predict class
    pred_label = clf.predict(A) 
    
    if (label == 'Kipling'):
        if (pred_label == 'Kipling'):
            TP += 1
        elif (pred_label == 'Potter'):
            FN += 1
            err += 1
    elif (label == 'Potter'):
        if (pred_label == 'Kipling'):
            FP += 1
            err += 1
        elif (pred_label == 'Potter'):
            TN += 1  

# show data errors?
if (err > 0):
    print ('number of errors in data set: %d' % (err))

# print confusion matrix
print ('TP: %d FP: %d TN: %d FN: %d' % (TP, FP, TN, FN))

precision = TP / float(TP + FP)
recall = TP / float(TP + FN)
f1 = 2 * precision * recall / ( precision + recall )
print ('precision: %f recall: %f f1: %f' % ( precision, recall, f1 ))
