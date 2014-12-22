From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Dec 2014 11:23:58 +0000
Subject: sh_cmt: possible circular locking dependency detected
Message-Id: <CAMuHMdUmstuuf7f6ppm+QP-ik3Bi4CUJQ195t2Lag7_2CAKoWQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

With CONFIG_PROVE_LOCKING=y, I get the following on both armadillo and
kzm9g:

Freeing unused kernel memory: 160K (c0504000 - c052c000)
sh-eth e9a00000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
systemd-udevd[133]: starting version 215
random: udevd urandom read with 73 bits of entropy available
random: nonblocking pool is initialized

===========================
[ INFO: possible circular locking dependency detected ]
3.19.0-rc1-armadillo-multiplatform-00258-g85f5ee22d89dad78 #401 Not tainted
-------------------------------------------------------
ntpdate/797 is trying to acquire lock:
 (tk_core){----..}, at: [<c0058138>] __hrtimer_start_range_ns+0x64/0xf4

but task is already holding lock:
 (hrtimer_bases.lock){-.-...}, at: [<c00580fc>]
__hrtimer_start_range_ns+0x28/0xf4

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (hrtimer_bases.lock){-.-...}:
       [<c03ae088>] _raw_spin_lock_irqsave+0x44/0x58
       [<c00580fc>] __hrtimer_start_range_ns+0x28/0xf4
       [<c003ab60>] start_bandwidth_timer+0x5c/0x68
       [<c003fa70>] enqueue_task_rt+0x114/0x148
       [<c003ac04>] enqueue_task+0x34/0x38
       [<c003ae6c>] activate_task+0x30/0x34
       [<c003afa4>] try_to_wake_up+0x5c/0x168
       [<c003b0e8>] wake_up_process+0x38/0x40
       [<c0050c0c>] __setup_irq+0x3d0/0x4c0
       [<c0050e54>] request_threaded_irq+0xd0/0x11c
       [<c0052b08>] devm_request_threaded_irq+0x5c/0x94
       [<c026319c>] st1232_ts_probe+0x1a8/0x220
       [<c0267020>] i2c_device_probe+0xf8/0x120
       [<c02021a8>] driver_probe_device+0xc0/0x208
       [<c02023b4>] __driver_attach+0x78/0x9c
       [<c0200820>] bus_for_each_dev+0x74/0x98
       [<c0201cf0>] driver_attach+0x20/0x28
       [<c0201980>] bus_add_driver+0xe8/0x1d0
       [<c0202a44>] driver_register+0xa4/0xe8
       [<c02687c4>] i2c_register_driver+0x48/0xb8
       [<c0518f08>] st1232_ts_driver_init+0x18/0x20
       [<c000890c>] do_one_initcall+0x108/0x1bc
       [<c0504d70>] kernel_init_freeable+0xfc/0x1c0
       [<c03a72a0>] kernel_init+0x10/0xec
       [<c000df68>] ret_from_fork+0x14/0x2c

-> #5 (&rt_b->rt_runtime_lock){-.....}:
       [<c03adf5c>] _raw_spin_lock+0x34/0x44
       [<c003fa64>] enqueue_task_rt+0x108/0x148
       [<c003ac04>] enqueue_task+0x34/0x38
       [<c003ae6c>] activate_task+0x30/0x34
       [<c003afa4>] try_to_wake_up+0x5c/0x168
       [<c003b0e8>] wake_up_process+0x38/0x40
       [<c0050c0c>] __setup_irq+0x3d0/0x4c0
       [<c0050e54>] request_threaded_irq+0xd0/0x11c
       [<c0052b08>] devm_request_threaded_irq+0x5c/0x94
       [<c026319c>] st1232_ts_probe+0x1a8/0x220
       [<c0267020>] i2c_device_probe+0xf8/0x120
       [<c02021a8>] driver_probe_device+0xc0/0x208
       [<c02023b4>] __driver_attach+0x78/0x9c
       [<c0200820>] bus_for_each_dev+0x74/0x98
       [<c0201cf0>] driver_attach+0x20/0x28
       [<c0201980>] bus_add_driver+0xe8/0x1d0
       [<c0202a44>] driver_register+0xa4/0xe8
       [<c02687c4>] i2c_register_driver+0x48/0xb8
       [<c0518f08>] st1232_ts_driver_init+0x18/0x20
       [<c000890c>] do_one_initcall+0x108/0x1bc
       [<c0504d70>] kernel_init_freeable+0xfc/0x1c0
       [<c03a72a0>] kernel_init+0x10/0xec
       [<c000df68>] ret_from_fork+0x14/0x2c

