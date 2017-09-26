From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 26 Sep 2017 12:29:02 +0000
Subject: Bug report: kernel BUG at arch/sh/kernel/dwarf.c:547!
Message-Id: <20170926142902.36e9539e@windsurf.lan>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

I'm using Linux 4.13 on a big endian SH4A system, and whenever I get
a kernel panic (for example because there is no root filesystem
available), I get "kernel BUG at arch/sh/kernel/dwarf.c:547!". It seems
like the DWARF-reading logic in arch/sh/kernel/dwarf.c doesn't support
some recent DWARF information emitted by gcc. My toolchain uses gcc
6.4.0. Have you already encountered this problem?

You'll find below the full kernel panic log. You'll also notice that
the layout of the kernel panic message is really weird, with many
newlines all over the place, which probably is another bug.

Best regards,

Thomas

List of all partitions:
0100           16384 ram0 
 (driver?)
0101           16384 ram1 
 (driver?)
0102           16384 ram2 
 (driver?)
0103           16384 ram3 
 (driver?)
0104           16384 ram4 
 (driver?)
0105           16384 ram5 
 (driver?)
0106           16384 ram6 
 (driver?)
0107           16384 ram7 
 (driver?)
0108           16384 ram8 
 (driver?)
0109           16384 ram9 
 (driver?)
010a           16384 ram10 
 (driver?)
010b           16384 ram11 
 (driver?)
010c           16384 ram12 
 (driver?)
010d           16384 ram13 
 (driver?)
010e           16384 ram14 
 (driver?)
010f           16384 ram15 
 (driver?)
No filesystem could mount root, tried: 

Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
CPU: 0 PID: 1 Comm: swapper Not tainted 4.13.0 #1
Stack: (0x97c1de98 to 0x97c1e000)
de80: 
         
         
         
         
         
         
882a7eea 
97c1dea8 

dea0: 
00000000 
88002e44 
88015770 
97c1deb0 
88363a6c 
97c1ded8 
884ddfcc 
97c1dee4 

dec0: 
882a6f60 
97e93000 
88363a6c 
882a6f60 
8804306c 
97e93000 
97c1def0 
00000000 

dee0: 
00000000 
97c1def0 
fffff000 
8834fe40 
756e6b6e 
6f776e2d 
626c6f63 
6b28302c 

df00: 
30290070 
9780a800 
880e4dfa 
97c1df28 
884de1b8 
97c1df30 
884f4060 
884f901c 

df20: 
884f9008 
884f4020 
8800214c 
00000000 
884de31e 
97c1df3c 
884f9024 
884f4060 

df40: 
884ddbd8 
97c1df5c 
884f901c 
884f9008 
884f4020 
8800214c 
884f9014 
00000007 

df60: 
00000007 
00000000 
884dd234 
884f7928 
00000062 
882b6380 
97c1df94 
97c1a53c 

df80: 
881806e8 
883a6f50 
00000000 
884f9014 
8804306c 
88007224 
97c2ff30 
883a734c 

dfa0: 
88032f2c 
00000000 
00000000 
00000000 
00000000 
00000000 
882b636c 
00000000 

dfc0: 
00000000 
00000000 
00000000 
00000000 
00000000 
00000000 
00000000 
00000000 

dfe0: 
00000000 
00000000 
00000000 
40008000 
00000000 
00000000 
00000000 
00000000 


