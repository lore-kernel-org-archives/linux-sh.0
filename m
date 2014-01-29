From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 29 Jan 2014 16:03:21 +0000
Subject: Re: [PATCH RFC 0/2] ARM: shmobile: lager: Enable DMA bounce for PCI
Message-Id: <52E92649.80806@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390935213-12896-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390935213-12896-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 29/01/14 12:47, Valentine wrote:
> On 01/29/2014 04:45 PM, Ben Dooks wrote:
>> On 29/01/14 11:15, Valentine wrote:
>>> On 01/29/2014 12:03 PM, Ben Dooks wrote:
>>>> On 29/01/14 06:45, Simon Horman wrote:
>>>>> On Tue, Jan 28, 2014 at 10:53:31PM +0400, Valentine Barshak wrote:
>>>>>> This enables DMA bounce for PCI since the controller does
>>>>>> not support more than 2G PCI-AHB memory window.
>>>>>> The problems with DMA transfers can be observed when
>>>>>> setting 2G/2G user/kernel memory split model
>>>>>> (CONFIG_VMSPLIT_2G=y)
>>>>>> These patches help to avoid it.
>>>>>
>>>>> Are these patches compatible with other user/kernel splits?
>>>>
>>>> PS, the bridge is only actually capable of seeing 1GiB of
>>>> RAM due to alignment issues in the window. You can have either
>>>> 0x4..0x8 or 0x8..0xc but not /both/. If you open the window to
>>>> 2GiB then you can see either 0x0..0x8 or 0x8..0xF range.
>>>>
>>>
>>> I don't think this is relater to the user/kernel space memory split.
>>>
>>> Currently the R-Car Gen2 PCI driver uses 0x40000000 - 0x7fffffff
>>> PCI-AHB region. We can set it to 0x00000000 - 0x7fffffff,
>>> but there's no RAM below 0x40000000 so no DMA access to that area is
>>> actually legal from the PCI USB host driver.
>>> So the change wouldn't give us much.
>>
>> Well, there's IO areas but probably not wanting to DMA to them anyway.
>>
>>> The 31-bit DMA mask takes care of forbidding any DMA transfers
>>> to the area above 0x7fffffff.
>>
>> I will add this to our current patch series and see if it helps.
>
> Helps with what?
>
> I don't see any issues with the current patches.

We're clearly not testing the same configurations, as all your patches
either are not DT enabled or are for the non-multiplatform kernel
builds. I've tried porting your DMA bounce changes to the
multiplatform board-lager-reference.c file but that has not fixed
the issue for me.

This is the last log I have for looking into the issue:

> h_eth:1 is connected to sh_eth.  Reconnecting to sh_eth
> sh_eth Waiting for PHY auto negotiation to complete.. done
> sh_eth: 100Base/Full
> Using sh_eth device
> TFTP from server 10.24.1.138; our IP address is 10.24.1.143
> Filename 'zImage'.
> Load address: 0x40008000
> Loading: *#################################################################
> 	 #################################################################
> 	 #################################################################
> 	 #################################################################
> 	 #################################################################
> 	 #################################################################
> 	 #################################################################
> 	 #################################################################
> 	 #####################
> 	 2.8 MiB/s
> done
> Bytes transferred = 2765921 (2a3461 hex)
> sh_eth:1 is connected to sh_eth.  Reconnecting to sh_eth
> sh_eth Waiting for PHY auto negotiation to complete.. done
> sh_eth: 100Base/Full
> Using sh_eth device
> TFTP from server 10.24.1.138; our IP address is 10.24.1.143
> Filename 'r8a7790-lager.dtb'.
> Load address: 0x40f00000
> Loading: *####
> 	 2.8 MiB/s
> done
> Bytes transferred = 17889 (45e1 hex)
>
> Starting kernel ...
>
> Booting Linux on physical CPU 0x0
> Linux version 3.13.0-rc7-bjd1-00072-g3785df4-dirty (ben@rainbowdash) (gcc version 4.6.3 (crosstool-NG 1.17.0) ) #268 SMP Wed Jan 29 15:21:44 GMT 2014
> CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), crc53c7d
> CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> Ignoring memory at 0x180000000 outside 32-bit physical address space
> Machine model: Lager
> debug: ignoring loglevel setting.
> Truncating RAM at 40000000-bfffffff to -6f7fffff (vmalloc region overlap).
> cma: CMA: reserved 32 MiB at 6d800000
> Memory policy: Data cache writealloc
> On node 0 totalpages: 194560
> free_area_init_node: node 0, pgdat c056fd00, node_mem_map c0815000
>   DMA zone: 1520 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 194560 pages, LIFO batch:31
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at /home/ben/ct178/renesas/arch/arm/kernel/devtree.c:147 arm_dt_init_cpu_maps+0x10c/0x1bc()
> DT /cpu 5 nodes greater than max cores 4, capping them
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.13.0-rc7-bjd1-00072-g3785df4-dirty #268
> Backtrace:
> [<c0011df0>] (dump_backtrace+0x0/0x110) from [<c0012160>] (show_stack+0x18/0x1c)
>  r6:c0498aba r5:00000009 r4:00000000 r3:00200000
> [<c0012148>] (show_stack+0x0/0x1c) from [<c03cc5e4>] (dump_stack+0x70/0x8c)
> [<c03cc574>] (dump_stack+0x0/0x8c) from [<c0023b8c>] (warn_slowpath_common+0x6c/0x8c)
>  r4:c0545f00 r3:c0552c98
> [<c0023b20>] (warn_slowpath_common+0x0/0x8c) from [<c0023c50>] (warn_slowpath_fmt+0x38/0x40)
>  r8:c0e08170 r7:00000001 r6:00000000 r5:c0e08514 r4:00000005
> [<c0023c18>] (warn_slowpath_fmt+0x0/0x40) from [<c0513128>] (arm_dt_init_cpu_maps+0x10c/0x1bc)
>  r3:00000005 r2:c0498b15
> [<c051301c>] (arm_dt_init_cpu_maps+0x0/0x1bc) from [<c051224c>] (setup_arch+0x5d8/0x930)
> [<c0511c74>] (setup_arch+0x0/0x930) from [<c0510888>] (start_kernel+0x80/0x31c)
>  r8:4000406a r7:c054f9f0 r6:c0538734 r5:c05709c0 r4:00000001
> [<c0510808>] (start_kernel+0x0/0x31c) from [<40008074>] (0x40008074)
>  r6:c0538734 r5:c054c3cc r4:10c53c7d
> ---[ end trace 3406ff24bd97382e ]---
> PERCPU: Embedded 7 pages/cpu @c0e11000 s7104 r8192 d13376 u32768
> pcpu-alloc: s7104 r8192 d13376 u32768 alloc=8*4096
> pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 193040
> Kernel command line: console=ttySC6,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp nfsroot.24.1.138:/home/nfsroot/debian-eabi
> PID hash table entries: 4096 (order: 2, 16384 bytes)
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 732584K/778240K available (3880K kernel code, 178K rwdata, 1264K rodata, 206K init, 188K bss, 45656K reserved)
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
>     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
>     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>       .text : 0xc0008000 - 0xc050f01c   (5149 kB)
>       .init : 0xc0510000 - 0xc0543bc0   ( 207 kB)
>       .data : 0xc0544000 - 0xc0570980   ( 179 kB)
>        .bss : 0xc0570988 - 0xc059fac4   ( 189 kB)
> Hierarchical RCU implementation.
> NR_IRQS:16 nr_irqs:16 16
> Architected cp15 timer(s) running at 10.00MHz (virt).
> sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 3435973836800ns
> Switching to timer-based delay loop
> Console: colour dummy device 80x30
> Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj0000)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> CPU0: update cpu_power 1024
> CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> Setting up static identity map for 0x403d0da8 - 0x403d0e00
> CPU1: Booted secondary processor
> CPU1: update cpu_power 1024
> CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> CPU2: Booted secondary processor
> CPU2: update cpu_power 1024
> CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
> CPU3: Booted secondary processor
> CPU3: update cpu_power 1024
> CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
> Brought up 4 CPUs
> SMP: Total of 4 processors activated.
> CPU: All CPU(s) started in SVC mode.
> VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
> pinctrl core: initialized pinctrl subsystem
> regulator-dummy: no parameters
> NET: Registered protocol family 16
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> : enabling platform dma restrictions
> renesas_irqc e61c0000.interrupt-controller: driving 4 irqs
> sh-pfc e6060000.pfc: r8a77900_pfc support registered
> hw-breakpoint: Failed to enable monitor mode on CPU 3.
> No ATAGs?
> bio: create slab <bio-0> at 0
> pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
> pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
> pci_bus 0000:00: scanning bus
> pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
> pci 0000:00:00.0: calling quirk_mmio_always_on+0x0/0x1c
> pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
> pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
> pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x58
> pci 0000:00:00.0: dmabounce: registered device
> pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
> pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
> pci 0000:00:01.0: calling pci_fixup_ide_bases+0x0/0x58
> pci 0000:00:01.0: supports D1 D2
> pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
> pci 0000:00:01.0: PME# disabled
> pci 0000:00:01.0: dmabounce: registered device
> pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
> pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
> pci 0000:00:02.0: calling pci_fixup_ide_bases+0x0/0x58
> pci 0000:00:02.0: supports D1 D2
> pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
> pci 0000:00:02.0: PME# disabled
> pci 0000:00:02.0: dmabounce: registered device
> pci_bus 0000:00: fixups for bus
> PCI: bus0: Fast back to back transfers disabled
> pci_bus 0000:00: bus scan returning with max 
> pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
> pci-rcar-gen2 ee0b0000.pci: PCI: bus1 revision 11
> PCI host bridge to bus 0000:01
> pci_bus 0000:01: root bus resource [io  0xee0a0000-0xee0a10ff]
> pci_bus 0000:01: root bus resource [mem 0xee0a0000-0xee0a10ff]
> pci_bus 0000:01: No busn resource found for root bus, will use [bus 01-ff]
> pci_bus 0000:01: scanning bus
> pci 0000:01:00.0: [1033:0000] type 00 class 0x060000
> pci 0000:01:00.0: calling quirk_mmio_always_on+0x0/0x1c
> pci 0000:01:00.0: reg 0x10: [mem 0xee0b0800-0xee0b0bff]
> pci 0000:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
> pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x58
> pci 0000:01:00.0: dmabounce: registered device
> pci 0000:01:01.0: [1033:0035] type 00 class 0x0c0310
> pci 0000:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
> pci 0000:01:01.0: calling pci_fixup_ide_bases+0x0/0x58
> pci 0000:01:01.0: supports D1 D2
> pci 0000:01:01.0: PME# supported from D0 D1 D2 D3hot
> pci 0000:01:01.0: PME# disabled
> pci 0000:01:01.0: dmabounce: registered device
> pci 0000:01:02.0: [1033:00e0] type 00 class 0x0c0320
> pci 0000:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
> pci 0000:01:02.0: calling pci_fixup_ide_bases+0x0/0x58
> pci 0000:01:02.0: supports D1 D2
> pci 0000:01:02.0: PME# supported from D0 D1 D2 D3hot
> pci 0000:01:02.0: PME# disabled
> pci 0000:01:02.0: dmabounce: registered device
> pci_bus 0000:01: fixups for bus
> PCI: bus1: Fast back to back transfers disabled
> pci_bus 0000:01: bus scan returning with max
> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> pci-rcar-gen2 ee0d0000.pci: PCI: bus2 revision 11
> PCI host bridge to bus 0000:02
> pci_bus 0000:02: root bus resource [io  0xee0c0000-0xee0c10ff]
> pci_bus 0000:02: root bus resource [mem 0xee0c0000-0xee0c10ff]
> pci_bus 0000:02: No busn resource found for root bus, will use [bus 02-ff]
> pci_bus 0000:02: scanning bus
> pci 0000:02:00.0: [1033:0000] type 00 class 0x060000
> pci 0000:02:00.0: calling quirk_mmio_always_on+0x0/0x1c
> pci 0000:02:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
> pci 0000:02:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
> pci 0000:02:00.0: calling pci_fixup_ide_bases+0x0/0x58
> pci 0000:02:00.0: dmabounce: registered device
> pci 0000:02:01.0: [1033:0035] type 00 class 0x0c0310
> pci 0000:02:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
> pci 0000:02:01.0: calling pci_fixup_ide_bases+0x0/0x58
> pci 0000:02:01.0: supports D1 D2
> pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot
> pci 0000:02:01.0: PME# disabled
> pci 0000:02:01.0: dmabounce: registered device
> pci 0000:02:02.0: [1033:00e0] type 00 class 0x0c0320
> pci 0000:02:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
> pci 0000:02:02.0: calling pci_fixup_ide_bases+0x0/0x58
> pci 0000:02:02.0: supports D1 D2
> pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot
> pci 0000:02:02.0: PME# disabled
> pci 0000:02:02.0: dmabounce: registered device
> pci_bus 0000:02: fixups for bus
> PCI: bus2: Fast back to back transfers disabled
> pci_bus 0000:02: bus scan returning with max
> pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
> pci 0000:00:00.0: fixup irq: got 140
> pci 0000:00:00.0: assigning IRQ 140
> pci 0000:00:01.0: fixup irq: got 140
> pci 0000:00:01.0: assigning IRQ 140
> pci 0000:00:02.0: fixup irq: got 140
> pci 0000:00:02.0: assigning IRQ 140
> pci 0000:01:00.0: fixup irq: got 144
> pci 0000:01:00.0: assigning IRQ 144
> pci 0000:01:01.0: fixup irq: got 144
> pci 0000:01:01.0: assigning IRQ 144
> pci 0000:01:02.0: fixup irq: got 144
> pci 0000:01:02.0: assigning IRQ 144
> pci 0000:02:00.0: fixup irq: got 145
> pci 0000:02:00.0: assigning IRQ 145
> pci 0000:02:01.0: fixup irq: got 145
> pci 0000:02:01.0: assigning IRQ 145
> pci 0000:02:02.0: fixup irq: got 145
> pci 0000:02:02.0: assigning IRQ 145
> pci 0000:02:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
> pci 0000:02:01.0: BAR 0: set to [mem 0xee0c0000-0xee0c0fff] (PCI address [0xee0c0000-0xee0c0fff])
> pci 0000:02:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
> pci 0000:02:02.0: BAR 0: set to [mem 0xee0c1000-0xee0c10ff] (PCI address [0xee0c1000-0xee0c10ff])
> pci 0000:01:01.0: BAR 0: assigned [mem 0xee0a0000-0xee0a0fff]
> pci 0000:01:01.0: BAR 0: set to [mem 0xee0a0000-0xee0a0fff] (PCI address [0xee0a0000-0xee0a0fff])
> pci 0000:01:02.0: BAR 0: assigned [mem 0xee0a1000-0xee0a10ff]
> pci 0000:01:02.0: BAR 0: set to [mem 0xee0a1000-0xee0a10ff] (PCI address [0xee0a1000-0xee0a10ff])
> pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
> pci 0000:00:01.0: BAR 0: set to [mem 0xee080000-0xee080fff] (PCI address [0xee080000-0xee080fff])
> pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
> pci 0000:00:02.0: BAR 0: set to [mem 0xee081000-0xee0810ff] (PCI address [0xee081000-0xee0810ff])
> fixed-3.3V: 3300 mV
> vgaarb: loaded
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> media: Linux media interface: v0.10
> Linux video capture interface: v2.00
> sh_cmt sh_cmt.0: used for clock events
> Switched to clocksource arch_sys_counter
> i2c-rcar e6508000.i2c: probed
> i2c-rcar e6518000.i2c: probed
> i2c-rcar e6530000.i2c: probed
> i2c-rcar e6540000.i2c: probed
> NET: Registered protocol family 2
> TCP established hash table entries: 8192 (order: 3, 32768 bytes)
> TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP: reno registered
> UDP hash table entries: 512 (order: 2, 16384 bytes)
> UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
> NET: Registered protocol family 1
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> pci 0000:00:01.0: calling quirk_usb_early_handoff+0x0/0x7a8
> PCI: enabling device 0000:00:01.0 (0140 -> 0142)
> pci 0000:00:02.0: calling quirk_usb_early_handoff+0x0/0x7a8
> PCI: enabling device 0000:00:02.0 (0140 -> 0142)
> pci 0000:01:01.0: calling quirk_usb_early_handoff+0x0/0x7a8
> PCI: enabling device 0000:01:01.0 (0140 -> 0142)
> pci 0000:01:02.0: calling quirk_usb_early_handoff+0x0/0x7a8
> PCI: enabling device 0000:01:02.0 (0140 -> 0142)
> pci 0000:02:01.0: calling quirk_usb_early_handoff+0x0/0x7a8
> PCI: enabling device 0000:02:01.0 (0140 -> 0142)
> pci 0000:02:02.0: calling quirk_usb_early_handoff+0x0/0x7a8
> PCI: enabling device 0000:02:02.0 (0140 -> 0142)
> PCI: CLS 64 bytes, default 64
> NFS: Registering the id_resolver key type
> Key type id_resolver registered
> Key type id_legacy registered
> nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> msgmni has been set to 1494
> io scheduler noop registered (default)
> gpio_rcar e6050000.gpio: driving 32 GPIOs
> gpio_rcar e6051000.gpio: driving 32 GPIOs
> gpio_rcar e6052000.gpio: driving 32 GPIOs
> gpio_rcar e6053000.gpio: driving 32 GPIOs
> gpio_rcar e6054000.gpio: driving 32 GPIOs
> gpio_rcar e6055000.gpio: driving 32 GPIOs
> SuperH (H)SCI(F) driver initialized
> sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 176, base_baud = 0) is a scifa
> sh-sci.1: ttySC1 at MMIO 0xe6c50000 (irq = 177, base_baud = 0) is a scifa
> sh-sci.2: ttySC2 at MMIO 0xe6c20000 (irq = 180, base_baud = 0) is a scifb
> sh-sci.3: ttySC3 at MMIO 0xe6c30000 (irq = 181, base_baud = 0) is a scifb
> sh-sci.4: ttySC4 at MMIO 0xe6ce0000 (irq = 182, base_baud = 0) is a scifb
> sh-sci.5: ttySC5 at MMIO 0xe6c60000 (irq = 183, base_baud = 0) is a scifa
> sh-sci.6: ttySC6 at MMIO 0xe6e60000 (irq = 184, base_baud = 0) is a scif
> console [ttySC6] enabled
> sh-sci.7: ttySC7 at MMIO 0xe6e68000 (irq = 185, base_baud = 0) is a scif
> sh-sci.8: ttySC8 at MMIO 0xe62c0000 (irq = 186, base_baud = 0) is a hscif
> sh-sci.9: ttySC9 at MMIO 0xe62c8000 (irq = 187, base_baud = 0) is a hscif
> [drm] Initialized drm 1.1.0 20060810
> rcar-du feb00000.rcar-du: counting nodes...
> rcar-du feb00000.rcar-du: looking for output0
> adv7511 2-0039: got to 810
> adv7511 2-0039: got to 868
> adv7511 2-0039: got to 883
> adv7511 2-0039: did not get hpd event
> rcar-du feb00000.rcar-du: setting hdmi slave configuration
> rcar-du feb00000.rcar-du: looking for output1
> rcar-du feb00000.rcar-du: no output selected
> Console: switching to colour frame buffer device 240x67
> rcar-du feb00000.rcar-du: fb0:  frame buffer device
> rcar-du feb00000.rcar-du: registered panic notifier
> [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [drm] No driver support for vblank timestamp query.
> [drm] Initialized rcar-du 1.0.0 20130110 on minor 0
> sh-pfc e6060000.pfc: DT node must contain at least a function or config
> sh-pfc e6060000.pfc: no mapping found in node /pfc@e6060000/eth
> sh-eth ee700000.sh_net: match c0564218 (renesas,r8a7790-ether)
> sh-eth ee700000.sh_net: new platform data ed35d890
> sh-pfc e6060000.pfc: DT node must contain at least a function or config
> sh-pfc e6060000.pfc: no mapping found in node /pfc@e6060000/eth
> sh-eth ee700000.sh_net: set default pinctrl
> lager_ksz8041_fixup: called for phy ed2ab400 (drv   (null))
> lager_ksz8041_fixup: phy id 0000,0000
> libphy: sh_mii: probed
> Base address at 0xee700000, 2e:09:0a:00:3d:e0, IRQ 194.
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-pci: EHCI PCI platform driver
> ehci-pci 0000:00:02.0: enabling bus mastering
> ehci-pci 0000:00:02.0: EHCI Host Controller
> ehci-pci 0000:00:02.0: new USB bus registered, assigned bus number 1
> ehci-pci 0000:00:02.0: enabling Mem-Wr-Inval
> ehci-pci 0000:00:02.0: irq 140, io mem 0xee081000
> ehci-pci 0000:00:02.0: USB 2.0 started, EHCI 1.00
> usb usb1: New USB device found, idVendor6b, idProduct 02
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: EHCI Host Controller
> usb usb1: Manufacturer: Linux 3.13.0-rc7-bjd1-00072-g3785df4-dirty ehci_hcd
> usb usb1: SerialNumber: 0000:00:02.0
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> ehci-pci 0000:01:02.0: enabling bus mastering
> ehci-pci 0000:01:02.0: EHCI Host Controller
> ehci-pci 0000:01:02.0: new USB bus registered, assigned bus number 2
> ehci-pci 0000:01:02.0: enabling Mem-Wr-Inval
> ehci-pci 0000:01:02.0: irq 144, io mem 0xee0a1000
> ehci-pci 0000:01:02.0: USB 2.0 started, EHCI 1.00
> usb usb2: New USB device found, idVendor6b, idProduct 02
> usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: EHCI Host Controller
> usb usb2: Manufacturer: Linux 3.13.0-rc7-bjd1-00072-g3785df4-dirty ehci_hcd
> usb usb2: SerialNumber: 0000:01:02.0
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 1 port detected
> ehci-pci 0000:02:02.0: enabling bus mastering
> ehci-pci 0000:02:02.0: EHCI Host Controller
> ehci-pci 0000:02:02.0: new USB bus registered, assigned bus number 3
> ehci-pci 0000:02:02.0: enabling Mem-Wr-Inval
> ehci-pci 0000:02:02.0: irq 145, io mem 0xee0c1000
> ehci-pci 0000:02:02.0: USB 2.0 started, EHCI 1.00
> usb usb3: New USB device found, idVendor6b, idProduct 02
> usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb3: Product: EHCI Host Controller
> usb usb3: Manufacturer: Linux 3.13.0-rc7-bjd1-00072-g3785df4-dirty ehci_hcd
> usb usb3: SerialNumber: 0000:02:02.0
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 1 port detected
> ehci-platform: EHCI generic platform driver
> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> ohci-pci: OHCI PCI platform driver
> ohci-pci 0000:00:01.0: enabling bus mastering
> ohci-pci 0000:00:01.0: OHCI PCI host controller
> ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 4
> ohci-pci 0000:00:01.0: read 00000000 from 0004
> ohci-pci 0000:00:01.0: write 80000000 to 0014
> ohci-pci 0000:00:01.0: read 00000000 from 0004
> ohci-pci 0000:00:01.0: read 0f000901 from 0048
> ohci-pci 0000:00:01.0: irq 140, io mem 0xee080000
> ohci-pci 0000:00:01.0: read 00002edf from 0034
> ohci-pci 0000:00:01.0: write 00000200 to 0004
> ohci-pci 0000:00:01.0: read 00000000 from 0004
> ohci-pci 0000:00:01.0: write 00000001 to 0008
> ohci-pci 0000:00:01.0: read 00000000 from 0008
> ohci-pci 0000:00:01.0: write 00000000 to 0020
> ohci-pci 0000:00:01.0: write 00000000 to 0028
> ohci-pci 0000:00:01.0: write 6d803000 to 0018
> ohci-pci 0000:00:01.0: read 00002edf from 0034
> ohci-pci 0000:00:01.0: write a7782edf to 0034
> ohci-pci 0000:00:01.0: write 00002a2f to 0040
> ohci-pci 0000:00:01.0: read 00002edf from 0034
> ohci-pci 0000:00:01.0: write 00000001 to 0008
> ohci-pci 0000:00:01.0: read 00000000 from 0008
> ohci-pci 0000:00:01.0: write 00000200 to 0004
> ohci-pci 0000:00:01.0: read 00000000 from 0004
> ohci-pci 0000:00:01.0: write 00000000 to 0020
> ohci-pci 0000:00:01.0: write 00000000 to 0028
> ohci-pci 0000:00:01.0: write 6d803000 to 0018
> ohci-pci 0000:00:01.0: read 00002edf from 0034
> ohci-pci 0000:00:01.0: write a7782edf to 0034
> ohci-pci 0000:00:01.0: write 00002a2f to 0040
> ohci-pci 0000:00:01.0: read 00002edf from 0034
> ohci-pci 0000:00:01.0: read 00002edf from 0034
> ohci-pci 0000:00:01.0: read 00000000 from 0040
> ohci-pci 0000:00:01.0: init err (00002edf 0000)
> ohci-pci 0000:00:01.0: can't start
> ohci-pci 0000:00:01.0: write 80000000 to 0014
> ohci-pci 0000:00:01.0: read 00000000 from 0004
> ohci-pci 0000:00:01.0: write 00000000 to 0004
> ohci-pci 0000:00:01.0: startup error -75
> ohci-pci 0000:00:01.0: USB bus 4 deregistered
> ohci-pci 0000:00:01.0: init 0000:00:01.0 fail, -75
> ohci-pci: probe of 0000:00:01.0 failed with error -75
> ohci-pci 0000:01:01.0: enabling bus mastering
> ohci-pci 0000:01:01.0: OHCI PCI host controller
> ohci-pci 0000:01:01.0: new USB bus registered, assigned bus number 4
> ohci-pci 0000:01:01.0: read 00000000 from 0004
> ohci-pci 0000:01:01.0: write 80000000 to 0014
> ohci-pci 0000:01:01.0: read 00000000 from 0004
> ohci-pci 0000:01:01.0: read 0f000901 from 0048
> ohci-pci 0000:01:01.0: irq 144, io mem 0xee0a0000
> ohci-pci 0000:01:01.0: read 00002edf from 0034
> ohci-pci 0000:01:01.0: write 00000200 to 0004
> ohci-pci 0000:01:01.0: read 00000200 from 0004
> ohci-pci 0000:01:01.0: write 00000001 to 0008
> ohci-pci 0000:01:01.0: read 00000000 from 0008
> ohci-pci 0000:01:01.0: write 00000000 to 0020
> ohci-pci 0000:01:01.0: write 00000000 to 0028
> ohci-pci 0000:01:01.0: write 6d803000 to 0018
> ohci-pci 0000:01:01.0: read 00002edf from 0034
> ohci-pci 0000:01:01.0: write a7782edf to 0034
> ohci-pci 0000:01:01.0: write 00002a2f to 0040
> ohci-pci 0000:01:01.0: read a7782edf from 0034
> ohci-pci 0000:01:01.0: read 00002a2f from 0040
> ohci-pci 0000:01:01.0: write 00000283 to 0004
> ohci-pci 0000:01:01.0: write 00008000 to 0050
> ohci-pci 0000:01:01.0: write ffffffff to 000c
> ohci-pci 0000:01:01.0: write 8000005a to 0010
> ohci-pci 0000:01:01.0: read 0f000901 from 0048
> ohci-pci 0000:01:01.0: write 0f000201 to 0048
> ohci-pci 0000:01:01.0: write 00010000 to 0050
> ohci-pci 0000:01:01.0: write 00000000 to 004c
> ohci-pci 0000:01:01.0: read 00000283 from 0004
> usb usb4: New USB device found, idVendor6b, idProduct 01
> usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb4: Product: OHCI PCI host controller
> usb usb4: Manufacturer: Linux 3.13.0-rc7-bjd1-00072-g3785df4-dirty ohci_hcd
> usb usb4: SerialNumber: 0000:01:01.0
> hub 4-0:1.0: USB hub found
> ohci-pci 0000:01:01.0: read 0f000201 from 0048
> ohci-pci 0000:01:01.0: read 00000000 from 004c
> hub 4-0:1.0: 1 port detected
> ohci-pci 0000:01:01.0: read 00008000 from 0050
> ohci-pci 0000:01:01.0: write 00000100 to 0054
> ohci-pci 0000:01:01.0: read 00008000 from 0050
> ohci-pci 0000:01:01.0: write 00000040 to 000c
> ohci-pci 0000:01:01.0: read 00000004 from 000c
> ohci-pci 0000:01:01.0: read 00000100 from 0054
> ohci-pci 0000:01:01.0: read 8000005a from 0010
> ohci-pci 0000:02:01.0: enabling bus mastering
> ohci-pci 0000:02:01.0: OHCI PCI host controller
> ohci-pci 0000:02:01.0: new USB bus registered, assigned bus number 5
> ohci-pci 0000:02:01.0: read 00000000 from 0004
> ohci-pci 0000:02:01.0: write 80000000 to 0014
> ohci-pci 0000:02:01.0: read 00000000 from 0004
> ohci-pci 0000:02:01.0: read 0f000901 from 0048
> ohci-pci 0000:02:01.0: irq 145, io mem 0xee0c0000
> ohci-pci 0000:02:01.0: read 00002edf from 0034
> ohci-pci 0000:02:01.0: write 00000200 to 0004
> ohci-pci 0000:02:01.0: read 00000200 from 0004
> ohci-pci 0000:01:01.0: read 00000100 from 0054
> ohci-pci 0000:01:01.0: read 00000283 from 0004
> ohci-pci 0000:01:01.0: write 000006c3 to 0004
> ohci-pci 0000:01:01.0: read 000006c3 from 0004
> ohci-pci 0000:01:01.0: read 00008000 from 0050
> ohci-pci 0000:02:01.0: write 00000001 to 0008
> ohci-pci 0000:02:01.0: read 00000000 from 0008
> ohci-pci 0000:02:01.0: write 00000000 to 0020
> ohci-pci 0000:02:01.0: write 00000000 to 0028
> ohci-pci 0000:02:01.0: write 6d804000 to 0018
> ohci-pci 0000:02:01.0: read 00002edf from 0034
> ohci-pci 0000:02:01.0: write a7782edf to 0034
> ohci-pci 0000:02:01.0: write 00002a2f to 0040
> ohci-pci 0000:02:01.0: read a7782edf from 0034
> ohci-pci 0000:02:01.0: read 00002a2f from 0040
> ohci-pci 0000:02:01.0: write 00000283 to 0004
> ohci-pci 0000:02:01.0: write 00008000 to 0050
> ohci-pci 0000:02:01.0: write ffffffff to 000c
> ohci-pci 0000:02:01.0: write 8000005a to 0010
> ohci-pci 0000:02:01.0: read 0f000901 from 0048
> ohci-pci 0000:02:01.0: write 0f000201 to 0048
> ohci-pci 0000:02:01.0: write 00010000 to 0050
> ohci-pci 0000:02:01.0: write 00000000 to 004c
> ohci-pci 0000:02:01.0: read 00000283 from 0004
> usb usb5: New USB device found, idVendor6b, idProduct 01
> usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb5: Product: OHCI PCI host controller
> usb usb5: Manufacturer: Linux 3.13.0-rc7-bjd1-00072-g3785df4-dirty ohci_hcd
> usb usb5: SerialNumber: 0000:02:01.0
> hub 5-0:1.0: USB hub found
> ohci-pci 0000:02:01.0: read 0f000201 from 0048
> ohci-pci 0000:02:01.0: read 00000000 from 004c
> hub 5-0:1.0: 1 port detected
> ohci-pci 0000:02:01.0: read 00008000 from 0050
> ohci-pci 0000:02:01.0: write 00000100 to 0054
> ohci-pci 0000:02:01.0: read 00008000 from 0050
> ohci-pci 0000:02:01.0: write 00000040 to 000c
> ohci-pci 0000:02:01.0: read 00000004 from 000c
> ohci-pci 0000:02:01.0: read 00000100 from 0054
> ohci-pci 0000:02:01.0: read 8000005a from 0010
> ohci-platform: OHCI generic platform driver
> usbcore: registered new interface driver cdc_acm
> cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
> usbcore: registered new interface driver usb-storage
> usbcore: registered new interface driver usbserial
> usbcore: registered new interface driver usbserial_generic
> usbserial: USB Serial support registered for generic
> mousedev: PS/2 mouse device common for all mice
> i2c /dev entries driver
> rcar_thermal e61f0000.thermal: 1 sensor probed
> sh_mmcif ee220000.mmc: dummy supplies not allowed
> of_dma_request_slave_channel: dma-names property of node '/mmc@ee220000' missing or empty
> sh_mmcif ee220000.mmc: driver version 2010-04-28
> mmc0: BKOPS_EN bit is not set
> mmc0: new high speed MMC card at address 0001
> ohci-pci 0000:02:01.0: read 00000100 from 0054
> ohci-pci 0000:01:01.0: write 00000040 to 000c
> ohci-pci 0000:01:01.0: read 00000004 from 000c
> ohci-pci 0000:01:01.0: read 00000100 from 0054
> ohci-pci 0000:01:01.0: read 8000005a from 0010
> ohci-pci 0000:02:01.0: read 00000283 from 0004
> ohci-pci 0000:02:01.0: write 000006c3 to 0004
> ohci-pci 0000:02:01.0: read 000006c3 from 0004
> ohci-pci 0000:02:01.0: read 00008000 from 0050
> isa bounce pool size: 16 pages
> mmcblk0: mmc0:0001 MMC08G 7.32 GiB
> mmcblk0boot0: mmc0:0001 MMC08G partition 1 2.00 MiB
> mmcblk0boot1: mmc0:0001 MMC08G partition 2 2.00 MiB
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
>  mmcblk0: unknown partition table
>  mmcblk0boot1: unknown partition table
>  mmcblk0boot0: unknown partition table
> ohci-pci 0000:02:01.0: write 00000040 to 000c
> ohci-pci 0000:02:01.0: read 00000004 from 000c
> ohci-pci 0000:02:01.0: read 00000100 from 0054
> ohci-pci 0000:02:01.0: read 8000005a from 0010
> TCP: cubic registered
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> Key type dns_resolver registered
> /home/ben/ct178/renesas/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> lager_ksz8041_fixup: called for phy ed2ab400 (drv c0562fac)
> lager_ksz8041_fixup: phy id 0022,1537
> net eth0: attached phy 1 to driver Generic PHY
> Sending DHCP requests .




-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