-> #4 (&rq->lock){-.-.-.}:
       [<c03adf5c>] _raw_spin_lock+0x34/0x44
       [<c003b528>] wake_up_new_task+0x50/0xcc
       [<c001ed28>] do_fork+0x160/0x3b8
       [<c001efb4>] kernel_thread+0x34/0x3c
       [<c03a71e0>] rest_init+0x24/0xd4
       [<c0504c1c>] start_kernel+0x2e0/0x338
       [<40008070>] 0x40008070

-> #3 (&p->pi_lock){-.-...}:
       [<c03ae088>] _raw_spin_lock_irqsave+0x44/0x58
       [<c003af6c>] try_to_wake_up+0x24/0x168
       [<c003b0e8>] wake_up_process+0x38/0x40
       [<c0031f64>] create_worker+0x118/0x16c
       [<c050b698>] init_workqueues+0xc4/0x310
       [<c000890c>] do_one_initcall+0x108/0x1bc
       [<c0504cd4>] kernel_init_freeable+0x60/0x1c0
       [<c03a72a0>] kernel_init+0x10/0xec
       [<c000df68>] ret_from_fork+0x14/0x2c

-> #2 (&(&pool->lock)->rlock){..-...}:
       [<c03adf5c>] _raw_spin_lock+0x34/0x44
       [<c0030860>] __queue_work+0x168/0x22c
       [<c0030980>] queue_work_on+0x5c/0x80
       [<c0209c0c>] rpm_idle+0xac/0x124
       [<c0209cbc>] __pm_runtime_idle+0x38/0x7c
       [<c02b85e8>] sh_cmt_stop+0x9c/0xcc
       [<c02b864c>] sh_cmt_clock_event_mode+0x34/0xb4
       [<c0062e34>] clockevents_set_mode+0x30/0x64
       [<c00631b4>] clockevents_exchange_device+0x3c/0xb0
       [<c00637cc>] tick_check_new_device+0x6c/0x7c
       [<c0062da8>] clockevents_register_device+0x68/0xc4
       [<c00630b4>] clockevents_config_and_register+0x24/0x28
       [<c02b93d8>] sh_tmu_probe+0x25c/0x528
       [<c02039d0>] platform_drv_probe+0x50/0xa0
       [<c02021a8>] driver_probe_device+0xc0/0x208
       [<c02023b4>] __driver_attach+0x78/0x9c
       [<c0200820>] bus_for_each_dev+0x74/0x98
       [<c0201cf0>] driver_attach+0x20/0x28
       [<c0201980>] bus_add_driver+0xe8/0x1d0
       [<c0202a44>] driver_register+0xa4/0xe8
       [<c0203904>] __platform_driver_register+0x50/0x64
       [<c0519f0c>] sh_tmu_init+0x18/0x20
       [<c000890c>] do_one_initcall+0x108/0x1bc
       [<c0504d70>] kernel_init_freeable+0xfc/0x1c0
       [<c03a72a0>] kernel_init+0x10/0xec
       [<c000df68>] ret_from_fork+0x14/0x2c

-> #1 (&(&dev->power.lock)->rlock){..-...}:
       [<c03ae088>] _raw_spin_lock_irqsave+0x44/0x58
       [<c020a140>] __pm_runtime_resume+0x44/0x6c
       [<c02b97f8>] sh_tmu_enable.part.3+0x24/0x44
       [<c02b994c>] sh_tmu_clocksource_enable+0x48/0x74
       [<c005da94>] timekeeping_notify+0xbc/0x140
       [<c005fc8c>] __clocksource_select+0xcc/0xf8
       [<c050d594>] clocksource_done_booting+0x38/0x50
       [<c000890c>] do_one_initcall+0x108/0x1bc
       [<c0504d70>] kernel_init_freeable+0xfc/0x1c0
       [<c03a72a0>] kernel_init+0x10/0xec
       [<c000df68>] ret_from_fork+0x14/0x2c

