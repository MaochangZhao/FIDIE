# Code for Paper FIDIE
Enhancing Image Security through a Novel 2D Spatiotemporal Chaos and Fractal-Based Encryption Scheme

# Abstact
In recent years, the security of multimedia data, particularly digital images, has become a pressing concern. To address this, we introduce a novel image encryption algorithm leveraging 2D spatiotemporal chaos and a fractal index dynamic S-box (FID S-box).  The FID S-box dynamically updates in each iteration, enhancing security, while our proposed 2D unidirectional random coupling map lattice (2D URCML) exhibits superior chaotic characteristics and pseudo-randomness. Through extensive simulations and security analyses, we demonstrate that our algorithm effectively resists statistical and differential attacks, exhibiting high security, efficiency, and robustness. This work contributes a significant advancement in image encryption, underscoring the potential of chaos and fractal theories in securing multimedia data.

# Dataset
The CSet8 dataset is openly available at https://www.eecs.qmul.ac.uk/~phao/IP/Images/
The USC-SIPI image dataset is openly available at https://sipi.usc.edu/database/database.php?volume=misc&image=1#top.

# Info
### encryption.m
Main function of the image encryption algorithm; run this function to encrypt.

### decryption.m
Decryption function; use this function with the key to decrypt.

### confusion.m
Pixel scrambling function.

### diffusion_sbox.m
Function for diffusion method using S-box.

### URCML.m
2D unidirectional random coupling map lattice.
