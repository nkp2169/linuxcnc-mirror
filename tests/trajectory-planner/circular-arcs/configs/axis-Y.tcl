# create HAL signals for position commands from motion module
# loop position commands back to motion module feedback
net Ypos joint.1.motor-pos-cmd => joint.1.motor-pos-fb ddt_y.in

# send the position commands thru differentiators to
# generate velocity and accel signals
net Yvel ddt_y.out => ddt_yv.in vel_xy.in1
net Yacc <= ddt_yv.out

#Conservative limits
set acc_limit 1.0001
set vel_limit 1.01

setp wcomp_yacc.max $::AXIS_Y(MAX_ACCELERATION)*$acc_limit
setp wcomp_yacc.min $::AXIS_Y(MAX_ACCELERATION)*-1.0*$acc_limit
setp wcomp_yvel.max $::AXIS_Y(MAX_VELOCITY)*$vel_limit
setp wcomp_yvel.min $::AXIS_Y(MAX_VELOCITY)*-1.0*$vel_limit

# Enable match_all pins for Y axis
setp match_all.b2 1
setp match_all.b3 1
