From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Mon, 20 Aug 2012 04:19:58 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <5031BAEE.1030207@kmckk.co.jp>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090206090807080600090705"
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------090206090807080600090705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello, Paul

I applied the following 2 patches and got log on kzm9g board.
Please check attached log file.

(2012/08/20 12:13), Paul Mundt wrote:
> On Sun, Aug 19, 2012 at 06:14:41PM -0700, Kuninori Morimoto wrote:
>>
>> Hi Paul
>>
>> Thank you for your patch
>>
>>>> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
>>>> index 32c26d7..8f32a13 100644
>>>> --- a/drivers/sh/intc/core.c
>>>> +++ b/drivers/sh/intc/core.c
>>>> @@ -355,7 +355,7 @@ int __init register_intc_controller(struct intc_desc *desc)
>>>>    			if (unlikely(res)) {
>>>>    				if (res == -EEXIST) {
>>>>    					res = irq_domain_associate(d->domain,
>>>> -								   irq, irq);
>>>> +								   irq2, irq2);
>>>>    					if (unlikely(res)) {
>>>>    						pr_err("domain association "
>>>>    						       "failure\n");
>>>
>>> I tried this patch but there is still the same error.
>>> I checked quickly by debugger, and I found the failing
>>> irq_domain_associate() is not called here (line 357) but the one at line
>>> 328.
>>
>> But, I got same result.
>>
>> This WARNING is indicating
>>> intc: domain association failure
>>
>> So, as kobayashi-san said,
>> it has happend on previous irq_domain_associate(), not here.
>>
> Can you post a boot log with the pr_debug() output in the irqdomain code
> enabled? You may need to add ignore_loglevel to your kernel command line.
>
> If that doesn't produce any further clues I'll have to find one of these
> boards to see what's going on.
>
> ---
>
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 49a7772..3b39c0e 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1,5 +1,7 @@
>   #define pr_fmt(fmt)  "irq: " fmt
>
> +#define DEBUG
> +
>   #include <linux/debugfs.h>
>   #include <linux/hardirq.h>
>   #include <linux/interrupt.h>
>


--------------090206090807080600090705
Content-Type: text/plain; charset=Shift_JIS;
 name="20120820_kzm9g_v36rc2_irqdomain.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="20120820_kzm9g_v36rc2_irqdomain.txt"

Booting Linux on physical CPU 0
Linux version 3.6.0-rc2+ (koba@koba-linux2) (gcc version 4.6.2 20110921 (release) [ARM/embedded-4_6-branch revision 182083] (GNU Tools for ARM Embedded Processors) ) #101 SMP PREEMPT Mon Aug 20 13:08:04 JST 2012
CPU: ARMv7 Processor [412fc098] revision 8 (ARMv7), cr=10c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: kzm9g
debug: ignoring loglevel setting.
Memory policy: ECC disabled, Data cache writealloc
On node 0 totalpages: 61440
free_area_init_node: node 0, pgdat c0489240, node_mem_map c04b9000
  Normal zone: 540 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 60900 pages, LIFO batch:15
bootconsole [early_ttySC4] enabled
PERCPU: Embedded 7 pages/cpu @c06d9000 s6592 r8192 d13888 u32768
pcpu-alloc: s6592 r8192 d13888 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 60900
Kernel command line: console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel earlyprintk=sh-sci.4,115200 root=/dev/mmcblk0p2 mem=240m
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 240MB = 240MB total
Memory: 238488k/238488k available, 7272k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xcf800000 - 0xff000000   ( 760 MB)
    lowmem  : 0xc0000000 - 0xcf000000   ( 240 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc042d000   (4244 kB)
      .init : 0xc042d000 - 0xc04559c0   ( 163 kB)
      .data : 0xc0456000 - 0xc0489ea0   ( 208 kB)
       .bss : 0xc0489ec4 - 0xc04b8b84   ( 188 kB)
Preemptible hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
NR_IRQS:16 nr_irqs:16 16
irq: Allocated domain of type 0 @0xce802800
intc: Registered controller 'sh73a0-intcs' with 77 IRQs
irq: Allocated domain of type 3 @0xce802940
irq: irq_domain_associate_many(<no-node>, irqbase=448, hwbase=448, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=449, hwbase=449, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=464, hwbase=464, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=465, hwbase=465, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=466, hwbase=466, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=467, hwbase=467, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=468, hwbase=468, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=472, hwbase=472, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=475, hwbase=475, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=476, hwbase=476, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=477, hwbase=477, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=479, hwbase=479, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=480, hwbase=480, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=492, hwbase=492, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=493, hwbase=493, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=494, hwbase=494, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=495, hwbase=495, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=500, hwbase=500, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=505, hwbase=505, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=516, hwbase=516, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=517, hwbase=517, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=518, hwbase=518, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=520, hwbase=520, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=521, hwbase=521, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=522, hwbase=522, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=523, hwbase=523, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=524, hwbase=524, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=525, hwbase=525, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=526, hwbase=526, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=432, hwbase=432, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=434, hwbase=434, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=436, hwbase=436, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=437, hwbase=437, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=438, hwbase=438, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=443, hwbase=443, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=444, hwbase=444, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=445, hwbase=445, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=552, hwbase=552, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=553, hwbase=553, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=554, hwbase=554, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=555, hwbase=555, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=556, hwbase=556, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=557, hwbase=557, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=584, hwbase=584, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=587, hwbase=587, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=588, hwbase=588, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=589, hwbase=589, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=590, hwbase=590, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=591, hwbase=591, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=592, hwbase=592, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=593, hwbase=593, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=594, hwbase=594, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=600, hwbase=600, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=601, hwbase=601, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=602, hwbase=602, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=603, hwbase=603, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=604, hwbase=604, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=608, hwbase=608, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=609, hwbase=609, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=615, hwbase=615, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=616, hwbase=616, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=618, hwbase=618, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=619, hwbase=619, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=620, hwbase=620, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=621, hwbase=621, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=623, hwbase=623, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=624, hwbase=624, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=625, hwbase=625, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=626, hwbase=626, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=627, hwbase=627, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=628, hwbase=628, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=629, hwbase=629, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=630, hwbase=630, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=631, hwbase=631, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=632, hwbase=632, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=633, hwbase=633, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=680, hwbase=680, count=1)
intc: Registered controller 'sh73a0-intca-irq-pins' with 32 IRQs
irq: Allocated domain of type 3 @0xce8029c0
irq: irq_domain_associate_many(<no-node>, irqbase=544, hwbase=544, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=545, hwbase=545, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=546, hwbase=546, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=547, hwbase=547, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=548, hwbase=548, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=549, hwbase=549, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=550, hwbase=550, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=551, hwbase=551, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=552, hwbase=552, count=1)
------------[ cut here ]------------
WARNING: at /proj/koba/kernel/linux.mainline/kernel/irq/irqdomain.c:431 irq_domain_associate_many+0xa8/0x200()
error: irq_desc already associated; irq=552 hwirq=0x228
Modules linked in:
Backtrace:
[<c0011f28>] (dump_backtrace+0x0/0x110) from [<c03421b0>] (dump_stack+0x18/0x1c)
 r6:c03e3c90 r5:000001af r4:c0457ec0 r3:c0472908
[<c0342198>] (dump_stack+0x0/0x1c) from [<c001cc90>] (warn_slowpath_common+0x54/0x6c)
[<c001cc3c>] (warn_slowpath_common+0x0/0x6c) from [<c001cd4c>] (warn_slowpath_fmt+0x38/0x40)
 r8:00000228 r7:c044c16c r6:00000000 r5:00000228 r4:ce8029c0
r3:00000009
[<c001cd14>] (warn_slowpath_fmt+0x0/0x40) from [<c0064770>] (irq_domain_associate_many+0xa8/0x200)
 r3:00000228 r2:c03e3d5e
[<c00646c8>] (irq_domain_associate_many+0x0/0x200) from [<c04422e4>] (register_intc_controller+0x51c/0x988)
[<c0441dc8>] (register_intc_controller+0x0/0x988) from [<c0433d80>] (sh73a0_init_irq+0x68/0x1cc)
[<c0433d18>] (sh73a0_init_irq+0x0/0x1cc) from [<c042f4dc>] (init_IRQ+0x1c/0x24)
 r8:4100406a r7:c06d6140 r6:c044b5bc r5:c0489f00 r4:c0456000
[<c042f4c0>] (init_IRQ+0x0/0x24) from [<c042d710>] (start_kernel+0x19c/0x31c)
[<c042d574>] (start_kernel+0x0/0x31c) from [<41008040>] (0x41008040)
 r7:c0461b64 r6:c044b5b8 r5:c045e47c r4:10c5387d
---[ end trace 1b75b31a2719ed1c ]---
intc: domain association failure
irq: irq_domain_associate_many(<no-node>, irqbase=553, hwbase=553, count=1)
------------[ cut here ]------------
WARNING: at /proj/koba/kernel/linux.mainline/kernel/irq/irqdomain.c:431 irq_domain_associate_many+0xa8/0x200()
error: irq_desc already associated; irq=553 hwirq=0x229
Modules linked in:
Backtrace:
[<c0011f28>] (dump_backtrace+0x0/0x110) from [<c03421b0>] (dump_stack+0x18/0x1c)
 r6:c03e3c90 r5:000001af r4:c0457ec0 r3:c0472908
[<c0342198>] (dump_stack+0x0/0x1c) from [<c001cc90>] (warn_slowpath_common+0x54/0x6c)
[<c001cc3c>] (warn_slowpath_common+0x0/0x6c) from [<c001cd4c>] (warn_slowpath_fmt+0x38/0x40)
 r8:00000229 r7:c044c16c r6:00000000 r5:00000229 r4:ce8029c0
r3:00000009
[<c001cd14>] (warn_slowpath_fmt+0x0/0x40) from [<c0064770>] (irq_domain_associate_many+0xa8/0x200)
 r3:00000229 r2:c03e3d5e
[<c00646c8>] (irq_domain_associate_many+0x0/0x200) from [<c04422e4>] (register_intc_controller+0x51c/0x988)
[<c0441dc8>] (register_intc_controller+0x0/0x988) from [<c0433d80>] (sh73a0_init_irq+0x68/0x1cc)
[<c0433d18>] (sh73a0_init_irq+0x0/0x1cc) from [<c042f4dc>] (init_IRQ+0x1c/0x24)
 r8:4100406a r7:c06d6140 r6:c044b5bc r5:c0489f00 r4:c0456000
[<c042f4c0>] (init_IRQ+0x0/0x24) from [<c042d710>] (start_kernel+0x19c/0x31c)
[<c042d574>] (start_kernel+0x0/0x31c) from [<41008040>] (0x41008040)
 r7:c0461b64 r6:c044b5b8 r5:c045e47c r4:10c5387d
---[ end trace 1b75b31a2719ed1d ]---
intc: domain association failure
irq: irq_domain_associate_many(<no-node>, irqbase=554, hwbase=554, count=1)
------------[ cut here ]------------
WARNING: at /proj/koba/kernel/linux.mainline/kernel/irq/irqdomain.c:431 irq_domain_associate_many+0xa8/0x200()
error: irq_desc already associated; irq=554 hwirq=0x22a
Modules linked in:
Backtrace:
[<c0011f28>] (dump_backtrace+0x0/0x110) from [<c03421b0>] (dump_stack+0x18/0x1c)
 r6:c03e3c90 r5:000001af r4:c0457ec0 r3:c0472908
[<c0342198>] (dump_stack+0x0/0x1c) from [<c001cc90>] (warn_slowpath_common+0x54/0x6c)
[<c001cc3c>] (warn_slowpath_common+0x0/0x6c) from [<c001cd4c>] (warn_slowpath_fmt+0x38/0x40)
 r8:0000022a r7:c044c16c r6:00000000 r5:0000022a r4:ce8029c0
r3:00000009
[<c001cd14>] (warn_slowpath_fmt+0x0/0x40) from [<c0064770>] (irq_domain_associate_many+0xa8/0x200)
 r3:0000022a r2:c03e3d5e
[<c00646c8>] (irq_domain_associate_many+0x0/0x200) from [<c04422e4>] (register_intc_controller+0x51c/0x988)
[<c0441dc8>] (register_intc_controller+0x0/0x988) from [<c0433d80>] (sh73a0_init_irq+0x68/0x1cc)
[<c0433d18>] (sh73a0_init_irq+0x0/0x1cc) from [<c042f4dc>] (init_IRQ+0x1c/0x24)
 r8:4100406a r7:c06d6140 r6:c044b5bc r5:c0489f00 r4:c0456000
[<c042f4c0>] (init_IRQ+0x0/0x24) from [<c042d710>] (start_kernel+0x19c/0x31c)
[<c042d574>] (start_kernel+0x0/0x31c) from [<41008040>] (0x41008040)
 r7:c0461b64 r6:c044b5b8 r5:c045e47c r4:10c5387d
---[ end trace 1b75b31a2719ed1e ]---
intc: domain association failure
irq: irq_domain_associate_many(<no-node>, irqbase=555, hwbase=555, count=1)
------------[ cut here ]------------
WARNING: at /proj/koba/kernel/linux.mainline/kernel/irq/irqdomain.c:431 irq_domain_associate_many+0xa8/0x200()
error: irq_desc already associated; irq=555 hwirq=0x22b
Modules linked in:
Backtrace:
[<c0011f28>] (dump_backtrace+0x0/0x110) from [<c03421b0>] (dump_stack+0x18/0x1c)
 r6:c03e3c90 r5:000001af r4:c0457ec0 r3:c0472908
[<c0342198>] (dump_stack+0x0/0x1c) from [<c001cc90>] (warn_slowpath_common+0x54/0x6c)
[<c001cc3c>] (warn_slowpath_common+0x0/0x6c) from [<c001cd4c>] (warn_slowpath_fmt+0x38/0x40)
 r8:0000022b r7:c044c16c r6:00000000 r5:0000022b r4:ce8029c0
r3:00000009
[<c001cd14>] (warn_slowpath_fmt+0x0/0x40) from [<c0064770>] (irq_domain_associate_many+0xa8/0x200)
 r3:0000022b r2:c03e3d5e
[<c00646c8>] (irq_domain_associate_many+0x0/0x200) from [<c04422e4>] (register_intc_controller+0x51c/0x988)
[<c0441dc8>] (register_intc_controller+0x0/0x988) from [<c0433d80>] (sh73a0_init_irq+0x68/0x1cc)
[<c0433d18>] (sh73a0_init_irq+0x0/0x1cc) from [<c042f4dc>] (init_IRQ+0x1c/0x24)
 r8:4100406a r7:c06d6140 r6:c044b5bc r5:c0489f00 r4:c0456000
[<c042f4c0>] (init_IRQ+0x0/0x24) from [<c042d710>] (start_kernel+0x19c/0x31c)
[<c042d574>] (start_kernel+0x0/0x31c) from [<41008040>] (0x41008040)
 r7:c0461b64 r6:c044b5b8 r5:c045e47c r4:10c5387d
---[ end trace 1b75b31a2719ed1f ]---
intc: domain association failure
irq: irq_domain_associate_many(<no-node>, irqbase=556, hwbase=556, count=1)
------------[ cut here ]------------
WARNING: at /proj/koba/kernel/linux.mainline/kernel/irq/irqdomain.c:431 irq_domain_associate_many+0xa8/0x200()
error: irq_desc already associated; irq=556 hwirq=0x22c
Modules linked in:
Backtrace:
[<c0011f28>] (dump_backtrace+0x0/0x110) from [<c03421b0>] (dump_stack+0x18/0x1c)
 r6:c03e3c90 r5:000001af r4:c0457ec0 r3:c0472908
[<c0342198>] (dump_stack+0x0/0x1c) from [<c001cc90>] (warn_slowpath_common+0x54/0x6c)
[<c001cc3c>] (warn_slowpath_common+0x0/0x6c) from [<c001cd4c>] (warn_slowpath_fmt+0x38/0x40)
 r8:0000022c r7:c044c16c r6:00000000 r5:0000022c r4:ce8029c0
r3:00000009
[<c001cd14>] (warn_slowpath_fmt+0x0/0x40) from [<c0064770>] (irq_domain_associate_many+0xa8/0x200)
 r3:0000022c r2:c03e3d5e
[<c00646c8>] (irq_domain_associate_many+0x0/0x200) from [<c04422e4>] (register_intc_controller+0x51c/0x988)
[<c0441dc8>] (register_intc_controller+0x0/0x988) from [<c0433d80>] (sh73a0_init_irq+0x68/0x1cc)
[<c0433d18>] (sh73a0_init_irq+0x0/0x1cc) from [<c042f4dc>] (init_IRQ+0x1c/0x24)
 r8:4100406a r7:c06d6140 r6:c044b5bc r5:c0489f00 r4:c0456000
[<c042f4c0>] (init_IRQ+0x0/0x24) from [<c042d710>] (start_kernel+0x19c/0x31c)
[<c042d574>] (start_kernel+0x0/0x31c) from [<41008040>] (0x41008040)
 r7:c0461b64 r6:c044b5b8 r5:c045e47c r4:10c5387d
---[ end trace 1b75b31a2719ed20 ]---
intc: domain association failure
irq: irq_domain_associate_many(<no-node>, irqbase=557, hwbase=557, count=1)
------------[ cut here ]------------
WARNING: at /proj/koba/kernel/linux.mainline/kernel/irq/irqdomain.c:431 irq_domain_associate_many+0xa8/0x200()
error: irq_desc already associated; irq=557 hwirq=0x22d
Modules linked in:
Backtrace:
[<c0011f28>] (dump_backtrace+0x0/0x110) from [<c03421b0>] (dump_stack+0x18/0x1c)
 r6:c03e3c90 r5:000001af r4:c0457ec0 r3:c0472908
[<c0342198>] (dump_stack+0x0/0x1c) from [<c001cc90>] (warn_slowpath_common+0x54/0x6c)
[<c001cc3c>] (warn_slowpath_common+0x0/0x6c) from [<c001cd4c>] (warn_slowpath_fmt+0x38/0x40)
 r8:0000022d r7:c044c16c r6:00000000 r5:0000022d r4:ce8029c0
r3:00000009
[<c001cd14>] (warn_slowpath_fmt+0x0/0x40) from [<c0064770>] (irq_domain_associate_many+0xa8/0x200)
 r3:0000022d r2:c03e3d5e
[<c00646c8>] (irq_domain_associate_many+0x0/0x200) from [<c04422e4>] (register_intc_controller+0x51c/0x988)
[<c0441dc8>] (register_intc_controller+0x0/0x988) from [<c0433d80>] (sh73a0_init_irq+0x68/0x1cc)
[<c0433d18>] (sh73a0_init_irq+0x0/0x1cc) from [<c042f4dc>] (init_IRQ+0x1c/0x24)
 r8:4100406a r7:c06d6140 r6:c044b5bc r5:c0489f00 r4:c0456000
[<c042f4c0>] (init_IRQ+0x0/0x24) from [<c042d710>] (start_kernel+0x19c/0x31c)
[<c042d574>] (start_kernel+0x0/0x31c) from [<41008040>] (0x41008040)
 r7:c0461b64 r6:c044b5b8 r5:c045e47c r4:10c5387d
---[ end trace 1b75b31a2719ed21 ]---
intc: domain association failure
irq: irq_domain_associate_many(<no-node>, irqbase=558, hwbase=558, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=559, hwbase=559, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=928, hwbase=928, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=929, hwbase=929, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=930, hwbase=930, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=931, hwbase=931, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=932, hwbase=932, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=933, hwbase=933, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=934, hwbase=934, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=935, hwbase=935, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=936, hwbase=936, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=937, hwbase=937, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=938, hwbase=938, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=939, hwbase=939, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=940, hwbase=940, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=941, hwbase=941, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=942, hwbase=942, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=943, hwbase=943, count=1)
intc: Registered controller 'sh73a0-pint0' with 32 IRQs
irq: Allocated domain of type 3 @0xce802a00
irq: irq_domain_associate_many(<no-node>, irqbase=700, hwbase=700, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=701, hwbase=701, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=702, hwbase=702, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=703, hwbase=703, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=704, hwbase=704, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=705, hwbase=705, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=706, hwbase=706, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=707, hwbase=707, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=708, hwbase=708, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=709, hwbase=709, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=710, hwbase=710, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=711, hwbase=711, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=712, hwbase=712, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=713, hwbase=713, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=714, hwbase=714, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=715, hwbase=715, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=716, hwbase=716, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=717, hwbase=717, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=718, hwbase=718, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=719, hwbase=719, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=720, hwbase=720, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=721, hwbase=721, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=722, hwbase=722, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=723, hwbase=723, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=724, hwbase=724, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=725, hwbase=725, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=726, hwbase=726, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=727, hwbase=727, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=728, hwbase=728, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=729, hwbase=729, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=730, hwbase=730, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=731, hwbase=731, count=1)
intc: Registered controller 'sh73a0-pint1' with 8 IRQs
irq: Allocated domain of type 3 @0xce802ac0
irq: irq_domain_associate_many(<no-node>, irqbase=732, hwbase=732, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=733, hwbase=733, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=734, hwbase=734, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=735, hwbase=735, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=736, hwbase=736, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=737, hwbase=737, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=738, hwbase=738, count=1)
irq: irq_domain_associate_many(<no-node>, irqbase=739, hwbase=739, count=1)
sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 3489660920ms
Console: colour dummy device 80x30
console [tty0] enabled
 sh_tmu.0: used for clock events
 sh_tmu.0: used for periodic clock events
 sh_tmu.1: used as clock source
Calibrating delay loop... 2384.28 BogoMIPS (lpj=9314304)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
smp_twd: clock not found: -2
Calibrating local timer... 291.93MHz.
Setting up static identity map for 0x41347a30 - 0x41347a88
CPU1: failed to come online
Brought up 1 CPUs
SMP: Total of 1 processors activated (2384.28 BogoMIPS).
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
sh_pfc gpio: sh73a0_pfc handling gpio 0 -> 928
sh_pfc core: sh73a0_pfc support registered
pinctrl-sh_pfc pinctrl: Use of GPIO API for function requests is deprecated, convert to pinctrl
L310 cache controller enabled
l2x0: 8 ways, CACHE_ID 0x410000c7, AUX_CTRL 0x42460000, Cache size: 524288 B
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c-sh_mobile i2c-sh_mobile.0: I2C adapter 0 with bus speed 100000 Hz
i2c-sh_mobile i2c-sh_mobile.1: I2C adapter 1 with bus speed 100000 Hz
i2c-sh_mobile i2c-sh_mobile.2: I2C adapter 2 with bus speed 100000 Hz
pcf857x 3-0020:
i2c-sh_mobile i2c-sh_mobile.3: I2C adapter 3 with bus speed 100000 Hz
i2c-sh_mobile i2c-sh_mobile.4: I2C adapter 4 with bus speed 100000 Hz
Advanced Linux Sound Architecture Driver Version 1.0.25.
NET: Registered protocol family 23
Switching to clocksource sh_tmu.1
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 4, 98304 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
msgmni has been set to 465
io scheduler noop registered (default)
Console: switching to colour frame buffer device 100x30
sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0: registered sh_mobile_lcdc_fb.0/mainlcd as 800x480 16bpp.
SuperH SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 104) is a scifa
console [ttySC4] enabled, bootconsole disabled
console [ttySC4] enabled, bootconsole disabled
sh-sci.1: ttySC1 at MMIO 0xe6c50000 (irq = 105) is a scifa
sh-sci.2: ttySC2 at MMIO 0xe6c60000 (irq = 106) is a scifa
sh-sci.3: ttySC3 at MMIO 0xe6c70000 (irq = 107) is a scifa
sh-sci.4: ttySC4 at MMIO 0xe6c80000 (irq = 110) is a scifa
sh-sci.5: ttySC5 at MMIO 0xe6cb0000 (irq = 111) is a scifa
sh-sci.6: ttySC6 at MMIO 0xe6cc0000 (irq = 188) is a scifa
sh-sci.7: ttySC7 at MMIO 0xe6cd0000 (irq = 175) is a scifa
sh-sci.8: ttySC8 at MMIO 0xe6c30000 (irq = 112) is a scifb
smsc911x: Driver version 2008-10-21
libphy: smsc911x-mdio: probed
smsc911x smsc911x.0: eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=smsc911x-0:01, irq=-1)
smsc911x smsc911x.0: eth0: MAC Address: 00:01:9b:04:04:10
r8a66597_hcd r8a66597_hcd.0: USB Host Controller
r8a66597_hcd r8a66597_hcd.0: new USB bus registered, assigned bus number 1
r8a66597_hcd r8a66597_hcd.0: irq 417, io base 0x10010000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
renesas_usbhs renesas_usbhs: gadget probed
renesas_usbhs renesas_usbhs: probed
input: gpio-keys-polled as /devices/platform/gpio-keys-polled.0/input/input0
input: st1232-touchscreen as /devices/platform/i2c-sh_mobile.1/i2c-1/1-0055/input/input1
rtc-rs5c372 0-0032: r2025sd found, am/pm, driver version 0.6
rtc-rs5c372 0-0032: rtc core: registered rtc-rs5c372 as rtc0
i2c /dev entries driver
sh_mobile_sdhi sh_mobile_sdhi.0: mmc0 base at 0xee100000 clock rate 0 MHz
sh_mobile_sdhi sh_mobile_sdhi.2: mmc1 base at 0xee140000 clock rate 0 MHz
usb 1-2: new high-speed USB device number 2 using r8a66597_hcd
sh_mmcif sh_mmcif.0: driver version 2010-04-28
sh_pfc gpio: attaching to GPIO chip sh73a0_pfc
sh_cmt sh_cmt.10: used for clock events
sh_cmt sh_cmt.10: used as clock source
sh_tmu sh_tmu.0: kept as earlytimer
sh_tmu sh_tmu.1: kept as earlytimer
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
platform asoc-simple-card.0: Driver asoc-simple-card requests probe deferral
TCP: cubic registered
NET: Registered protocol family 17
Key type dns_resolver registered
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 2
mmc0: new high speed SDHC card at address b368
Registering SWP/SWPB emulation handler
mmcblk0: mmc0:b368 LEXAR 3.73 GiB
 mmcblk0: p1 p2
rtc-rs5c372 0-0032: setting system clock to 2012-08-20 04:08:54 UTC (1345435734)
asoc-simple-card asoc-simple-card.0:  ak4642-hifi <-> fsia-dai mapping ok
scsi0 : usb-storage 1-2:1.0
smsc911x smsc911x.0: eth0: SMSC911x/921x identified at 0xcf9e8000, IRQ: 419
Sending DHCP requests .mmc1: new high speed SDHC card at address b368
mmcblk1: mmc1:b368 SD04G 3.66 GiB
 mmcblk1: p1 p2 p3
usb 1-2: address 2, EndpointAddress 0x02 use DMA FIFO
usb 1-2: address 2, EndpointAddress 0x81 use DMA FIFO
[sched_delayed] sched: RT throttling activated
scsi 0:0:0:0: Direct-Access              Patriot Memory   PMAP PQ: 0 ANSI: 0 CCS
mmc2: new high speed MMC card at address 0001
mmcblk2: mmc2:0001 M4G1EM 3.72 GiB
 mmcblk2: p1
sd 0:0:0:0: [sda] 7831552 512-byte logical blocks: (4.00 GB/3.73 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 23 00 00 00
sd 0:0:0:0: [sda] No Caching mode page present
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] No Caching mode page present
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1 sda2
sd 0:0:0:0: [sda] No Caching mode page present
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] Attached SCSI removable disk
.., OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 192.168.1.35
IP-Config: Complete:
     device=eth0, addr=192.168.1.35, mask=255.255.255.0, gw=192.168.1.62
     host=192.168.1.35, domain=kmckk.jp, nis-domain=(none)
     bootserver=0.0.0.0, rootserver=0.0.0.0, rootpath=
