import cowsay 
import random

words = ['Hello World', 'I use arch btw', 'Sharks are my best friend', 'Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat.', 'Claudinho, não namora com essa rudicula da Raniele', 'Ta suave pô', '', 'no pain no gain']
randWords = str(random.choice(words))
randChars = str(random.choice(cowsay.char_names))

# print(">> randChars: ", randChars, " type is :", type(randChars))
# print(">> randWords: ", randWords, " type is :", type(randWords))

print(cowsay.get_output_string(randChars, randWords))