-> #0 (tk_core){----..}:
       [<c0046b5c>] lock_acquire+0x74/0x94
       [<c005c85c>] ktime_get+0x68/0x154
       [<c0058138>] __hrtimer_start_range_ns+0x64/0xf4
       [<c0058228>] hrtimer_start+0x2c/0x34
       [<c0058bc0>] do_setitimer+0x190/0x1a4
       [<c0058d10>] SyS_setitimer+0xc4/0x128
       [<c000dea0>] ret_fast_syscall+0x0/0x48

other info that might help us debug this:

Chain exists of:
  tk_core --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hrtimer_bases.lock);
                               lock(&rt_b->rt_runtime_lock);
                               lock(hrtimer_bases.lock);
  lock(tk_core);

 *** DEADLOCK ***

2 locks held by ntpdate/797:
 #0:  (&(&sighand->siglock)->rlock){......}, at: [<c0058abc>]
do_setitimer+0x8c/0x1a4
 #1:  (hrtimer_bases.lock){-.-...}, at: [<c00580fc>]
__hrtimer_start_range_ns+0x28/0xf4

stack backtrace:
CPU: 0 PID: 797 Comm: ntpdate Not tainted
3.19.0-rc1-armadillo-multiplatform-00258-g85f5ee22d89dad78 #401
Hardware name: Generic R8A7740 (Flattened Device Tree)
Backtrace:
[<c001130c>] (dump_backtrace) from [<c001152c>] (show_stack+0x18/0x1c)
 r6:c06a1b0c r5:c069006c r4:c06905bc r3:00400100
[<c0011514>] (show_stack) from [<c03a936c>] (dump_stack+0x20/0x28)
[<c03a934c>] (dump_stack) from [<c03a870c>] (print_circular_bug+0x264/0x2b8)
[<c03a84a8>] (print_circular_bug) from [<c0045d00>]
(__lock_acquire+0x12d8/0x1a28)
 r10:00000002 r9:c068ec3c r8:00000002 r7:00000002 r6:df6c59d0 r5:df6c59e8
 r4:df6c55c0 r3:df6c59d0
[<c0044a28>] (__lock_acquire) from [<c0046b5c>] (lock_acquire+0x74/0x94)
 r10:00000000 r9:c0d31dc0 r8:c0058138 r7:00000001 r6:00000001 r5:60070093
 r4:00000000
[<c0046ae8>] (lock_acquire) from [<c005c85c>] (ktime_get+0x68/0x154)
 r6:60070093 r5:df76fee8 r4:c0d31dc0
[<c005c7f4>] (ktime_get) from [<c0058138>] (__hrtimer_start_range_ns+0x64/0xf4)
 r10:00000000 r9:20070093 r8:00000000 r7:00000000 r6:05f5e100 r5:c0540698
 r4:df722178
[<c00580d4>] (__hrtimer_start_range_ns) from [<c0058228>]
(hrtimer_start+0x2c/0x34)
 r9:df76e000 r8:00000000 r7:df722178 r6:df6c55c0 r5:00000000 r4:df76ff70
[<c00581fc>] (hrtimer_start) from [<c0058bc0>] (do_setitimer+0x190/0x1a4)
[<c0058a30>] (do_setitimer) from [<c0058d10>] (SyS_setitimer+0xc4/0x128)
 r8:c000e064 r7:00000068 r6:00000f7c r5:00000000 r4:00000000
[<c0058c4c>] (SyS_setitimer) from [<c000dea0>] (ret_fast_syscall+0x0/0x48)
 r5:0002e1dc r4:00000000

===============

sh_cmt e6138000.timer: ch0: used for clock events
sh_cmt e6138000.timer: ch1: used as clock source
Advanced Linux Sound Architecture Driver Initialized.
NET: Registered protocol family 23
Switched to clocksource e6138000.timer

===========================
[ INFO: possible circular locking dependency detected ]
3.19.0-rc1-kzm9g-multiplatform-00258-g85f5ee22d89dad78 #285 Not tainted
-------------------------------------------------------
swapper/0/1 is trying to acquire lock:
 (&ch->lock){-.-...}, at: [<c02c4248>] sh_cmt_clocksource_read+0x24/0x6c

but task is already holding lock:
 (hrtimer_bases.lock){-.-...}, at: [<c0077c10>]