Call trace:
------------[ cut here ]------------
kernel BUG at arch/sh/kernel/dwarf.c:547!
Kernel BUG: 003e [#1]
Modules linked in:

CPU: 0 PID: 1 Comm: swapper Not tainted 4.13.0 #1
task: 97c1ac00 task.stack: 97c1c000
PC is at dwarf_cfa_execute_insns.isra.1+0x54/0x430
PR is at dwarf_cfa_execute_insns.isra.1+0xba/0x430
PC  : 8800d16c SP  : 97c1ddcc SR  : 400080f0 
TEA : c0091240
R0  : 8800d208 R1  : 8800dbf0 R2  : 00000000 R3  : 000000c0
R4  : 883ce012 R5  : ffffff6c R6  : 97c15c30 R7  : 0000000e
R8  : 883ce011 R9  : 97e68300 R10 : 883ce0b4 R11 : 8800dc08
R12 : 00000080 R13 : ffffffc0 R14 : 97c1ddcc
MACH: 0000007c MACL: 00000110 GBR : b85ae522 PR  : 8800d1d2

Call trace:
 [<8800db66>] dwarf_unwind_stack+0x9a/0x208
 [<8800dc08>] dwarf_unwind_stack+0x13c/0x208
 [<8800dc08>] dwarf_unwind_stack+0x13c/0x208
 [<8800d118>] dwarf_cfa_execute_insns.isra.1+0x0/0x430
 [<8800dcf4>] dwarf_unwinder_dump+0x20/0x9c
 [<8800cff8>] dwarf_frame_free_regs+0x0/0x68
 [<8800dacc>] dwarf_unwind_stack+0x0/0x208
 [<88005e4a>] unwind_stack+0x2a/0x104
 [<882a6f60>] strlen+0x0/0x60
 [<88043086>] printk+0x1a/0x2c
 [<8804306c>] printk+0x0/0x2c
 [<88002938>] show_trace.part.0+0x2c/0x74
 [<8804306c>] printk+0x0/0x2c
 [<88002b30>] show_stack+0x38/0x5c
 [<88174b10>] bust_spinlocks+0x0/0x50
 [<8804306c>] printk+0x0/0x2c
 [<882a7eea>] dump_stack+0x16/0x2c
 [<88002e44>] arch_local_irq_restore+0x0/0x2c
 [<88015770>] panic+0x98/0x1fc
 [<884ddfcc>] mount_block_root+0x1c0/0x284
 [<882a6f60>] strlen+0x0/0x60
 [<882a6f60>] strlen+0x0/0x60
 [<8804306c>] printk+0x0/0x2c
 [<880e4dfa>] SyS_mknod+0x12/0x20
 [<884de1b8>] mount_root+0x4c/0x7c
 [<8800214c>] do_one_initcall+0x0/0x128
 [<884de31e>] prepare_namespace+0x136/0x1e4
 [<884ddbd8>] kernel_init_freeable+0x11c/0x1c8
 [<8800214c>] do_one_initcall+0x0/0x128
 [<884dd234>] repair_env_string+0x0/0x70
 [<882b6380>] kernel_init+0x14/0xfc
 [<881806e8>] debug_smp_processor_id+0x0/0x24
 [<8804306c>] printk+0x0/0x2c
 [<88007224>] ret_from_kernel_thread+0xc/0x14
 [<88032f2c>] schedule_tail+0x0/0x84
 [<882b636c>] kernel_init+0x0/0xfc

Code:
  8800d166:  
mov       
#47
, 
r0

  8800d168:  
cmp/hi    
r0
, 
r5

  8800d16a:  
bf        
8800d1f6

->8800d16c:  
trapa     
#62

  8800d16e:  
mov       
r4
, 
r8

  8800d170:  
cmp/hi    
r8
, 
r10

  8800d172:  
bf.s      
8800d17e

  8800d174:  
mov       
#0
, 
r0

  8800d176:  
mov.l     
@(8,r9)
, 
r1


Process: swapper (pid: 1, stack limit = 97c1c001)
Stack: (0x97c1ddcc to 0x97c1e000)
ddc0: 
         
         
         
ffffffe0 
000000c0 
97c15c34 
97c15c30 
8800db66 

dde0: 
97c1ddfc 
8800dc08 
97c26cc0 
97e6830c 
00000000 
97e68300 
884f9148 
97e68300 

de00: 
8800dc08 
8800d118 
97c15c34 
97c15c30 
8800dcf4 
97c1de30 
882c0134 
8800cff8 

de20: 
884f9148 
97c1ac00 
8800dacc 
884f90f4 
88005e4a 
97c1de50 
882a6f60 
97e93000 

de40: 
97c1de98 
97c1ac00 
8839c450 
884f90f4 
8835e618 
88043086 
97c1de64 
8804306c 

de60: 
88002938 
97c1de7c 
97e93000 
97c1de98 
00000000 
8804306c 
97c1ac00 
8835e618 

de80: 
88002b30 
97c1de98 
88174b10 
8804306c 
97c1de98 
97c1ac00 
882a7eea 
97c1dea8 

dea0: 
00000000 
88002e44 
88015770 
97c1deb0 
88363a6c 
97c1ded8 
884ddfcc 
97c1dee4 

dec0: 
882a6f60 
97e93000 
88363a6c 
882a6f60 
8804306c 
97e93000 
97c1def0 
00000000 

dee0: 
00000000 
97c1def0 
fffff000 
8834fe40 
756e6b6e 
6f776e2d 
626c6f63 
6b28302c 

df00: 
30290070 
9780a800 
880e4dfa 
97c1df28 
884de1b8 
97c1df30 
884f4060 
884f901c 

df20: 
884f9008 
884f4020 
8800214c 
00000000 
884de31e 
97c1df3c 
884f9024 
884f4060 

df40: 
884ddbd8 
97c1df5c 
884f901c 
884f9008 
884f4020 
8800214c 
884f9014 
00000007 

df60: 
00000007 
00000000 
884dd234 
884f7928 
00000062 
882b6380 
97c1df94 
97c1a53c 

df80: 
881806e8 
883a6f50 
00000000 
884f9014 
8804306c 
88007224 
97c2ff30 
883a734c 

dfa0: 
88032f2c 
00000000 
00000000 
00000000 
00000000 
00000000 
882b636c 
00000000 

dfc0: 
00000000 
00000000 
00000000 
00000000 
00000000 
00000000 
00000000 
00000000 

dfe0: 
00000000 
00000000 
00000000 
40008000 
00000000 
00000000 
00000000 
00000000 

---[ end trace d51c294bbd3f5847 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

random: crng init done


-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
