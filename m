From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 07 Feb 2009 00:41:20 +0000
Subject: oops I get on booting
Message-Id: <1233967281.6893.3.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I am getting this error every so often on boot -as it is not every time
it seems to be a race condition of some sort. With the latest git the
frequency of the problem seems to have increased, but it has been there
for a while.

Anybody have any suggestions as to what it might be? Naturally I'd
suspect my own code, though nothing I've written is in the stack:

[   42.893155] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
[   42.909100] pc = 8c0874ea
[   42.911093] *pde = 00000000
[   42.914126] Oops: 0000 [#1]
[   42.916782] Modules linked in: evdev
[   42.920373] 
[   42.921995] Pid : 781, Comm:                 rc
[   42.925416] CPU : 0                  Not tainted  (2.6.29-rc3-00700-g67baead-dirty #456)
[   42.925446] 
[   42.934591] PC is at pipe_read+0xca/0x3e0
[   42.938717] PR is at pipe_read+0x54/0x3e0
[   42.942839] PC  : 8c0874ea SP  : 8c897e60 SR  : 40008000 TEA : c00155c8
[   42.949666] R0  : 55555555 R1  : 00000000 R2  : 00000000 R3  : 8c84822c
[   42.956493] R4  : 8c848200 R5  : 8c84822c R6  : 00000001 R7  : 55555555
[   42.963321] R8  : 8c7cc000 R9  : 8c897ebc R10 : 8c897efc R11 : fffffdee
[   42.970144] R12 : 8c84822c R13 : 8c07e160 R14 : 8c848200
[   42.975536] MACH: 00000000 MACL: fffffff8 GBR : 296e4440 PR  : 8c087474
[   42.982351] 
[   42.982365] Call trace:
[   42.986524] [<8c07e4bc>] do_sync_read+0x9c/0x100
[   42.991187] [<8c07e160>] wait_on_retry_sync_kiocb+0x0/0xc0
[   42.996950] [<8c031c20>] autoremove_wake_function+0x0/0x40
[   43.002509] [<8c247768>] preempt_schedule+0x28/0x60
[   43.007534] [<8c2470e0>] __sched_text_start+0x0/0x560
[   43.012743] [<8c07ed7e>] vfs_read+0x7e/0x160
[   43.017233] [<8c07f2fa>] sys_read+0x3a/0x80
[   43.021546] [<8c008236>] syscall_call+0xc/0x10
[   43.026035] [<8c07f2c0>] sys_read+0x0/0x80
[   43.030327] 
[   43.031763] Process: rc (pid: 781, stack limit = 8c896001)
[   43.037511] Stack: (0x8c897e60 to 0x8c898000)
[   43.041995] 7e60: 8c84822c 8c7cc06c 8c897f40 55555555 8c54ee80 00000000 00000000 00000080 
[   43.050438] 7e80: 55555555 00000000 00000008 8c3b33a0 8c07e4bc 8c897f40 8c07e160 8c54ee80 
[   43.059061] 7ea0: fffffdee 8c897efc 8c897ebc 00000000 00000000 00000000 8c897f7c 8c898004 
[   43.067504] 7ec0: 8c9d7be0 00000000 00000001 ffffffff 8c54ee80 00000000 00000000 00000000 
[   43.076127] 7ee0: 00000000 8cc1b0c0 00000000 00000000 8c9d7ba0 8cc1b0c0 8c031c20 8c897efc 
[   43.084571] 7f00: 8c897efc 00000000 00000000 8cc1b290 8cc1b28c 8cc1b214 8cc1b13c 00000080 
[   43.093193] 7f20: 8c247768 8c897f40 0000064c 00000000 00000000 00000000 8c2470e0 10000000 
[   43.101637] 7f40: 7b839c94 00000080 8c07ed7e 7b839c64 0000064c fffffff7 8c897f7c 7b839c94 
[   43.110259] 7f60: 00000080 8c54ee80 8c07f2fa 00000080 7b839c94 8c54ee80 8c897f48 00000000 
[   43.118703] 7f80: 00000000 00000000 8c008236 00000000 00000000 00000071 0000007f 8c07f2c0 
[   43.127325] 7fa0: 00000000 00000440 7b839d1c 00000003 00000003 7b839c94 00000080 00000118 
[   43.135769] 7fc0: 00000000 00000080 7b839c94 00000003 00000000 0000064c 7b839c64 7b839c64 
[   43.144391] 7fe0: 29675174 00457bf2 00008001 296e4440 00000000 000003c0 0000004c 00000160 
[   43.161164] ---[ end trace d39f684adbf6ae60 ]---