lock_hrtimer_base.isra.24+0x28/0x50

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (hrtimer_bases.lock){-.-...}:
       [<c03dde58>] _raw_spin_lock_irqsave+0x44/0x58
       [<c0077c10>] lock_hrtimer_base.isra.24+0x28/0x50
       [<c0077e40>] __hrtimer_start_range_ns+0x2c/0x360
       [<c0047e94>] start_bandwidth_timer+0x68/0x74
       [<c00572c0>] enqueue_task_rt+0x198/0x1f4
       [<c0047f2c>] enqueue_task+0x34/0x38
       [<c00483d4>] activate_task+0x30/0x34
       [<c0048678>] ttwu_do_activate.constprop.71+0x30/0x64
       [<c004c30c>] try_to_wake_up+0x270/0x2bc
       [<c004c390>] wake_up_process+0x38/0x40
       [<c006c400>] __setup_irq+0x3c4/0x4bc
       [<c006c650>] request_threaded_irq+0xd0/0x11c
       [<c006e3e0>] devm_request_threaded_irq+0x5c/0x94
       [<c01f42e8>] pcf857x_probe+0x14c/0x348
       [<c029f4d8>] i2c_device_probe+0xf8/0x120
       [<c0237ad8>] driver_probe_device+0xc0/0x208
       [<c0237c50>] __device_attach+0x30/0x4c
       [<c0236224>] bus_for_each_drv+0x8c/0x9c
       [<c02379cc>] device_attach+0x70/0x94
       [<c023705c>] bus_probe_device+0x30/0xa4
       [<c02354ec>] device_add+0x3c8/0x4d8
       [<c0235618>] device_register+0x1c/0x20
       [<c02a0ce4>] i2c_new_device+0x124/0x198
       [<c02a120c>] i2c_register_adapter+0x304/0x424
       [<c02a1434>] i2c_add_adapter+0x90/0xa8
       [<c02a1468>] i2c_add_numbered_adapter+0x1c/0x28
       [<c02a2ac0>] sh_mobile_i2c_probe+0x3c0/0x454
       [<c0239300>] platform_drv_probe+0x50/0xa0
       [<c0237ad8>] driver_probe_device+0xc0/0x208
       [<c0237ce4>] __driver_attach+0x78/0x9c
       [<c0236150>] bus_for_each_dev+0x74/0x98
       [<c0237620>] driver_attach+0x20/0x28
       [<c02372b0>] bus_add_driver+0xe8/0x1d0
       [<c0238374>] driver_register+0xa4/0xe8
       [<c0239234>] __platform_driver_register+0x50/0x64
       [<c05413f0>] sh_mobile_i2c_adap_init+0x18/0x20
       [<c00097d8>] do_one_initcall+0x108/0x1bc
       [<c052adb4>] kernel_init_freeable+0x11c/0x1e4
       [<c03d602c>] kernel_init+0x10/0xec
       [<c000ee88>] ret_from_fork+0x14/0x2c

-> #5 (&rt_b->rt_runtime_lock){......}:
       [<c03ddd2c>] _raw_spin_lock+0x34/0x44
       [<c00557fc>] rq_online_rt+0x84/0xdc
       [<c00478a4>] set_rq_online.part.55+0x48/0x58
       [<c004c630>] migration_call+0xb8/0x2a8
       [<c0044018>] notifier_call_chain+0x88/0xb4
       [<c0044060>] __raw_notifier_call_chain+0x1c/0x24
       [<c0027260>] __cpu_notify+0x34/0x50
       [<c0027294>] cpu_notify+0x18/0x1c
       [<c002771c>] _cpu_up+0x108/0x144
       [<c00277c4>] cpu_up+0x6c/0x88
       [<c053577c>] smp_init+0xa0/0xb4
       [<c052ad1c>] kernel_init_freeable+0x84/0x1e4
       [<c03d602c>] kernel_init+0x10/0xec
       [<c000ee88>] ret_from_fork+0x14/0x2c

-> #4 (&rq->lock){-.-...}:
       [<c03ddd2c>] _raw_spin_lock+0x34/0x44
       [<c004c4bc>] wake_up_new_task+0xf4/0x1b0
       [<c0026198>] do_fork+0x160/0x568
       [<c00265d4>] kernel_thread+0x34/0x3c
       [<c03d5ee0>] rest_init+0x24/0x160
       [<c052ac40>] start_kernel+0x304/0x35c
       [<40008074>] 0x40008074