ALSA device list:
  #0: FSI2A-AK4648
EXT3-fs (mmcblk0p2): error: couldn't mount because of unsupported optional features (240)
EXT2-fs (mmcblk0p2): error: couldn't mount because of unsupported optional features (240)
EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) on device 179:2.
Freeing init memory: 160K
modprobe: FATAL: Could not load /lib/modules/3.6.0-rc2+/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/3.6.0-rc2+/modules.dep: No such file or directory

modprobe: FATAL: Could not load /lib/modules/3.6.0-rc2+/modules.dep: No such file or directory

init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: plymouth main process (469) killed by SEGV signal
init: plymouth-splash main process (3074) terminated with status 2
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: failsafe main process (3130) killed by TERM signal
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory

init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
 * Starting internet superserver inetd       init: Temporary process spawn error: No such file or directory
                                                                               init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
                                                                         [ OK ]
Last login: Mon Aug 20 00:30:39 UTC 2012 on tty1
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
Welcome to Linaro 12.08 (development branch) (GNU/Linux 3.6.0-rc2+ armv7l)

 * Documentation:  https://wiki.linaro.org/
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: Failed to create pty - disabling logging for job
init: Temporary process spawn error: No such file or directory
init: tty1 main process (3262) killed by TERM signal
root@linaro-alip:~#



--------------090206090807080600090705--
