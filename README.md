# 2D FDTD using TMz equations for electric and magnetic waves simulation

The presented codes simulate electric and magnetic waves in free space with a perfect conductor as a boundary.

The **"fdtd_2d_electromagnetic_waves.m"** file was created as a answer to the question 3.7 and 3.8 of the book "Computational Electrodynamics. The Finite-Difference Time-Domain Method", 2nd Edition, (Allen Taflove, Susan C. Hagness). 

The **"instable_fdtd_2d.m"** file is the answer to question 3.9 of the same book.

# Question
Questions 3.7, 3.8, and 3.9 are shown below:

**3.7)**Construct a computer program that models two-dimensional TMz cylindrical-wave propagation in a uniform Yee grid. Use (3.41a), (3.41b), and (3.41c) as your time-stepping algorithm. Assume square unit cells dx = dx = delta, free space everywhere in the grid, and a time-step dt = delta / (c sqrt(2)). Terminate the grid in Ez = 0 components at its outer boundaries, thereby simulating the presence of PECs there. Set a single Ez component located at the center of the grid to a specific time function such as a unit step, a Gaussian pulse, or a sinusoid. This will generate a radially-propagating step, a Gaussian pulse, or a sinusoidal wave in the grid by the action of the Yee algorithm. Perform visualizations of the Ez, Hx and Hy fields of the outgoing wave distributed within the grid at a number of time snapshots before and after the wave reaches the outer grid boundary. Compare the spatial-symmetry properties of these fields with respect to the center of the grid where the excitation is applied.

**3.8)** Repeat Problem 3.7, but fill the grid with a uniform, electrically conductive medium. Vary the conductivity upward from zero, and observe how the outgoing wave is attenuated.

**3.9)** Repeat Problem 3.7, but now use the time-step dt = l.OO05* delta / (c * sqrt(2)).
