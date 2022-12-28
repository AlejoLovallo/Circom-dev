# Circom-Dev-SC

### Overview

![overview](./overview.png)

* Steps to create your verifier.sol for your circuit.

### Create your circuit file

* Create a file with .circom extension

```circom
pragma circom 2.0.0;

template Multiplier2 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;  
   signal output c;  

   // Constraints.  
   c <== a * b;  
}

component main = Multiplier2();
```

### 