-> #3 (&p->pi_lock){-.-...}:
       [<c03dde58>] _raw_spin_lock_irqsave+0x44/0x58
       [<c004c0c8>] try_to_wake_up+0x2c/0x2bc
       [<c004c390>] wake_up_process+0x38/0x40
       [<c003cb24>] create_worker+0x118/0x16c
       [<c05322b8>] init_workqueues+0x18c/0x3d8
       [<c00097d8>] do_one_initcall+0x108/0x1bc
       [<c052ad14>] kernel_init_freeable+0x7c/0x1e4
       [<c03d602c>] kernel_init+0x10/0xec
       [<c000ee88>] ret_from_fork+0x14/0x2c

-> #2 (&(&pool->lock)->rlock){......}:
       [<c03ddd2c>] _raw_spin_lock+0x34/0x44
       [<c003ceb8>] __queue_work+0x190/0x258
       [<c003cfd0>] queue_work_on+0x50/0x74
       [<c023fd4c>] rpm_idle+0xb0/0x128
       [<c023fdfc>] __pm_runtime_idle+0x38/0x84
       [<c0237bf0>] driver_probe_device+0x1d8/0x208
       [<c0237ce4>] __driver_attach+0x78/0x9c
       [<c0236150>] bus_for_each_dev+0x74/0x98
       [<c0237620>] driver_attach+0x20/0x28
       [<c02372b0>] bus_add_driver+0xe8/0x1d0
       [<c0238374>] driver_register+0xa4/0xe8
       [<c0239234>] __platform_driver_register+0x50/0x64
       [<c0541b9c>] sh_cmt_init+0x18/0x20
       [<c00097d8>] do_one_initcall+0x108/0x1bc
       [<c052adb4>] kernel_init_freeable+0x11c/0x1e4
       [<c03d602c>] kernel_init+0x10/0xec
       [<c000ee88>] ret_from_fork+0x14/0x2c

-> #1 (&(&dev->power.lock)->rlock){......}:
       [<c03dde58>] _raw_spin_lock_irqsave+0x44/0x58
       [<c0240284>] __pm_runtime_resume+0x44/0x6c
       [<c02c4534>] sh_cmt_start+0x44/0x220
       [<c02c50e0>] sh_cmt_clocksource_enable+0x40/0x6c
       [<c007ddc8>] change_clocksource+0xa4/0x108
       [<c0092370>] multi_cpu_stop+0xbc/0x134
       [<c00925fc>] cpu_stopper_thread+0x78/0x104
       [<c00468ac>] smpboot_thread_fn+0x16c/0x184
       [<c004306c>] kthread+0xe0/0xf4
       [<c000ee88>] ret_from_fork+0x14/0x2c

-> #0 (&ch->lock){-.-...}:
       [<c0061538>] lock_acquire+0x74/0x94
       [<c03dde58>] _raw_spin_lock_irqsave+0x44/0x58
       [<c02c4248>] sh_cmt_clocksource_read+0x24/0x6c
       [<c007d33c>] ktime_get+0xbc/0x15c
       [<c0084330>] clockevents_program_event+0x98/0x130
       [<c0086420>] tick_program_event+0x3c/0x48
       [<c00780e0>] __hrtimer_start_range_ns+0x2cc/0x360
       [<c00781a0>] hrtimer_start_range_ns+0x2c/0x34
       [<c0087550>] tick_setup_sched_timer+0x11c/0x174
       [<c0078960>] hrtimer_run_pending+0xd8/0x110
       [<c00770a0>] run_timer_softirq+0x24/0x1f8
       [<c002a98c>] __do_softirq+0x130/0x29c
       [<c002adec>] irq_exit+0x8c/0x118
       [<c006a580>] __handle_domain_irq+0x98/0xbc
       [<c00093e8>] gic_handle_irq+0x40/0x64
       [<c0013244>] __irq_svc+0x44/0x5c
       [<c0090230>] get_symbol_offset+0x2c/0x50
       [<c009086c>] kallsyms_lookup+0x50/0x88
       [<c00908dc>] __sprint_symbol+0x38/0xcc
       [<c00909d4>] sprint_symbol_no_offset+0x18/0x1c
       [<c01d84f0>] symbol_string.isra.12+0x54/0x80
       [<c01d98dc>] pointer.isra.19+0x158/0x458
       [<c01d9638>] vsnprintf+0x214/0x360
       [<c01db598>] kvasprintf+0x64/0x70
       [<c01db5c8>] kasprintf+0x24/0x2c
       [<c0009704>] do_one_initcall+0x34/0x1bc
       [<c052adb4>] kernel_init_freeable+0x11c/0x1e4
       [<c03d602c>] kernel_init+0x10/0xec
       [<c000ee88>] ret_from_fork+0x14/0x2c

