From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 09 Feb 2011 20:09:30 +0000
Subject: sh: page allocation failure. order:8, mode:0xd0
Message-Id: <201102092109.31220.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Sorry, guys,
but I do not understand the meaning of this error.
Is it a problem of memory page allocation?

Please let me know.

Thanks a lot



sh: page allocation failure. order:8, mode:0xd0
Stack: (0x0c181cf4 to 0x0c182000)
1ce0:                                              0c0fb922 0c181d04 00000008 
1d00: 000000d0 0c04c9b0 0c181d0c 0c0fc26c 00000000 0c00d110 00000010 00000050 
1d20: 00000000 0c177f44 00000001 0c6a0420 00000000 00000080 00000000 00000000 
1d40: 00000010 00000001 00000000 00000000 000200d0 0c177870 00000000 00000000 
1d60: 00000000 0c177870 0c056e26 0c181d88 000a0fd4 00001077 00000008 00000004 
1d80: 0c5a162c 0c5a1658 00000016 00000000 0c174548 000a0fff 00000000 000000a1 
1da0: 000a1fd3 000a1000 ffffffff 0c0fdc68 0c181dcc 00400000 0c08a440 0c181de0 
1dc0: 00400000 0c5a1610 0c5a1610 0c6a0a7c 0c6a0a50 0c181ebc 00001002 00000000 
1de0: 004a0fd4 00000000 00001002 ffffe000 0c14b72c 0c061fd2 0c181dfc 0c05faa6 
1e00: 0c5a1510 0c6a0420 736800da 0c181e14 ffffe000 00000060 0c08abda 0c181e38 
1e20: 0c08a34c ffffe000 00000000 0c181fa4 00000000 0c6a0910 ffffffff 00000000 
1e40: 00000000 00000010 0c1f00c4 ffffffff 00000000 00020000 00000000 00000002 
1e60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
1e80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
1ea0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 7f454c46 
1ec0: 01020100 00000000 00000000 0002002a 00000001 00401630 00000034 0008cf34 
1ee0: 0000810d 00340020 00030028 000f000e 0c5a15a0 0c5a1610 00000000 00000000 
1f00: 00000000 00000000 00020000 00000000 00000000 80000052 0c05f246 0c181f38 
1f20: 00000000 00000000 00000001 0000005e fffffff8 0c6a0910 0c174a8c 0c181fa4 
1f40: 0c6a0912 0c06040c 0c181f64 0c181fa4 00000001 0c6a0910 0ca985d8 0c9df9f0 
1f60: 0c05fe04 0c80a280 00000000 0c0031f2 0c181f8c 0ca799fc 0ca9a250 ffffff0f 
1f80: 00000071 0c181fa4 0c4a3000 0ca985d8 0c9df9f0 0c007a82 0c9df9b8 00000100 
1fa0: 0c0031c0 0000000b 0ca50de4 0ca99008 0000000b 0c9dfbf1 0c9df9f0 0ca985d8 
1fc0: 0c9df9c8 0ca9a250 00000001 0c9dfbf1 0c9df9f0 0ca9a250 0ca799fc 0c9df9b8 
1fe0: 0c9df9b8 0ca50df2 0ca67c58 00000000 00000000 00000000 66666667 0000004c 

Call trace:
 [<0c0fb922>] dump_stack+0xe/0x1c
 [<0c181d04>] printk_all_partitions+0x150/0x1e8
 [<0c04c9b0>] __alloc_pages_nodemask+0x460/0x4e4
 [<0c181d0c>] printk_all_partitions+0x158/0x1e8
 [<0c0fc26c>] _cond_resched+0x0/0x40
 [<0c00d110>] __might_sleep+0x0/0x100
 [<0c056e26>] do_mmap_pgoff+0x596/0x978
 [<0c181d88>] printk_all_partitions+0x1d4/0x1e8
 [<0c0fdc68>] __down_write+0xc/0x18
 [<0c181dcc>] blk_scsi_ioctl_init+0x30/0x1c4
 [<0c08a440>] elf_fdpic_map_file+0xf4/0x588
 [<0c181de0>] blk_scsi_ioctl_init+0x44/0x1c4
 [<0c181ebc>] blk_scsi_ioctl_init+0x120/0x1c4
 [<0c061fd2>] file_permission+0xe/0x1c
 [<0c181dfc>] blk_scsi_ioctl_init+0x60/0x1c4
 [<0c05faa6>] setup_new_exec+0x13a/0x228
 [<0c181e14>] blk_scsi_ioctl_init+0x78/0x1c4
 [<0c08abda>] load_elf_fdpic_binary+0x306/0xad0
 [<0c181e38>] blk_scsi_ioctl_init+0x9c/0x1c4
 [<0c08a34c>] elf_fdpic_map_file+0x0/0x588
 [<0c181fa4>] gunzip+0x24/0x268
 [<0c05f246>] search_binary_handler+0x5e/0x200
 [<0c181f38>] blk_scsi_ioctl_init+0x19c/0x1c4
 [<0c181fa4>] gunzip+0x24/0x268
 [<0c06040c>] do_execve+0x114/0x258
 [<0c181f64>] noop_init+0x4/0x20
 [<0c181fa4>] gunzip+0x24/0x268
 [<0c05fe04>] copy_strings+0x0/0x1d4
 [<0c0031f2>] sys_execve+0x32/0x60
 [<0c181f8c>] gunzip+0xc/0x268
 [<0c181fa4>] gunzip+0x24/0x268
 [<0c007a82>] syscall_call+0xc/0x10
 [<0c0031c0>] sys_execve+0x0/0x60

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:4 inactive_file:0 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:2757 slab_reclaimable:0 slab_unreclaimable:0
 mapped:0 shmem:0 pagetables:0 bounce:0
Normal free:11028kB min:508kB low:632kB high:760kB active_anon:0kB 
inactive_anon:0kB active_file:16kB inactive_file:0kB unevictable:0kB 
isolated(anon):0kB io
lowmem_reserve[]: 0 0
Normal: 15*4kB 7*8kB 10*16kB 14*32kB 13*64kB 12*128kB 11*256kB 10*512kB 
0*1024kB 0*2048kB 0*4096kB 0*8192kB 0*16384kB 0*32768kB = 11028kB
4 total pagecache pages
4096 pages RAM
487 pages reserved
0 pages shared
829 pages non-shared
0 pages in pagetable cache
Allocation of length 659412 from process 254 (sh) failed
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:4 inactive_file:0 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:2757 slab_reclaimable:0 slab_unreclaimable:0
 mapped:0 shmem:0 pagetables:0 bounce:0
Normal free:11028kB min:508kB low:632kB high:760kB active_anon:0kB 
inactive_anon:0kB active_file:16kB inactive_file:0kB unevictable:0kB 
isolated(anon):0kB io
lowmem_reserve[]: 0 0
Normal: 15*4kB 7*8kB 10*16kB 14*32kB 13*64kB 12*128kB 11*256kB 10*512kB 
0*1024kB 0*2048kB 0*4096kB 0*8192kB 0*16384kB 0*32768kB = 11028kB
4 total pagecache pages

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
