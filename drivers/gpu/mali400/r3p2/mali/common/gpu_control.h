/*
 * gpu_control.h -- a control interface for the sgs3 and note2
 *
 *  Copyright (C) 2011 Michael Wodkins
 *  twitter - @xdanetarchy
 *  XDA-developers - netarchy
 *
 *  This program is free software; you can redistribute  it and/or modify it
 *  under  the terms of the GNU General Public License as published by the
 *  Free Software Foundation;
 *
 */

void gpu_control_start(void);

mali_bool mali_dvfs_table_update(void);
<<<<<<< HEAD
extern int gpu_voltage_default[MALI_DVFS_STEPS];
=======
>>>>>>> 750c8f6... gpu control: automatically apply correct voltages according to choosen freq (thanks to yank555-lu for his implementation)