other info that might help us debug this:

Chain exists of:
  &ch->lock --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hrtimer_bases.lock);
                               lock(&rt_b->rt_runtime_lock);
                               lock(hrtimer_bases.lock);
  lock(&ch->lock);

 *** DEADLOCK ***

1 lock held by swapper/0/1:
 #0:  (hrtimer_bases.lock){-.-...}, at: [<c0077c10>]
lock_hrtimer_base.isra.24+0x28/0x50

stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted
3.19.0-rc1-kzm9g-multiplatform-00258-g85f5ee22d89dad78 #285
Hardware name: Generic SH73A0 (Flattened Device Tree)
Backtrace:
[<c00124e4>] (dump_backtrace) from [<c0012704>] (show_stack+0x18/0x1c)
 r6:c06ca810 r5:c06d1f10 r4:00000000 r3:00200040
[<c00126ec>] (show_stack) from [<c03d87ec>] (dump_stack+0x78/0x94)
[<c03d8774>] (dump_stack) from [<c005d72c>] (print_circular_bug+0x278/0x2cc)
 r4:c06c60e0 r3:00000002
[<c005d4b4>] (print_circular_bug) from [<c006067c>]
(__lock_acquire+0x134c/0x1ac4)
 r10:00000001 r9:c06c3aa0 r8:00000001 r7:00000001 r6:df445820 r5:df445838
 r4:df4453c0 r3:df445820
[<c005f330>] (__lock_acquire) from [<c0061538>] (lock_acquire+0x74/0x94)
 r10:0000001e r9:c0d66c80 r8:c0084330 r7:00000001 r6:00000001 r5:60000193
 r4:00000000
[<c00614c4>] (lock_acquire) from [<c03dde58>] (_raw_spin_lock_irqsave+0x44/0x58)
 r6:c02c4248 r5:60000193 r4:df4281ec
[<c03dde14>] (_raw_spin_lock_irqsave) from [<c02c4248>]
(sh_cmt_clocksource_read+0x24/0x6c)
 r6:df4281ec r5:df4281c0 r4:df4282c0
[<c02c4224>] (sh_cmt_clocksource_read) from [<c007d33c>] (ktime_get+0xbc/0x15c)
 r8:c0084330 r7:00000001 r6:60000193 r5:df447a00 r4:c0d66c80
[<c007d280>] (ktime_get) from [<c0084330>]
(clockevents_program_event+0x98/0x130)
 r10:00000000 r9:00000000 r8:08583b00 r7:00000000 r6:08583b00 r5:00000000
 r4:dfbce5c0
[<c0084298>] (clockevents_program_event) from [<c0086420>]
(tick_program_event+0x3c/0x48)
 r7:00000000 r6:dfbca3e8 r5:00000000 r4:08583b00
[<c00863e4>] (tick_program_event) from [<c00780e0>]
(__hrtimer_start_range_ns+0x2cc/0x360)
 r5:dfbca440 r4:dfbca758
[<c0077e14>] (__hrtimer_start_range_ns) from [<c00781a0>]
(hrtimer_start_range_ns+0x2c/0x34)
 r10:c0596ec0 r9:df447b60 r8:c0d670c0 r7:00000000 r6:07ce8b32 r5:dfbca758
 r4:00000002
[<c0078174>] (hrtimer_start_range_ns) from [<c0087550>]
(tick_setup_sched_timer+0x11c/0x174)
[<c0087434>] (tick_setup_sched_timer) from [<c0078960>]
(hrtimer_run_pending+0xd8/0x110)
 r8:00000000 r7:00000000 r6:00000000 r5:60000113 r4:dfbca508
