From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Wed, 13 May 2015 06:50:49 +0000
Subject: [Bug Report] PM: Warning messages
Message-Id: <5552F449.6030509@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Error occurs when sending mail, so I re-send it again.

Hi All.

We are testing Linux upstream version-4.1-rc2 on Koelsch and Lager.
We found Warning messages of PM after resuming system.
The Warning messages is showed as below:

"WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 26 wake disable
CPU: 0 PID: 1697 Comm: bash Tainted: G W 4.1.0-rc2 #59
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
[<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
[<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
r5:00000009 r4:ee2d1c98
[<c00271dc>] (warn_slowpath_common) from [<c00272fc>] 
(warn_slowpath_fmt+0x38/0x40)
r9:00000000 r8:00000000 r7:00000010 r6:0000001a r5:ee8dda00 r4:00000000
[<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>] 
(irq_set_irq_wake+0x9c/0xf8)
..."

Testing method:
# echo enabled > 
/sys/devices/platform/e6c40000.serial/tty/ttySC0/power/wakeup
# echo mem > /sys/power/state
# Resuming system by a key from keyboard.

We'd like to report this problem first.
There are no warning messages at version v4.0 stable.
so we are looking for the error patch that added between v4.0 and v4.1-rc2.

Best Regards,
Jinso/Cao Minh Hiep.

We'd like to send the details of PM's Warning messages on two Board:
Koelsch_PM_supend-resume_warning_messages
Lager_PM_supend-resume_warning_messages
==========================
Koelsch_PM_supend-resume_warning_messages:

root@linaro-nano:~# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.017 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.011 seconds) done.
Suspending console(s) (use no_console_suspend to debug)

PM: suspend of devices complete after 123.237 msecs
PM: late suspend of devices complete after 4.790 msecs
PM: noirq suspend of devices complete after 17.415 msecs
Disabling non-boot CPUs ...
PM: noirq resume of devices complete after 19.764 msecs
PM: early resume of devices complete after 3.218 msecs
sh-eth ee700000.ethernet eth0: attached PHY 1 (IRQ 404) to driver Micrel 
KSZ8041RNLI
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 26 wake disable
CPU: 0 PID: 1697 Comm: bash Tainted: G        W       4.1.0-rc2 #59
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
  r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
[<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
[<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:ee2d1c98
[<c00271dc>] (warn_slowpath_common) from [<c00272fc>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:0000001a r5:ee8dda00 r4:00000000
[<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:0000001a r2:c061abc4
[<c005fda4>] (irq_set_irq_wake) from [<c0238444>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:0000011d r5:00000000 r4:ee359c30
[<c0238428>] (gpio_rcar_irq_set_wake) from [<c005ee40>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee35a100 r4:00000000
[<c005ee08>] (set_irq_wake_real) from [<c005fe5c>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee35a100 r4:00000001
[<c005fda4>] (irq_set_irq_wake) from [<c0370e24>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000000 r5:ee11e810 r4:ee11e810
[<c0370dc4>] (gpio_keys_resume) from [<c02c7514>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:ee985c44 r5:ee985c10 r4:c02c74cc
[<c02c74cc>] (platform_pm_resume) from [<c02cfc6c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cfc48>] (dpm_run_callback.isra.10) from [<c02d0450>] 
(device_resume+0x10c/0x134)
  r5:ee985c10 r4:00000001
[<c02d0344>] (device_resume) from [<c02d054c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:ee985c10 r6:c06e11a0 r5:c071be44 r4:ee985c78
[<c02d0478>] (dpm_resume) from [<c02d068c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f876c r8:c061704f r7:00000000 r6:00000003 r5:c06f876c
  r4:00000010
[<c02d0678>] (dpm_resume_end) from [<c005ae6c>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f876c r4:00000000
[<c005ac3c>] (suspend_devices_and_enter) from [<c005b0dc>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f8774 r8:c061704f r7:ee039a40 r6:00000003 r5:c071be48 r4:00000000
[<c005b030>] (pm_suspend) from [<c0059fcc>] (state_store+0xb0/0xc4)
  r7:ee039a40 r6:00000004 r5:00000003 r4:00000003
[<c0059f1c>] (state_store) from [<c020f2b0>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:ee2d1f80 r7:eeb186cc r6:eeb186c0 r5:ee039a40 r4:00000004
[<c020f294>] (kobj_attr_store) from [<c0121ef8>] (sysfs_kf_write+0x40/0x4c)
[<c0121eb8>] (sysfs_kf_write) from [<c01211ac>] 
(kernfs_fop_write+0x120/0x180)
[<c012108c>] (kernfs_fop_write) from [<c00caf24>] (__vfs_write+0x34/0xdc)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:ee2d1f80 r5:c012108c r4:ee21bc40
[<c00caef0>] (__vfs_write) from [<c00cb148>] (vfs_write+0xb4/0x13c)
  r7:ee2d1f80 r6:000be408 r5:ee21bc40 r4:00000004
[<c00cb094>] (vfs_write) from [<c00cb2b0>] (SyS_write+0x50/0x90)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:000be408 r5:ee21bc40 r4:ee21bc40
[<c00cb260>] (SyS_write) from [<c000fb60>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6ec4b58 r5:000be408 r4:00000004
---[ end trace 9fbc9ec083d72e15 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 26 wake disable
CPU: 0 PID: 1697 Comm: bash Tainted: G        W       4.1.0-rc2 #59
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
  r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
[<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
[<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:ee2d1c98
[<c00271dc>] (warn_slowpath_common) from [<c00272fc>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:0000001a r5:ee8dda00 r4:00000000
[<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:0000001a r2:c061abc4
[<c005fda4>] (irq_set_irq_wake) from [<c0238444>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:0000011e r5:00000000 r4:ee359c30
[<c0238428>] (gpio_rcar_irq_set_wake) from [<c005ee40>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee35a040 r4:00000000
[<c005ee08>] (set_irq_wake_real) from [<c005fe5c>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee35a040 r4:00000001
[<c005fda4>] (irq_set_irq_wake) from [<c0370e24>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000001 r5:ee11e810 r4:ee11e87c
[<c0370dc4>] (gpio_keys_resume) from [<c02c7514>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:ee985c44 r5:ee985c10 r4:c02c74cc
[<c02c74cc>] (platform_pm_resume) from [<c02cfc6c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cfc48>] (dpm_run_callback.isra.10) from [<c02d0450>] 
(device_resume+0x10c/0x134)
  r5:ee985c10 r4:00000001
[<c02d0344>] (device_resume) from [<c02d054c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:ee985c10 r6:c06e11a0 r5:c071be44 r4:ee985c78
[<c02d0478>] (dpm_resume) from [<c02d068c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f876c r8:c061704f r7:00000000 r6:00000003 r5:c06f876c
  r4:00000010
[<c02d0678>] (dpm_resume_end) from [<c005ae6c>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f876c r4:00000000
[<c005ac3c>] (suspend_devices_and_enter) from [<c005b0dc>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f8774 r8:c061704f r7:ee039a40 r6:00000003 r5:c071be48 r4:00000000
[<c005b030>] (pm_suspend) from [<c0059fcc>] (state_store+0xb0/0xc4)
  r7:ee039a40 r6:00000004 r5:00000003 r4:00000003
[<c0059f1c>] (state_store) from [<c020f2b0>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:ee2d1f80 r7:eeb186cc r6:eeb186c0 r5:ee039a40 r4:00000004
[<c020f294>] (kobj_attr_store) from [<c0121ef8>] (sysfs_kf_write+0x40/0x4c)
[<c0121eb8>] (sysfs_kf_write) from [<c01211ac>] 
(kernfs_fop_write+0x120/0x180)
[<c012108c>] (kernfs_fop_write) from [<c00caf24>] (__vfs_write+0x34/0xdc)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:ee2d1f80 r5:c012108c r4:ee21bc40
[<c00caef0>] (__vfs_write) from [<c00cb148>] (vfs_write+0xb4/0x13c)
  r7:ee2d1f80 r6:000be408 r5:ee21bc40 r4:00000004
[<c00cb094>] (vfs_write) from [<c00cb2b0>] (SyS_write+0x50/0x90)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:000be408 r5:ee21bc40 r4:ee21bc40
[<c00cb260>] (SyS_write) from [<c000fb60>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6ec4b58 r5:000be408 r4:00000004
---[ end trace 9fbc9ec083d72e16 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 26 wake disable
CPU: 0 PID: 1697 Comm: bash Tainted: G        W       4.1.0-rc2 #59
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
  r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
[<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
[<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:ee2d1c98
[<c00271dc>] (warn_slowpath_common) from [<c00272fc>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:0000001a r5:ee8dda00 r4:00000000
[<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:0000001a r2:c061abc4
[<c005fda4>] (irq_set_irq_wake) from [<c0238444>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:0000011f r5:00000000 r4:ee359c30
[<c0238428>] (gpio_rcar_irq_set_wake) from [<c005ee40>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee35ef40 r4:00000000
[<c005ee08>] (set_irq_wake_real) from [<c005fe5c>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee35ef40 r4:00000001
[<c005fda4>] (irq_set_irq_wake) from [<c0370e24>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000002 r5:ee11e810 r4:ee11e8e8
[<c0370dc4>] (gpio_keys_resume) from [<c02c7514>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:ee985c44 r5:ee985c10 r4:c02c74cc
[<c02c74cc>] (platform_pm_resume) from [<c02cfc6c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cfc48>] (dpm_run_callback.isra.10) from [<c02d0450>] 
(device_resume+0x10c/0x134)
  r5:ee985c10 r4:00000001
[<c02d0344>] (device_resume) from [<c02d054c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:ee985c10 r6:c06e11a0 r5:c071be44 r4:ee985c78
[<c02d0478>] (dpm_resume) from [<c02d068c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f876c r8:c061704f r7:00000000 r6:00000003 r5:c06f876c
  r4:00000010
[<c02d0678>] (dpm_resume_end) from [<c005ae6c>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f876c r4:00000000
[<c005ac3c>] (suspend_devices_and_enter) from [<c005b0dc>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f8774 r8:c061704f r7:ee039a40 r6:00000003 r5:c071be48 r4:00000000
[<c005b030>] (pm_suspend) from [<c0059fcc>] (state_store+0xb0/0xc4)
  r7:ee039a40 r6:00000004 r5:00000003 r4:00000003
[<c0059f1c>] (state_store) from [<c020f2b0>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:ee2d1f80 r7:eeb186cc r6:eeb186c0 r5:ee039a40 r4:00000004
[<c020f294>] (kobj_attr_store) from [<c0121ef8>] (sysfs_kf_write+0x40/0x4c)
[<c0121eb8>] (sysfs_kf_write) from [<c01211ac>] 
(kernfs_fop_write+0x120/0x180)
[<c012108c>] (kernfs_fop_write) from [<c00caf24>] (__vfs_write+0x34/0xdc)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:ee2d1f80 r5:c012108c r4:ee21bc40
[<c00caef0>] (__vfs_write) from [<c00cb148>] (vfs_write+0xb4/0x13c)
  r7:ee2d1f80 r6:000be408 r5:ee21bc40 r4:00000004
[<c00cb094>] (vfs_write) from [<c00cb2b0>] (SyS_write+0x50/0x90)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:000be408 r5:ee21bc40 r4:ee21bc40
[<c00cb260>] (SyS_write) from [<c000fb60>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6ec4b58 r5:000be408 r4:00000004
---[ end trace 9fbc9ec083d72e17 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 26 wake disable
CPU: 0 PID: 1697 Comm: bash Tainted: G        W       4.1.0-rc2 #59
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
  r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
[<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
[<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:ee2d1c98
[<c00271dc>] (warn_slowpath_common) from [<c00272fc>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:0000001a r5:ee8dda00 r4:00000000
[<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:0000001a r2:c061abc4
[<c005fda4>] (irq_set_irq_wake) from [<c0238444>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:00000120 r5:00000000 r4:ee359c30
[<c0238428>] (gpio_rcar_irq_set_wake) from [<c005ee40>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee35ee80 r4:00000000
[<c005ee08>] (set_irq_wake_real) from [<c005fe5c>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee35ee80 r4:00000001
[<c005fda4>] (irq_set_irq_wake) from [<c0370e24>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000003 r5:ee11e810 r4:ee11e954
[<c0370dc4>] (gpio_keys_resume) from [<c02c7514>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:ee985c44 r5:ee985c10 r4:c02c74cc
[<c02c74cc>] (platform_pm_resume) from [<c02cfc6c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cfc48>] (dpm_run_callback.isra.10) from [<c02d0450>] 
(device_resume+0x10c/0x134)
  r5:ee985c10 r4:00000001
[<c02d0344>] (device_resume) from [<c02d054c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:ee985c10 r6:c06e11a0 r5:c071be44 r4:ee985c78
[<c02d0478>] (dpm_resume) from [<c02d068c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f876c r8:c061704f r7:00000000 r6:00000003 r5:c06f876c
  r4:00000010
[<c02d0678>] (dpm_resume_end) from [<c005ae6c>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f876c r4:00000000
[<c005ac3c>] (suspend_devices_and_enter) from [<c005b0dc>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f8774 r8:c061704f r7:ee039a40 r6:00000003 r5:c071be48 r4:00000000
[<c005b030>] (pm_suspend) from [<c0059fcc>] (state_store+0xb0/0xc4)
  r7:ee039a40 r6:00000004 r5:00000003 r4:00000003
[<c0059f1c>] (state_store) from [<c020f2b0>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:ee2d1f80 r7:eeb186cc r6:eeb186c0 r5:ee039a40 r4:00000004
[<c020f294>] (kobj_attr_store) from [<c0121ef8>] (sysfs_kf_write+0x40/0x4c)
[<c0121eb8>] (sysfs_kf_write) from [<c01211ac>] 
(kernfs_fop_write+0x120/0x180)
[<c012108c>] (kernfs_fop_write) from [<c00caf24>] (__vfs_write+0x34/0xdc)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:ee2d1f80 r5:c012108c r4:ee21bc40
[<c00caef0>] (__vfs_write) from [<c00cb148>] (vfs_write+0xb4/0x13c)
  r7:ee2d1f80 r6:000be408 r5:ee21bc40 r4:00000004
[<c00cb094>] (vfs_write) from [<c00cb2b0>] (SyS_write+0x50/0x90)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:000be408 r5:ee21bc40 r4:ee21bc40
[<c00cb260>] (SyS_write) from [<c000fb60>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6ec4b58 r5:000be408 r4:00000004
---[ end trace 9fbc9ec083d72e18 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 28 wake disable
CPU: 0 PID: 1697 Comm: bash Tainted: G        W       4.1.0-rc2 #59
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
  r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
[<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
[<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:ee2d1c98
[<c00271dc>] (warn_slowpath_common) from [<c00272fc>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:0000001c r5:ee8dd880 r4:00000000
[<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:0000001c r2:c061abc4
[<c005fda4>] (irq_set_irq_wake) from [<c0238444>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:0000015d r5:00000000 r4:ee359430
[<c0238428>] (gpio_rcar_irq_set_wake) from [<c005ee40>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee361e80 r4:00000000
[<c005ee08>] (set_irq_wake_real) from [<c005fe5c>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee361e80 r4:00000001
[<c005fda4>] (irq_set_irq_wake) from [<c0370e24>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000004 r5:ee11e810 r4:ee11e9c0
[<c0370dc4>] (gpio_keys_resume) from [<c02c7514>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:ee985c44 r5:ee985c10 r4:c02c74cc
[<c02c74cc>] (platform_pm_resume) from [<c02cfc6c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cfc48>] (dpm_run_callback.isra.10) from [<c02d0450>] 
(device_resume+0x10c/0x134)
  r5:ee985c10 r4:00000001
[<c02d0344>] (device_resume) from [<c02d054c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:ee985c10 r6:c06e11a0 r5:c071be44 r4:ee985c78
[<c02d0478>] (dpm_resume) from [<c02d068c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f876c r8:c061704f r7:00000000 r6:00000003 r5:c06f876c
  r4:00000010
[<c02d0678>] (dpm_resume_end) from [<c005ae6c>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f876c r4:00000000
[<c005ac3c>] (suspend_devices_and_enter) from [<c005b0dc>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f8774 r8:c061704f r7:ee039a40 r6:00000003 r5:c071be48 r4:00000000
[<c005b030>] (pm_suspend) from [<c0059fcc>] (state_store+0xb0/0xc4)
  r7:ee039a40 r6:00000004 r5:00000003 r4:00000003
[<c0059f1c>] (state_store) from [<c020f2b0>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:ee2d1f80 r7:eeb186cc r6:eeb186c0 r5:ee039a40 r4:00000004
[<c020f294>] (kobj_attr_store) from [<c0121ef8>] (sysfs_kf_write+0x40/0x4c)
[<c0121eb8>] (sysfs_kf_write) from [<c01211ac>] 
(kernfs_fop_write+0x120/0x180)
[<c012108c>] (kernfs_fop_write) from [<c00caf24>] (__vfs_write+0x34/0xdc)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:ee2d1f80 r5:c012108c r4:ee21bc40
[<c00caef0>] (__vfs_write) from [<c00cb148>] (vfs_write+0xb4/0x13c)
  r7:ee2d1f80 r6:000be408 r5:ee21bc40 r4:00000004
[<c00cb094>] (vfs_write) from [<c00cb2b0>] (SyS_write+0x50/0x90)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:000be408 r5:ee21bc40 r4:ee21bc40
[<c00cb260>] (SyS_write) from [<c000fb60>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6ec4b58 r5:000be408 r4:00000004
---[ end trace 9fbc9ec083d72e19 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 28 wake disable
CPU: 0 PID: 1697 Comm: bash Tainted: G        W       4.1.0-rc2 #59
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
  r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
[<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
[<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:ee2d1c98
[<c00271dc>] (warn_slowpath_common) from [<c00272fc>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:0000001c r5:ee8dd880 r4:00000000
[<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:0000001c r2:c061abc4
[<c005fda4>] (irq_set_irq_wake) from [<c0238444>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:0000015e r5:00000000 r4:ee359430
[<c0238428>] (gpio_rcar_irq_set_wake) from [<c005ee40>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee361dc0 r4:00000000
[<c005ee08>] (set_irq_wake_real) from [<c005fe5c>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee361dc0 r4:00000001
[<c005fda4>] (irq_set_irq_wake) from [<c0370e24>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000005 r5:ee11e810 r4:ee11ea2c
[<c0370dc4>] (gpio_keys_resume) from [<c02c7514>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:ee985c44 r5:ee985c10 r4:c02c74cc
[<c02c74cc>] (platform_pm_resume) from [<c02cfc6c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cfc48>] (dpm_run_callback.isra.10) from [<c02d0450>] 
(device_resume+0x10c/0x134)
  r5:ee985c10 r4:00000001
[<c02d0344>] (device_resume) from [<c02d054c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:ee985c10 r6:c06e11a0 r5:c071be44 r4:ee985c78
[<c02d0478>] (dpm_resume) from [<c02d068c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f876c r8:c061704f r7:00000000 r6:00000003 r5:c06f876c
  r4:00000010
[<c02d0678>] (dpm_resume_end) from [<c005ae6c>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f876c r4:00000000
[<c005ac3c>] (suspend_devices_and_enter) from [<c005b0dc>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f8774 r8:c061704f r7:ee039a40 r6:00000003 r5:c071be48 r4:00000000
[<c005b030>] (pm_suspend) from [<c0059fcc>] (state_store+0xb0/0xc4)
  r7:ee039a40 r6:00000004 r5:00000003 r4:00000003
[<c0059f1c>] (state_store) from [<c020f2b0>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:ee2d1f80 r7:eeb186cc r6:eeb186c0 r5:ee039a40 r4:00000004
[<c020f294>] (kobj_attr_store) from [<c0121ef8>] (sysfs_kf_write+0x40/0x4c)
[<c0121eb8>] (sysfs_kf_write) from [<c01211ac>] 
(kernfs_fop_write+0x120/0x180)
[<c012108c>] (kernfs_fop_write) from [<c00caf24>] (__vfs_write+0x34/0xdc)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:ee2d1f80 r5:c012108c r4:ee21bc40
[<c00caef0>] (__vfs_write) from [<c00cb148>] (vfs_write+0xb4/0x13c)
  r7:ee2d1f80 r6:000be408 r5:ee21bc40 r4:00000004
[<c00cb094>] (vfs_write) from [<c00cb2b0>] (SyS_write+0x50/0x90)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:000be408 r5:ee21bc40 r4:ee21bc40
[<c00cb260>] (SyS_write) from [<c000fb60>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6ec4b58 r5:000be408 r4:00000004
---[ end trace 9fbc9ec083d72e1a ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 28 wake disable
CPU: 0 PID: 1697 Comm: bash Tainted: G        W       4.1.0-rc2 #59
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
  r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
[<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
[<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:ee2d1c98
[<c00271dc>] (warn_slowpath_common) from [<c00272fc>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:0000001c r5:ee8dd880 r4:00000000
[<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:0000001c r2:c061abc4
[<c005fda4>] (irq_set_irq_wake) from [<c0238444>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:0000015f r5:00000000 r4:ee359430
[<c0238428>] (gpio_rcar_irq_set_wake) from [<c005ee40>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee361d00 r4:00000000
[<c005ee08>] (set_irq_wake_real) from [<c005fe5c>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee361d00 r4:00000001
[<c005fda4>] (irq_set_irq_wake) from [<c0370e24>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000006 r5:ee11e810 r4:ee11ea98
[<c0370dc4>] (gpio_keys_resume) from [<c02c7514>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:ee985c44 r5:ee985c10 r4:c02c74cc
[<c02c74cc>] (platform_pm_resume) from [<c02cfc6c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cfc48>] (dpm_run_callback.isra.10) from [<c02d0450>] 
(device_resume+0x10c/0x134)
  r5:ee985c10 r4:00000001
[<c02d0344>] (device_resume) from [<c02d054c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:ee985c10 r6:c06e11a0 r5:c071be44 r4:ee985c78
[<c02d0478>] (dpm_resume) from [<c02d068c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f876c r8:c061704f r7:00000000 r6:00000003 r5:c06f876c
  r4:00000010
[<c02d0678>] (dpm_resume_end) from [<c005ae6c>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f876c r4:00000000
[<c005ac3c>] (suspend_devices_and_enter) from [<c005b0dc>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f8774 r8:c061704f r7:ee039a40 r6:00000003 r5:c071be48 r4:00000000
[<c005b030>] (pm_suspend) from [<c0059fcc>] (state_store+0xb0/0xc4)
  r7:ee039a40 r6:00000004 r5:00000003 r4:00000003
[<c0059f1c>] (state_store) from [<c020f2b0>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:ee2d1f80 r7:eeb186cc r6:eeb186c0 r5:ee039a40 r4:00000004
[<c020f294>] (kobj_attr_store) from [<c0121ef8>] (sysfs_kf_write+0x40/0x4c)
[<c0121eb8>] (sysfs_kf_write) from [<c01211ac>] 
(kernfs_fop_write+0x120/0x180)
[<c012108c>] (kernfs_fop_write) from [<c00caf24>] (__vfs_write+0x34/0xdc)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:ee2d1f80 r5:c012108c r4:ee21bc40
[<c00caef0>] (__vfs_write) from [<c00cb148>] (vfs_write+0xb4/0x13c)
  r7:ee2d1f80 r6:000be408 r5:ee21bc40 r4:00000004
[<c00cb094>] (vfs_write) from [<c00cb2b0>] (SyS_write+0x50/0x90)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:000be408 r5:ee21bc40 r4:ee21bc40
[<c00cb260>] (SyS_write) from [<c000fb60>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6ec4b58 r5:000be408 r4:00000004
---[ end trace 9fbc9ec083d72e1b ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 28 wake disable
CPU: 0 PID: 1697 Comm: bash Tainted: G        W       4.1.0-rc2 #59
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
  r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
[<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
[<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:ee2d1c98
[<c00271dc>] (warn_slowpath_common) from [<c00272fc>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:0000001c r5:ee8dd880 r4:00000000
[<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:0000001c r2:c061abc4
[<c005fda4>] (irq_set_irq_wake) from [<c0238444>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:00000160 r5:00000000 r4:ee359430
[<c0238428>] (gpio_rcar_irq_set_wake) from [<c005ee40>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee361c40 r4:00000000
[<c005ee08>] (set_irq_wake_real) from [<c005fe5c>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee361c40 r4:00000001
[<c005fda4>] (irq_set_irq_wake) from [<c0370e24>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000007 r5:ee11e810 r4:ee11eb04
[<c0370dc4>] (gpio_keys_resume) from [<c02c7514>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:ee985c44 r5:ee985c10 r4:c02c74cc
[<c02c74cc>] (platform_pm_resume) from [<c02cfc6c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cfc48>] (dpm_run_callback.isra.10) from [<c02d0450>] 
(device_resume+0x10c/0x134)
  r5:ee985c10 r4:00000001
[<c02d0344>] (device_resume) from [<c02d054c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:ee985c10 r6:c06e11a0 r5:c071be44 r4:ee985c78
[<c02d0478>] (dpm_resume) from [<c02d068c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f876c r8:c061704f r7:00000000 r6:00000003 r5:c06f876c
  r4:00000010
[<c02d0678>] (dpm_resume_end) from [<c005ae6c>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f876c r4:00000000
[<c005ac3c>] (suspend_devices_and_enter) from [<c005b0dc>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f8774 r8:c061704f r7:ee039a40 r6:00000003 r5:c071be48 r4:00000000
[<c005b030>] (pm_suspend) from [<c0059fcc>] (state_store+0xb0/0xc4)
  r7:ee039a40 r6:00000004 r5:00000003 r4:00000003
[<c0059f1c>] (state_store) from [<c020f2b0>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:ee2d1f80 r7:eeb186cc r6:eeb186c0 r5:ee039a40 r4:00000004
[<c020f294>] (kobj_attr_store) from [<c0121ef8>] (sysfs_kf_write+0x40/0x4c)
[<c0121eb8>] (sysfs_kf_write) from [<c01211ac>] 
(kernfs_fop_write+0x120/0x180)
[<c012108c>] (kernfs_fop_write) from [<c00caf24>] (__vfs_write+0x34/0xdc)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:ee2d1f80 r5:c012108c r4:ee21bc40
[<c00caef0>] (__vfs_write) from [<c00cb148>] (vfs_write+0xb4/0x13c)
  r7:ee2d1f80 r6:000be408 r5:ee21bc40 r4:00000004
[<c00cb094>] (vfs_write) from [<c00cb2b0>] (SyS_write+0x50/0x90)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:000be408 r5:ee21bc40 r4:ee21bc40
[<c00cb260>] (SyS_write) from [<c000fb60>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6ec4b58 r5:000be408 r4:00000004
---[ end trace 9fbc9ec083d72e1c ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 28 wake disable
CPU: 0 PID: 1697 Comm: bash Tainted: G        W       4.1.0-rc2 #59
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
  r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
[<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
[<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:ee2d1c98
[<c00271dc>] (warn_slowpath_common) from [<c00272fc>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:0000001c r5:ee8dd880 r4:00000000
[<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:0000001c r2:c061abc4
[<c005fda4>] (irq_set_irq_wake) from [<c0238444>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:00000161 r5:00000000 r4:ee359430
[<c0238428>] (gpio_rcar_irq_set_wake) from [<c005ee40>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee361b80 r4:00000000
[<c005ee08>] (set_irq_wake_real) from [<c005fe5c>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee361b80 r4:00000001
[<c005fda4>] (irq_set_irq_wake) from [<c0370e24>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000008 r5:ee11e810 r4:ee11eb70
[<c0370dc4>] (gpio_keys_resume) from [<c02c7514>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:ee985c44 r5:ee985c10 r4:c02c74cc
[<c02c74cc>] (platform_pm_resume) from [<c02cfc6c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cfc48>] (dpm_run_callback.isra.10) from [<c02d0450>] 
(device_resume+0x10c/0x134)
  r5:ee985c10 r4:00000001
[<c02d0344>] (device_resume) from [<c02d054c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:ee985c10 r6:c06e11a0 r5:c071be44 r4:ee985c78
[<c02d0478>] (dpm_resume) from [<c02d068c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f876c r8:c061704f r7:00000000 r6:00000003 r5:c06f876c
  r4:00000010
[<c02d0678>] (dpm_resume_end) from [<c005ae6c>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f876c r4:00000000
[<c005ac3c>] (suspend_devices_and_enter) from [<c005b0dc>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f8774 r8:c061704f r7:ee039a40 r6:00000003 r5:c071be48 r4:00000000
[<c005b030>] (pm_suspend) from [<c0059fcc>] (state_store+0xb0/0xc4)
  r7:ee039a40 r6:00000004 r5:00000003 r4:00000003
[<c0059f1c>] (state_store) from [<c020f2b0>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:ee2d1f80 r7:eeb186cc r6:eeb186c0 r5:ee039a40 r4:00000004
[<c020f294>] (kobj_attr_store) from [<c0121ef8>] (sysfs_kf_write+0x40/0x4c)
[<c0121eb8>] (sysfs_kf_write) from [<c01211ac>] 
(kernfs_fop_write+0x120/0x180)
[<c012108c>] (kernfs_fop_write) from [<c00caf24>] (__vfs_write+0x34/0xdc)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:ee2d1f80 r5:c012108c r4:ee21bc40
[<c00caef0>] (__vfs_write) from [<c00cb148>] (vfs_write+0xb4/0x13c)
  r7:ee2d1f80 r6:000be408 r5:ee21bc40 r4:00000004
[<c00cb094>] (vfs_write) from [<c00cb2b0>] (SyS_write+0x50/0x90)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:000be408 r5:ee21bc40 r4:ee21bc40
[<c00cb260>] (SyS_write) from [<c000fb60>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6ec4b58 r5:000be408 r4:00000004
---[ end trace 9fbc9ec083d72e1d ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 28 wake disable
CPU: 0 PID: 1697 Comm: bash Tainted: G        W       4.1.0-rc2 #59
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
  r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
[<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
[<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:ee2d1c98
[<c00271dc>] (warn_slowpath_common) from [<c00272fc>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:0000001c r5:ee8dd880 r4:00000000
[<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:0000001c r2:c061abc4
[<c005fda4>] (irq_set_irq_wake) from [<c0238444>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:00000162 r5:00000000 r4:ee359430
[<c0238428>] (gpio_rcar_irq_set_wake) from [<c005ee40>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee361ac0 r4:00000000
[<c005ee08>] (set_irq_wake_real) from [<c005fe5c>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee361ac0 r4:00000001
[<c005fda4>] (irq_set_irq_wake) from [<c0370e24>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000009 r5:ee11e810 r4:ee11ebdc
[<c0370dc4>] (gpio_keys_resume) from [<c02c7514>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:ee985c44 r5:ee985c10 r4:c02c74cc
[<c02c74cc>] (platform_pm_resume) from [<c02cfc6c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cfc48>] (dpm_run_callback.isra.10) from [<c02d0450>] 
(device_resume+0x10c/0x134)
  r5:ee985c10 r4:00000001
[<c02d0344>] (device_resume) from [<c02d054c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:ee985c10 r6:c06e11a0 r5:c071be44 r4:ee985c78
[<c02d0478>] (dpm_resume) from [<c02d068c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f876c r8:c061704f r7:00000000 r6:00000003 r5:c06f876c
  r4:00000010
[<c02d0678>] (dpm_resume_end) from [<c005ae6c>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f876c r4:00000000
[<c005ac3c>] (suspend_devices_and_enter) from [<c005b0dc>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f8774 r8:c061704f r7:ee039a40 r6:00000003 r5:c071be48 r4:00000000
[<c005b030>] (pm_suspend) from [<c0059fcc>] (state_store+0xb0/0xc4)
  r7:ee039a40 r6:00000004 r5:00000003 r4:00000003
[<c0059f1c>] (state_store) from [<c020f2b0>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:ee2d1f80 r7:eeb186cc r6:eeb186c0 r5:ee039a40 r4:00000004
[<c020f294>] (kobj_attr_store) from [<c0121ef8>] (sysfs_kf_write+0x40/0x4c)
[<c0121eb8>] (sysfs_kf_write) from [<c01211ac>] 
(kernfs_fop_write+0x120/0x180)
[<c012108c>] (kernfs_fop_write) from [<c00caf24>] (__vfs_write+0x34/0xdc)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:ee2d1f80 r5:c012108c r4:ee21bc40
[<c00caef0>] (__vfs_write) from [<c00cb148>] (vfs_write+0xb4/0x13c)
  r7:ee2d1f80 r6:000be408 r5:ee21bc40 r4:00000004
[<c00cb094>] (vfs_write) from [<c00cb2b0>] (SyS_write+0x50/0x90)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:000be408 r5:ee21bc40 r4:ee21bc40
[<c00cb260>] (SyS_write) from [<c000fb60>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6ec4b58 r5:000be408 r4:00000004
---[ end trace 9fbc9ec083d72e1e ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1697 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 28 wake disable
CPU: 0 PID: 1697 Comm: bash Tainted: G        W       4.1.0-rc2 #59
Hardware name: Generic R8A7791 (Flattened Device Tree)
Backtrace:
[<c0012f18>] (dump_backtrace) from [<c00130c0>] (show_stack+0x18/0x1c)
  r7:c061aaaa r6:eebbe640 r5:00000009 r4:00000000
[<c00130a8>] (show_stack) from [<c0503874>] (dump_stack+0x78/0x94)
[<c05037fc>] (dump_stack) from [<c0027264>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:ee2d1c98
[<c00271dc>] (warn_slowpath_common) from [<c00272fc>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:0000001c r5:ee8dd880 r4:00000000
[<c00272c8>] (warn_slowpath_fmt) from [<c005fe40>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:0000001c r2:c061abc4
[<c005fda4>] (irq_set_irq_wake) from [<c0238444>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:00000163 r5:00000000 r4:ee359430
[<c0238428>] (gpio_rcar_irq_set_wake) from [<c005ee40>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee361a00 r4:00000000
[<c005ee08>] (set_irq_wake_real) from [<c005fe5c>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee361a00 r4:00000001
[<c005fda4>] (irq_set_irq_wake) from [<c0370e24>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:0000000a r5:ee11e810 r4:ee11ec48
[<c0370dc4>] (gpio_keys_resume) from [<c02c7514>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:ee985c44 r5:ee985c10 r4:c02c74cc
[<c02c74cc>] (platform_pm_resume) from [<c02cfc6c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cfc48>] (dpm_run_callback.isra.10) from [<c02d0450>] 
(device_resume+0x10c/0x134)
  r5:ee985c10 r4:00000001
[<c02d0344>] (device_resume) from [<c02d054c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:ee985c10 r6:c06e11a0 r5:c071be44 r4:ee985c78
[<c02d0478>] (dpm_resume) from [<c02d068c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f876c r8:c061704f r7:00000000 r6:00000003 r5:c06f876c
  r4:00000010
[<c02d0678>] (dpm_resume_end) from [<c005ae6c>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f876c r4:00000000
[<c005ac3c>] (suspend_devices_and_enter) from [<c005b0dc>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f8774 r8:c061704f r7:ee039a40 r6:00000003 r5:c071be48 r4:00000000
[<c005b030>] (pm_suspend) from [<c0059fcc>] (state_store+0xb0/0xc4)
  r7:ee039a40 r6:00000004 r5:00000003 r4:00000003
[<c0059f1c>] (state_store) from [<c020f2b0>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:ee2d1f80 r7:eeb186cc r6:eeb186c0 r5:ee039a40 r4:00000004
[<c020f294>] (kobj_attr_store) from [<c0121ef8>] (sysfs_kf_write+0x40/0x4c)
[<c0121eb8>] (sysfs_kf_write) from [<c01211ac>] 
(kernfs_fop_write+0x120/0x180)
[<c012108c>] (kernfs_fop_write) from [<c00caf24>] (__vfs_write+0x34/0xdc)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:ee2d1f80 r5:c012108c r4:ee21bc40
[<c00caef0>] (__vfs_write) from [<c00cb148>] (vfs_write+0xb4/0x13c)
  r7:ee2d1f80 r6:000be408 r5:ee21bc40 r4:00000004
[<c00cb094>] (vfs_write) from [<c00cb2b0>] (SyS_write+0x50/0x90)
  r9:ee2d0000 r8:c000fd04 r7:00000004 r6:000be408 r5:ee21bc40 r4:ee21bc40
[<c00cb260>] (SyS_write) from [<c000fb60>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6ec4b58 r5:000be408 r4:00000004
---[ end trace 9fbc9ec083d72e1f ]---
usb usb1: root hub lost power or was reset
PM: resume of devices complete after 264.899 msecs
Restarting tasks ... done.
root@linaro-nano:~#
root@linaro-nano:~# ata1: link resume succeeded after 1 retries
ata1: SATA link down (SStatus 0 SControl 300)
sh-eth ee700000.ethernet eth0: Link is Up - 100Mbps/Full - flow control 
rx/tx



=========================
Lager_PM_supend-resume_warning_messages:


root@linaro-nano:~#
root@linaro-nano:~#
root@linaro-nano:~#
SC0/power/wakeup:~# echo enabled > 
/sys/devices/platform/e6c40000.serial/tty/tty
root@linaro-nano:~# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.013 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.011 seconds) done.
Suspending console(s) (use no_console_suspend to debug)

PM: suspend of devices complete after 123.371 msecs
PM: late suspend of devices complete after 5.794 msecs
PM: noirq suspend of devices complete after 25.512 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1 is up
CPU2 is up
CPU3 is up
PM: noirq resume of devices complete after 16.405 msecs
PM: early resume of devices complete after 3.688 msecs
sh-eth ee700000.ethernet eth0: attached PHY 1 (IRQ 341) to driver Micrel 
KSZ8041RNLI
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2154 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 22 wake disable
CPU: 0 PID: 2154 Comm: bash Not tainted 4.1.0-rc2 #1
Hardware name: Generic R8A7790 (Flattened Device Tree)
usb usb1: root hub lost power or was reset
Backtrace:
[<c0012f50>] (dump_backtrace) from [<c00130f8>] (show_stack+0x18/0x1c)
  r7:c06166af r6:ede2aa40 r5:00000009 r4:00000000
[<c00130e0>] (show_stack) from [<c04ff57c>] (dump_stack+0x78/0x94)
[<c04ff504>] (dump_stack) from [<c0027248>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:eeacdc98
[<c00271c0>] (warn_slowpath_common) from [<c00272e0>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:00000016 r5:ee895640 r4:00000000
[<c00272ac>] (warn_slowpath_fmt) from [<c005fba0>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:00000016 r2:c06167c9
[<c005fb04>] (irq_set_irq_wake) from [<c0235d04>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:000000a6 r5:00000000 r4:ee2d3230
[<c0235ce8>] (gpio_rcar_irq_set_wake) from [<c005eba0>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee3e41c0 r4:00000000
[<c005eb68>] (set_irq_wake_real) from [<c005fbbc>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee3e41c0 r4:00000001
[<c005fb04>] (irq_set_irq_wake) from [<c036cf0c>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000000 r5:ee212e10 r4:ee212e10
[<c036ceac>] (gpio_keys_resume) from [<c02c3b14>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:eea8cc44 r5:eea8cc10 r4:c02c3acc
[<c02c3acc>] (platform_pm_resume) from [<c02cc26c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cc248>] (dpm_run_callback.isra.10) from [<c02cca50>] 
(device_resume+0x10c/0x134)
  r5:eea8cc10 r4:00000001
[<c02cc944>] (device_resume) from [<c02ccb4c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:eea8cc10 r6:c06da290 r5:c0714044 r4:eea8cc78
[<c02cca78>] (dpm_resume) from [<c02ccc8c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f16ec r8:c0612c54 r7:00000000 r6:00000003 r5:c06f16ec
  r4:00000010
[<c02ccc78>] (dpm_resume_end) from [<c005abcc>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f16ec r4:00000000
[<c005a99c>] (suspend_devices_and_enter) from [<c005ae3c>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f16f4 r8:c0612c54 r7:edb7dec0 r6:00000003 r5:c0714048 r4:00000000
[<c005ad90>] (pm_suspend) from [<c0059d2c>] (state_store+0xb0/0xc4)
  r7:edb7dec0 r6:00000004 r5:00000003 r4:00000003
[<c0059c7c>] (state_store) from [<c020d028>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:eeacdf80 r7:ed0c5c8c r6:ed0c5c80 r5:edb7dec0 r4:00000004
[<c020d00c>] (kobj_attr_store) from [<c011fe9c>] (sysfs_kf_write+0x40/0x4c)
[<c011fe5c>] (sysfs_kf_write) from [<c011f150>] 
(kernfs_fop_write+0x120/0x180)
[<c011f030>] (kernfs_fop_write) from [<c00c8f48>] (__vfs_write+0x34/0xdc)
  r9:eeacc000 r8:c000fd44 r7:00000004 r6:eeacdf80 r5:c011f030 r4:eeb98f40
[<c00c8f14>] (__vfs_write) from [<c00c916c>] (vfs_write+0xb4/0x13c)
  r7:eeacdf80 r6:000be408 r5:eeb98f40 r4:00000004
[<c00c90b8>] (vfs_write) from [<c00c92d4>] (SyS_write+0x50/0x90)
  r9:eeacc000 r8:c000fd44 r7:00000004 r6:000be408 r5:eeb98f40 r4:eeb98f40
[<c00c9284>] (SyS_write) from [<c000fba0>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6f8ab58 r5:000be408 r4:00000004
---[ end trace c66b1a4c7ffc9b89 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2154 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 22 wake disable
CPU: 0 PID: 2154 Comm: bash Tainted: G        W       4.1.0-rc2 #1
Hardware name: Generic R8A7790 (Flattened Device Tree)
Backtrace:
[<c0012f50>] (dump_backtrace) from [<c00130f8>] (show_stack+0x18/0x1c)
  r7:c06166af r6:ede2aa40 r5:00000009 r4:00000000
[<c00130e0>] (show_stack) from [<c04ff57c>] (dump_stack+0x78/0x94)
[<c04ff504>] (dump_stack) from [<c0027248>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:eeacdc98
[<c00271c0>] (warn_slowpath_common) from [<c00272e0>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:00000016 r5:ee895640 r4:00000000
[<c00272ac>] (warn_slowpath_fmt) from [<c005fba0>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:00000016 r2:c06167c9
[<c005fb04>] (irq_set_irq_wake) from [<c0235d04>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:000000b0 r5:00000000 r4:ee2d3230
[<c0235ce8>] (gpio_rcar_irq_set_wake) from [<c005eba0>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee3e7a00 r4:00000000
[<c005eb68>] (set_irq_wake_real) from [<c005fbbc>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee3e7a00 r4:00000001
[<c005fb04>] (irq_set_irq_wake) from [<c036cf0c>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000001 r5:ee212e10 r4:ee212e7c
[<c036ceac>] (gpio_keys_resume) from [<c02c3b14>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:eea8cc44 r5:eea8cc10 r4:c02c3acc
[<c02c3acc>] (platform_pm_resume) from [<c02cc26c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cc248>] (dpm_run_callback.isra.10) from [<c02cca50>] 
(device_resume+0x10c/0x134)
  r5:eea8cc10 r4:00000001
[<c02cc944>] (device_resume) from [<c02ccb4c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:eea8cc10 r6:c06da290 r5:c0714044 r4:eea8cc78
[<c02cca78>] (dpm_resume) from [<c02ccc8c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f16ec r8:c0612c54 r7:00000000 r6:00000003 r5:c06f16ec
  r4:00000010
[<c02ccc78>] (dpm_resume_end) from [<c005abcc>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f16ec r4:00000000
[<c005a99c>] (suspend_devices_and_enter) from [<c005ae3c>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f16f4 r8:c0612c54 r7:edb7dec0 r6:00000003 r5:c0714048 r4:00000000
[<c005ad90>] (pm_suspend) from [<c0059d2c>] (state_store+0xb0/0xc4)
  r7:edb7dec0 r6:00000004 r5:00000003 r4:00000003
[<c0059c7c>] (state_store) from [<c020d028>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:eeacdf80 r7:ed0c5c8c r6:ed0c5c80 r5:edb7dec0 r4:00000004
[<c020d00c>] (kobj_attr_store) from [<c011fe9c>] (sysfs_kf_write+0x40/0x4c)
[<c011fe5c>] (sysfs_kf_write) from [<c011f150>] 
(kernfs_fop_write+0x120/0x180)
[<c011f030>] (kernfs_fop_write) from [<c00c8f48>] (__vfs_write+0x34/0xdc)
  r9:eeacc000 r8:c000fd44 r7:00000004 r6:eeacdf80 r5:c011f030 r4:eeb98f40
[<c00c8f14>] (__vfs_write) from [<c00c916c>] (vfs_write+0xb4/0x13c)
  r7:eeacdf80 r6:000be408 r5:eeb98f40 r4:00000004
[<c00c90b8>] (vfs_write) from [<c00c92d4>] (SyS_write+0x50/0x90)
  r9:eeacc000 r8:c000fd44 r7:00000004 r6:000be408 r5:eeb98f40 r4:eeb98f40
[<c00c9284>] (SyS_write) from [<c000fba0>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6f8ab58 r5:000be408 r4:00000004
---[ end trace c66b1a4c7ffc9b8a ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2154 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 22 wake disable
CPU: 0 PID: 2154 Comm: bash Tainted: G        W       4.1.0-rc2 #1
Hardware name: Generic R8A7790 (Flattened Device Tree)
Backtrace:
[<c0012f50>] (dump_backtrace) from [<c00130f8>] (show_stack+0x18/0x1c)
  r7:c06166af r6:ede2aa40 r5:00000009 r4:00000000
[<c00130e0>] (show_stack) from [<c04ff57c>] (dump_stack+0x78/0x94)
[<c04ff504>] (dump_stack) from [<c0027248>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:eeacdc98
[<c00271c0>] (warn_slowpath_common) from [<c00272e0>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:00000016 r5:ee895640 r4:00000000
[<c00272ac>] (warn_slowpath_fmt) from [<c005fba0>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:00000016 r2:c06167c9
[<c005fb04>] (irq_set_irq_wake) from [<c0235d04>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:000000b2 r5:00000000 r4:ee2d3230
[<c0235ce8>] (gpio_rcar_irq_set_wake) from [<c005eba0>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee3e7880 r4:00000000
[<c005eb68>] (set_irq_wake_real) from [<c005fbbc>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee3e7880 r4:00000001
[<c005fb04>] (irq_set_irq_wake) from [<c036cf0c>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000002 r5:ee212e10 r4:ee212ee8
[<c036ceac>] (gpio_keys_resume) from [<c02c3b14>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:eea8cc44 r5:eea8cc10 r4:c02c3acc
[<c02c3acc>] (platform_pm_resume) from [<c02cc26c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cc248>] (dpm_run_callback.isra.10) from [<c02cca50>] 
(device_resume+0x10c/0x134)
  r5:eea8cc10 r4:00000001
[<c02cc944>] (device_resume) from [<c02ccb4c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:eea8cc10 r6:c06da290 r5:c0714044 r4:eea8cc78
[<c02cca78>] (dpm_resume) from [<c02ccc8c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f16ec r8:c0612c54 r7:00000000 r6:00000003 r5:c06f16ec
  r4:00000010
[<c02ccc78>] (dpm_resume_end) from [<c005abcc>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f16ec r4:00000000
[<c005a99c>] (suspend_devices_and_enter) from [<c005ae3c>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f16f4 r8:c0612c54 r7:edb7dec0 r6:00000003 r5:c0714048 r4:00000000
[<c005ad90>] (pm_suspend) from [<c0059d2c>] (state_store+0xb0/0xc4)
  r7:edb7dec0 r6:00000004 r5:00000003 r4:00000003
[<c0059c7c>] (state_store) from [<c020d028>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:eeacdf80 r7:ed0c5c8c r6:ed0c5c80 r5:edb7dec0 r4:00000004
[<c020d00c>] (kobj_attr_store) from [<c011fe9c>] (sysfs_kf_write+0x40/0x4c)
[<c011fe5c>] (sysfs_kf_write) from [<c011f150>] 
(kernfs_fop_write+0x120/0x180)
[<c011f030>] (kernfs_fop_write) from [<c00c8f48>] (__vfs_write+0x34/0xdc)
  r9:eeacc000 r8:c000fd44 r7:00000004 r6:eeacdf80 r5:c011f030 r4:eeb98f40
[<c00c8f14>] (__vfs_write) from [<c00c916c>] (vfs_write+0xb4/0x13c)
  r7:eeacdf80 r6:000be408 r5:eeb98f40 r4:00000004
[<c00c90b8>] (vfs_write) from [<c00c92d4>] (SyS_write+0x50/0x90)
  r9:eeacc000 r8:c000fd44 r7:00000004 r6:000be408 r5:eeb98f40 r4:eeb98f40
[<c00c9284>] (SyS_write) from [<c000fba0>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6f8ab58 r5:000be408 r4:00000004
---[ end trace c66b1a4c7ffc9b8b ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2154 at kernel/irq/manage.c:572 
irq_set_irq_wake+0x9c/0xf8()
Unbalanced IRQ 22 wake disable
CPU: 0 PID: 2154 Comm: bash Tainted: G        W       4.1.0-rc2 #1
Hardware name: Generic R8A7790 (Flattened Device Tree)
Backtrace:
[<c0012f50>] (dump_backtrace) from [<c00130f8>] (show_stack+0x18/0x1c)
  r7:c06166af r6:ede2aa40 r5:00000009 r4:00000000
[<c00130e0>] (show_stack) from [<c04ff57c>] (dump_stack+0x78/0x94)
[<c04ff504>] (dump_stack) from [<c0027248>] (warn_slowpath_common+0x88/0xb4)
  r5:00000009 r4:eeacdc98
[<c00271c0>] (warn_slowpath_common) from [<c00272e0>] 
(warn_slowpath_fmt+0x38/0x40)
  r9:00000000 r8:00000000 r7:00000010 r6:00000016 r5:ee895640 r4:00000000
[<c00272ac>] (warn_slowpath_fmt) from [<c005fba0>] 
(irq_set_irq_wake+0x9c/0xf8)
  r3:00000016 r2:c06167c9
[<c005fb04>] (irq_set_irq_wake) from [<c0235d04>] 
(gpio_rcar_irq_set_wake+0x1c/0x44)
  r7:00000010 r6:000000b4 r5:00000000 r4:ee2d3230
[<c0235ce8>] (gpio_rcar_irq_set_wake) from [<c005eba0>] 
(set_irq_wake_real+0x38/0x4c)
  r5:ee3e7700 r4:00000000
[<c005eb68>] (set_irq_wake_real) from [<c005fbbc>] 
(irq_set_irq_wake+0xb8/0xf8)
  r5:ee3e7700 r4:00000001
[<c005fb04>] (irq_set_irq_wake) from [<c036cf0c>] 
(gpio_keys_resume+0x60/0xb8)
  r7:00000010 r6:00000003 r5:ee212e10 r4:ee212f54
[<c036ceac>] (gpio_keys_resume) from [<c02c3b14>] 
(platform_pm_resume+0x48/0x54)
  r7:00000010 r6:eea8cc44 r5:eea8cc10 r4:c02c3acc
[<c02c3acc>] (platform_pm_resume) from [<c02cc26c>] 
(dpm_run_callback.isra.10+0x24/0x50)
[<c02cc248>] (dpm_run_callback.isra.10) from [<c02cca50>] 
(device_resume+0x10c/0x134)
  r5:eea8cc10 r4:00000001
[<c02cc944>] (device_resume) from [<c02ccb4c>] (dpm_resume+0xd4/0x200)
  r9:00000000 r8:00000010 r7:eea8cc10 r6:c06da290 r5:c0714044 r4:eea8cc78
[<c02cca78>] (dpm_resume) from [<c02ccc8c>] (dpm_resume_end+0x14/0x20)
  r10:00000000 r9:c06f16ec r8:c0612c54 r7:00000000 r6:00000003 r5:c06f16ec
  r4:00000010
[<c02ccc78>] (dpm_resume_end) from [<c005abcc>] 
(suspend_devices_and_enter+0x230/0x3f4)
  r5:c06f16ec r4:00000000
[<c005a99c>] (suspend_devices_and_enter) from [<c005ae3c>] 
(pm_suspend+0xac/0x1c0)
  r9:c06f16f4 r8:c0612c54 r7:edb7dec0 r6:00000003 r5:c0714048 r4:00000000
[<c005ad90>] (pm_suspend) from [<c0059d2c>] (state_store+0xb0/0xc4)
  r7:edb7dec0 r6:00000004 r5:00000003 r4:00000003
[<c0059c7c>] (state_store) from [<c020d028>] (kobj_attr_store+0x1c/0x28)
  r9:000be408 r8:eeacdf80 r7:ed0c5c8c r6:ed0c5c80 r5:edb7dec0 r4:00000004
[<c020d00c>] (kobj_attr_store) from [<c011fe9c>] (sysfs_kf_write+0x40/0x4c)
[<c011fe5c>] (sysfs_kf_write) from [<c011f150>] 
(kernfs_fop_write+0x120/0x180)
[<c011f030>] (kernfs_fop_write) from [<c00c8f48>] (__vfs_write+0x34/0xdc)
  r9:eeacc000 r8:c000fd44 r7:00000004 r6:eeacdf80 r5:c011f030 r4:eeb98f40
[<c00c8f14>] (__vfs_write) from [<c00c916c>] (vfs_write+0xb4/0x13c)
  r7:eeacdf80 r6:000be408 r5:eeb98f40 r4:00000004
[<c00c90b8>] (vfs_write) from [<c00c92d4>] (SyS_write+0x50/0x90)
  r9:eeacc000 r8:c000fd44 r7:00000004 r6:000be408 r5:eeb98f40 r4:eeb98f40
[<c00c9284>] (SyS_write) from [<c000fba0>] (ret_fast_syscall+0x0/0x34)
  r7:00000004 r6:b6f8ab58 r5:000be408 r4:00000004
---[ end trace c66b1a4c7ffc9b8c ]---
PM: resume of devices complete after 270.959 msecs
ata1: link resume succeeded after 1 retries
ata1: SATA link down (SStatus 0 SControl 300)
Restarting tasks ...

done.
root@linaro-nano:~#
root@linaro-nano:~#
root@linaro-nano:~#
root@linaro-nano:~#
root@linaro-nano:~#
root@linaro-nano:~#


