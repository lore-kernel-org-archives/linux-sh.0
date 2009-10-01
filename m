From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 01 Oct 2009 08:05:41 +0000
Subject: Re: Suspected memory-corruption on 7724 with Linus' snapshot of
Message-Id: <Pine.LNX.4.64.0910011004520.4408@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 1 Oct 2009, Guennadi Liakhovetski wrote:

> Hi all
> 
> Getting multiple not always reproducible and pretty illogical Oopses on a 
> 7724 system with yesterday's Linus' git. I was attributing Oopses to my 
> driver development, until I got this one:

Sorry, forgot to cc this list on the patch. Here's the culprit: 
http://lkml.org/lkml/2009/10/1/54

Thanks
Guennadi

> 
> [  192.170000] ------------[ cut here ]------------
> [  192.170000] kernel BUG at mm/slab.c:2974!
> [  192.170000] Kernel BUG: 003e [#1]
> [  192.170000] Modules linked in: rj54n1cb0c(+) soc_camera videobuf_dma_contig videobuf_core v4l2_common videodev v4l1_compat [last unloaded: soc_camera]
> [  192.170000]
> [  192.170000] Pid : 862, Comm:                 modprobe
> [  192.170000] CPU : 0                  Not tainted  (2.6.32-rc2 #71)
> [  192.170000]
> [  192.170000] PC is at cache_alloc_refill+0xaa/0x180
> [  192.170000] PR is at kmem_cache_alloc+0x42/0x9c
> [  192.170000] PC  : 8805af2a SP  : 8eec7edc SR  : 400081f1 TEA : c0008454
> [  192.170000] R0  : 00000008 R1  : 00000028 R2  : 00000028 R3  : 8f8db420
> [  192.170000] R4  : 0000001a R5  : 8f803120 R6  : 8f8db000 R7  : 00000029
> [  192.170000] R8  : 0000001b R9  : 8f809800 R10 : 8f803128 R11 : 8f801180
> [  192.170000] R12 : 8f803130 R13 : 000080d0 R14 : 8eec7edc
> [  192.170000] MACH: 00000000 MACL: 00000360 GBR : 296d5450 PR  : 8805b102
> [  192.170000]
> [  192.170000] Call trace:
> [  192.170000]  [<8805b102>] kmem_cache_alloc+0x42/0x9c
> [  192.170000]  [<880f777a>] bus_add_driver+0x32/0x1c8
> [  192.170000]  [<880f8948>] driver_register+0x7c/0x110
> [  192.170000]  [<8811de92>] i2c_register_driver+0x2a/0x84
> [  192.170000]  [<c00b900e>] rj54n1_mod_init+0xe/0x24 [rj54n1cb0c]
> [  192.170000]  [<c00b9000>] rj54n1_mod_init+0x0/0x24 [rj54n1cb0c]
> [  192.170000]  [<88002090>] do_one_initcall+0x40/0x16c
> [  192.170000]  [<880373b2>] sys_init_module+0x8e/0x1c0
> [  192.170000]  [<88007226>] syscall_call+0xc/0x10
> [  192.170000]  [<88037324>] sys_init_module+0x0/0x1c0
> [  192.170000]
> [  192.170000] Code:
> [  192.170000]   8805af24:  mov.l     @(28,r11), r1
> [  192.170000]   8805af26:  cmp/hs    r1, r2
> [  192.170000]   8805af28:  bf        8805af56
> [  192.170000] ->8805af2a:  trapa     #62
> [  192.170000]   8805af2c:  bra       8805af58
> [  192.170000]   8805af2e:  mov       r4, r8
> [  192.170000]   8805af30:  mov.l     @(16,r11), r3
> [  192.170000]   8805af32:  mov.l     @(20,r6), r1
> [  192.170000]   8805af34:  mov.l     @r9, r2
> [  192.170000]
> [  192.170000] Process: modprobe (pid: 862, stack limit = 8eec6001)
> [  192.170000] Stack: (0x8eec7edc to 0x8eec8000)
> [  192.170000] 7ec0:    8f8011c0
> [  192.170000] 7ee0: 8805b102 8eec7f00 fffffff4 8823d21c 8f801180 000080d0 c00b6734 00000000
> [  192.170000] 7f00: 880f777a 8eec7f18 00000000 c00b6734 c00b6734 c00b6710 880f8948 8eec7f38
> [  192.170000] 7f20: 0049a068 00000001 00000000 c00b6734 00000001 c00b6710 8811de92 8eec7f58
> [  192.170000] 7f40: 0049a068 00000001 00000000 8823d21c 00000001 c00b6710 c00b900e 8eec7f6c
> [  192.170000] 7f60: c00b9000 00000001 c00b693c 88002090 8eec7f74 880373b2 8eec7f8c fffffffc
> [  192.170000] 7f80: c00b6840 00000001 c00b693c 88007226 0049a01c 00000000 00000071 00000100
> [  192.170000] 7fa0: 88037324 0041300a 0049a008 00000000 00000080 0049a338 00002e31 0049a0b0
> [  192.170000] 7fc0: 00002e31 00000000 0049a0b0 0049a338 7baaba9c 00000001 0049a068 0049a01c
> [  192.170000] 7fe0: 7baabad8 29655e32 00413340 00008000 296d5450 4a8568ad 00000380 0000005c
> [  192.180000] ---[ end trace 143e8dd4bc401e4c ]---
> 
> which I don't think I could cause. More details and .config tomorrow - 
> unless someone recognises the problem straight away. Just one more note - 
> all Oopses happen on loading and unloading of modules.
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