[<c0078888>] (hrtimer_run_pending) from [<c00770a0>]
(run_timer_softirq+0x24/0x1f8)
 r8:c0560084 r7:00000100 r6:00000282 r5:c0560100 r4:c0d65140 r3:c055a3e0
[<c007707c>] (run_timer_softirq) from [<c002a98c>] (__do_softirq+0x130/0x29c)
 r10:c0596ec0 r9:df447b60 r8:c0560084 r7:00000100 r6:00000282 r5:df446000
 r4:40000001
[<c002a85c>] (__do_softirq) from [<c002adec>] (irq_exit+0x8c/0x118)
 r10:00000008 r9:c053e11c r8:df406000 r7:00000010 r6:c055acb8 r5:00000000
 r4:00000000
[<c002ad60>] (irq_exit) from [<c006a580>] (__handle_domain_irq+0x98/0xbc)
 r4:00000000 r3:0000006b
[<c006a4e8>] (__handle_domain_irq) from [<c00093e8>] (gic_handle_irq+0x40/0x64)
 r8:df447cb4 r7:df447c4c r6:df447c18 r5:c05669f4 r4:e0802100 r3:df447c18
[<c00093a8>] (gic_handle_irq) from [<c0013244>] (__irq_svc+0x44/0x5c)
Exception stack(0xdf447c18 to 0xdf447c60)
7c00:                                                       000000f0 0000001e
7c20: c0446680 c04a974a df447cf1 df447cac 00000000 df447cb0 df447cb4 c053e11c
7c40: 00000008 df447c6c 0000000f df447c60 c009086c c0090230 80000113 ffffffff
 r6:ffffffff r5:80000113 r4:c0090230 r3:df4453c0
[<c0090204>] (get_symbol_offset) from [<c009086c>] (kallsyms_lookup+0x50/0x88)
[<c009081c>] (kallsyms_lookup) from [<c00908dc>] (__sprint_symbol+0x38/0xcc)
 r9:00000010 r8:ffffffff r7:00000000 r6:00000000 r5:df447cf1 r4:c053e11c
[<c00908a4>] (__sprint_symbol) from [<c00909d4>]
(sprint_symbol_no_offset+0x18/0x1c)
 r7:df4cb3d0 r6:df4cb3c0 r5:df4cb3d0 r4:00000000
[<c00909bc>] (sprint_symbol_no_offset) from [<c01d84f0>]
(symbol_string.isra.12+0x54/0x80)
[<c01d849c>] (symbol_string.isra.12) from [<c01d98dc>]
(pointer.isra.19+0x158/0x458)
 r6:00000000 r5:ffffffff r4:df4cb3c0
[<c01d9784>] (pointer.isra.19) from [<c01d9638>] (vsnprintf+0x214/0x360)
 r10:c03fa598 r9:00000010 r8:c04c8b99 r7:df4cb3c0 r6:df4cb3d0 r5:df4cb3c0
 r4:df447ee0
[<c01d9424>] (vsnprintf) from [<c01db598>] (kvasprintf+0x64/0x70)
 r10:00000000 r9:c0596500 r8:000000d0 r7:df4cb3c0 r6:00000010 r5:c04c8b98
 r4:df447ee0
[<c01db534>] (kvasprintf) from [<c01db5c8>] (kasprintf+0x24/0x2c)
 r8:c0596500 r7:c05592f4 r6:00000000 r5:c053e11c r4:00000005
[<c01db5a8>] (kasprintf) from [<c0009704>] (do_one_initcall+0x34/0x1bc)
 r3:df446000 r2:c053e11c r1:c04c8b98
[<c00096d0>] (do_one_initcall) from [<c052adb4>]
(kernel_init_freeable+0x11c/0x1e4)
 r9:c0596500 r8:c0596500 r7:c05592f4 r6:c05507ec r5:00000078 r4:00000005
[<c052ac98>] (kernel_init_freeable) from [<c03d602c>] (kernel_init+0x10/0xec)
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c03d601c r4:00000000
[<c03d601c>] (kernel_init) from [<c000ee88>] (ret_from_fork+0x14/0x2c)
 r4:00000000 r3:00000000
NET: Registered protocol family 2
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP: reno registered
UDP hash table entries: 256 (order: 2, 20480 bytes)
UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
