import cowsay 
import random
import time

words = ['Hello World', 'I use arch btw', 'Sharks are my best friend', 'Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat.', 'Claudinho, não namora com essa rudicula da Raniele', 'Ta suave pô', '', 'no pain no gain']

randWords = random.randint(0, len(words) - 1)
randChars = random.randint(0, len(cowsay.char_names) - 1)

print(cowsay.get_output_string(cowsay.char_names[randChars], words[randWords]))

# print(">> randChars: ", randChars)
# print(">> randWords: ", randWords)
