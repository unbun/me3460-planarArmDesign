# ME3460 Planar Arm Design
design of planar arm and trajectory for final project of ME3460 in Simulink

# File Structure

* *planararm_workspace.m* : Using link lengths/transformation charecteristics to show the workspace of the arm at different angles w/ FK

* *inCircle.m* : Helper function to determine if a 2D Cartesian point is inside, outside, or on a circle

* *gripperarm.slx* : Simscape model of model to show that certain joint angles place the gripper correctly

* *gripperarm_traj_ctrl.slx* : Simscale model to show that certain trajectories translate the gripper to perform the desired task

* trajectory_planning/
	- *traj_design_posX.mlx* : Design of the trajectory of the end effector position in the x-direction over T=3
	- *traj_design_posY.mlx* : Design of the trajectory of the end effector position in the y-direction over T=3
	- *traj_design_speeds.mlx* : Design of the trajectory of the end effector speeds over T=3
	- *traj_design_joint_angles.mlx* : Script to design the trajectory of any joint angle piece-by-piece, given the desired starting and ending angle of 1 joint from a desired starting and ending time
