# Circom-Dev-SC

### Overview

![overview](./overview.png)

* Steps to create your verifier.sol for your circuit.

### Create your circuit file

* Create a file with .circom extension

```circom
pragma circom 2.0.0;

template Example () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;  
   signal output c;  

   // Constraints.  
   c <== a * b;  
}

component main = Example();
```

### Compile your circuit

```bash
circom example.circom --r1cs --wasm --sym --c
```

### Compute the witness (wasm)

```bash
cd circuits/example/example_js

node generate_witness.js example.wasm input.json witness.wtns
```

### Prove your circuit

* Clarification: You will need snarkjs for this steps.

* **Power of Tau**: 

```bash
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v
```

* contribution: 

```bash
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v
```

* **Phase 2**: 

```bash
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v
```

* **Zkey generation**: 

```bash
snarkjs groth16 setup example.r1cs pot12_final.ptau example_0000.zkey
```

* contribution:

```bash
snarkjs zkey contribute example_0000.zkey example_0001.zkey --name="1st Contributor Name" -v
```

* Export zkey: 

```bash
snarkjs zkey export verificationkey example_0001.zkey verification_key.json
```

* This will genrate a verification_key.json file.

### ZK-Proof generation

```bash
snarkjs groth16 prove example_0001.zkey witness.wtns proof.json public.json
```

>This command will output two files: 
>    * proof.json: It contains the proof.
>    * public.json: It contains the values of the public inputs and outputs.

### Verifying a Proof (manually)

```bash
snarkjs groth16 verify verification_key.json public.json proof.json
```

### Verifying from a Smart Contract

```bash
snarkjs zkey export solidityverifier example_0001.zkey verifier.sol
```
>* This command takes validation key multiplier2_0001.zkey and outputs Solidity code in a file named verifier.sol. You can take the code from this file and cut and paste it in Remix. You will see that the code contains two contracts: Pairing and Verifier. You only need to deploy the Verifier contract.

>* The Verifier has a view function called verifyProof that returns TRUE if and only if the proof and the inputs are valid. To facilitate the call, you can use snarkJS to generate the parameters of the call by typing:

```bash
snarkjs generatecall
```


