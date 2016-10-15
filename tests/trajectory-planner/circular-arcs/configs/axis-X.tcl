# create HAL signals for position commands from motion module
# loop position commands back to motion module feedback
net Xpos joint.0.motor-pos-cmd => joint.0.motor-pos-fb ddt_x.in

# send the position commands thru differentiators to
# generate velocity and accel signals
net Xvel ddt_x.out => ddt_xv.in vel_xy.in0
net Xacc <= ddt_xv.out

#Conservative limits
set acc_limit 1.0001
set vel_limit 1.01

setp wcomp_xacc.max $::AXIS_X(MAX_ACCELERATION)*$acc_limit
setp wcomp_xacc.min $::AXIS_X(MAX_ACCELERATION)*-1.0*$acc_limit
setp wcomp_xvel.max $::AXIS_X(MAX_VELOCITY)*$vel_limit
setp wcomp_xvel.min $::AXIS_X(MAX_VELOCITY)*-1.0*$vel_limit

# Enable match_all pins for X axis
setp match_all.b0 1
setp match_all.b1 1
