pragma circom 2.0.0; 

import "example.circom"

template MultiplierN (N){
   //Declaration of signals and components.
   signal input in[N];
   signal output out;
   component comp[N-1];

   //Statements.
   for(var i = 0; i < N-1; i++){
       comp[i] = Multiplier2();
   }

   // ... some more code (see below)

}

component main = MultiplierN(4);
