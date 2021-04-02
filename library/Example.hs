-- | An example module.
module Example where

import Types

a1 :: Author
a1 = Author "George Orwell"

a2 :: Author
a2 = Author "Alexandre Dumas"

b1 :: Book
b1 = Book "1984" a1

b2 :: Book
b2 = Book "The Count of Monte Cristo" a2

u1 :: User
u1 = User "frederik" [b1, b2]