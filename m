From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Tue, 10 Mar 2015 01:53:45 +0000
Subject: Re: Can't boot kernel v4.0-rc2 on Koelsch
Message-Id: <54FE4EA9.3070901@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <2263226.JPOqZgiCRj@avalon>
In-Reply-To: <2263226.JPOqZgiCRj@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Simon-san,
Cc: Laurent-san,

Thank for your comments,

On 2015年03月10日 10:14, Simon Horman wrote:
> Hi Hiep-san,
>
> I'd like to agree with Laurent's observation that this appears
> to mean that your userspace is broken / needs updating. The boards
> in question boot to userspace in my environment.
Thanks, I will re-check and update my userspace.
By the way, could you please tell me your type of userspace and version 
that you are using?

Thank you.
Jinso/Hiep
> On Mon, Mar 09, 2015 at 06:43:54PM +0900, Cao Minh Hiep wrote:
>> Hi Laurent-san,
>> Thanks for your comment,
>>
>> On 2015年03月09日 16:06, Laurent Pinchart wrote:
>>> Hello Hiep-san,
>>>
>>> On Monday 09 March 2015 10:07:04 Cao Minh Hiep wrote:
>>>> Hi Laurent-san
>>>>
>>>> I am Hiep from Jinzai Solution.
>>>> I'm sorry to bother you again!
>>> No worries.
>>>
>>>> We are testing the linux ver v4.0-rc2 on Koelsch, We can not boot the
>>>> kernel v4.0-rc2 on Koelsch,
>>>> Then we found a patch has changed as below:
>>>> "1f75cda ARM: shmobile: koelsch: Rename SCIF[01] serial ports to ttySC[01]"
>>>>
>>>> Please see it when you have time!
>>> Could you please detail your boot failure ? You might need to change your
>>> /etc/inittab to adjust to the serial port new name, but apart from that there
>>> shouldn't be any issue. I can boot my Koelsch board on 4.0-v2.
>> Sure, I use the rootfs of Linaro-nano 2014.09 to test v4.0-rc2.
>> When booting kernel with default config, bootlogs showed until these
>> messages appearing.
>> "init: auto-serial-console main process ended, respawning
>> init: auto-serial-console main process ended, respawning
>> init: auto-serial-console main process ended, respawning
>> init: tty1 main process (1449) killed by TERM signal
>> init: auto-serial-console respawning too fast, stopped"
>>
>> Then, my Koelsch board stoped here.(my Lager board is the same)
>> (I attached the bootlogs_file)
>>
>> So, When I tried to add "console=ttySC0," into bootargs (at .dts file), i
>> can boot my Koelsch board without any problems.
>> And these are the same on Lager board.
>>
>> Thank you!
>> Jinso/Hiep
>> ====>> information:
>> Actually, on v4.0-rc2, we have two patches related each other as below:
>> 79e69d1 ARM: shmobile: koelsch dts:Drop console= bootargs parameter BAD.
>> 1f75cda ARM: shmobile: koelsch: Rename SCIF01 serial ports to ttySC01
>>
>> And for Lager:
>> 569dd56 ARM: shmobile: lager dts: Drop console= bootargs parameter
>> 78c11ec ARM: shmobile: lager: Rename SCIFA[01] serial ports to ttySC[01]
>>
>> There is only 79e69d1 patch on v3.19-rcX, I also had a problem with bootting
>> Koelsch on v3.19-rcX
>> (using linaro-nano 2014.09). But it was good on Yocto and
>> linaro-nano-2013.02
>>
>>
>>
>>
>>
>> => bootp;bootm
>> sh_eth Waiting for PHY auto negotiation to complete.. done
>> sh_eth: 100Base/Full
>> BOOTP broadcast 1
>> DHCP client bound to address 172.16.1.36
>> Using sh_eth device
>> TFTP from server 172.16.1.9; our IP address is 172.16.1.36
>> Filename 'Koelsch/uImage.dtb'.
>> Load address: 0x40007fc0
>> Loading: #######################������������������������������������������������������������������������������������0
>> Linux version 4.0.0-rc2 (jinso02@jinso02) (gcc version 4.9.2 20140904 (prerelease) (crosstool-NG linaro-1.13.1-4.9-25
>> CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), crc5307d
>> CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
>> Machine model: Koelsch
>> Ignoring memory block 0x200000000 - 0x240000000
>> debug: ignoring loglevel setting.
>> Memory policy: Data cache writealloc
>> On node 0 totalpages: 262144
>> free_area_init_node: node 0, pgdat c063fe00, node_mem_map eeff9000
>>    Normal zone: 1520 pages used for memmap
>>    Normal zone: 0 pages reserved
>>    Normal zone: 194560 pages, LIFO batch:31
>>    HighMem zone: 67584 pages, LIFO batch:15
>> PERCPU: Embedded 8 pages/cpu @eefca000 s11456 r0 d21312 u32768
>> pcpu-alloc: s11456 r0 d21312 u32768 alloc=8*4096
>> pcpu-alloc: [0] 0 [0] 1
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
>> Kernel command line: ignore_loglevel rw root=/dev/nfs ip=dhcp
>> PID hash table entries: 4096 (order: 2, 16384 bytes)
>> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
>> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
>> Memory: 1032772K/1048576K available (4636K kernel code, 205K rwdata, 1252K rodata, 272K init, 192K bss, 15804K reser)
>> Virtual kernel memory layout:
>>      vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>      fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>>      vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
>>      lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
>>      pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>>        .text : 0xc0008000 - 0xc05c9044   (5893 kB)
>>        .init : 0xc05ca000 - 0xc060e000   ( 272 kB)
>>        .data : 0xc060e000 - 0xc0641720   ( 206 kB)
>>         .bss : 0xc0641720 - 0xc06717ec   ( 193 kB)
>> Hierarchical RCU implementation.
>>          Additional per-CPU info printed with stalls.
>>          RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
>> RCU: Adjusting geometry for rcu_fanout_leaf, nr_cpu_ids=2
>> NR_IRQS:16 nr_irqs:16 16
>> Architected cp15 timer(s) running at 10.00MHz (virt).
>> sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 3435973836800ns
>> Switching to timer-based delay loop, resolution 100ns
>> Console: colour dummy device 80x30
>> console [tty0] enabled
>> Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj0000)
>> pid_max: default: 32768 minimum: 301
>> Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
>> Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
>> CPU: Testing write buffer coherency: ok
>> CPU0: update cpu_capacity 1024
>> CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>> Setting up static identity map for 0x4048dba0 - 0x4048dbf8
>> Unable to boot CPU1 when MD21 is set
>> CPU1: failed to boot: -524
>> Brought up 1 CPUs
>> SMP: Total of 1 processors activated (20.00 BogoMIPS).
>> CPU: All CPU(s) started in SVC mode.
>> devtmpfs: initialized
>> VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
>> pinctrl core: initialized pinctrl subsystem
>> NET: Registered protocol family 16
>> DMA: preallocated 256 KiB pool for atomic coherent allocations
>> renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
>> sh-pfc e6060000.pfc: r8a77910_pfc support registered
>> No ATAGs?
>> hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
>> hw-breakpoint: maximum watchpoint size is 8 bytes.
>> platform regulator@0: Driver reg-fixed-voltage requests probe deferral
>> platform regulator@2: Driver reg-fixed-voltage requests probe deferral
>> platform regulator@4: Driver reg-fixed-voltage requests probe deferral
>> gpio-regulator regulator@1: Could not obtain regulator setting GPIOs: -517
>> platform regulator@1: Driver gpio-regulator requests probe deferral
>> gpio-regulator regulator@3: Could not obtain regulator setting GPIOs: -517
>> platform regulator@3: Driver gpio-regulator requests probe deferral
>> gpio-regulator regulator@5: Could not obtain regulator setting GPIOs: -517
>> platform regulator@5: Driver gpio-regulator requests probe deferral
>> vgaarb: loaded
>> SCSI subsystem initialized
>> libata version 3.00 loaded.
>> usbcore: registered new interface driver usbfs
>> usbcore: registered new interface driver hub
>> usbcore: registered new device driver usb
>> i2c-sh_mobile e60b0000.i2c: I2C adapter 6, bus speed 100000 Hz
>> media: Linux media interface: v0.10
>> Linux video capture interface: v2.00
>> sh_cmt ffca0000.timer: ch0: used for clock events
>> sh_cmt ffca0000.timer: ch1: used as clock source
>> Advanced Linux Sound Architecture Driver Initialized.
>> Switched to clocksource arch_sys_counter
>> NET: Registered protocol family 2
>> TCP established hash table entries: 8192 (order: 3, 32768 bytes)
>> TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
>> TCP: Hash tables configured (established 8192 bind 8192)
>> TCP: reno registered
>> UDP hash table entries: 512 (order: 2, 16384 bytes)
>> UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
>> NET: Registered protocol family 1
>> RPC: Registered named UNIX socket transport module.
>> RPC: Registered udp transport module.
>> RPC: Registered tcp transport module.
>> RPC: Registered tcp NFSv4.1 backchannel transport module.
>> PCI: CLS 0 bytes, default 64
>> futex hash table entries: 512 (order: 3, 32768 bytes)
>> NFS: Registering the id_resolver key type
>> Key type id_resolver registered
>> Key type id_legacy registered
>> nfs4filelayout_init: NFSv4 File Layout Driver Registering...
>> nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
>> bounce: pool size: 64 pages
>> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
>> io scheduler noop registered
>> io scheduler deadline registered
>> io scheduler cfq registered (default)
>> gpio_rcar e6050000.gpio: driving 32 GPIOs
>> gpio_rcar e6051000.gpio: driving 32 GPIOs
>> gpio_rcar e6052000.gpio: driving 32 GPIOs
>> gpio_rcar e6053000.gpio: driving 32 GPIOs
>> gpio_rcar e6054000.gpio: driving 32 GPIOs
>> gpio_rcar e6055000.gpio: driving 32 GPIOs
>> gpio_rcar e6055400.gpio: driving 32 GPIOs
>> gpio_rcar e6055800.gpio: driving 26 GPIOs
>> pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
>> pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>> pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
>> pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
>> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>> pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
>> pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
>> pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
>> pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
>> pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
>> pci 0000:00:01.0: supports D1 D2
>> pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
>> pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
>> pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
>> pci 0000:00:02.0: supports D1 D2
>> pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
>> PCI: bus0: Fast back to back transfers disabled
>> pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
>> pci 0000:00:01.0: can't enable device: BAR 0 [mem 0x00000000-0x00000fff] not claimed
>> pci 0000:00:01.0: Can't enable PCI device, BIOS handoff failed.
>> pci 0000:00:02.0: can't enable device: BAR 0 [mem 0x00000000-0x000000ff] not claimed
>> pci 0000:00:02.0: Can't enable PCI device, BIOS handoff failed.
>> pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
>> pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
>> pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
>> pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
>> pci_bus 0001:01: root bus resource [io  0xee0c0000-0xee0c10ff]
>> pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0c10ff]
>> pci_bus 0001:01: No busn resource found for root bus, will use [bus 01-ff]
>> pci 0001:01:00.0: [1033:0000] type 00 class 0x060000
>> pci 0001:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
>> pci 0001:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
>> pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310
>> pci 0001:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
>> pci 0001:01:01.0: supports D1 D2
>> pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
>> pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320
>> pci 0001:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
>> pci 0001:01:02.0: supports D1 D2
>> pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
>> PCI: bus1: Fast back to back transfers disabled
>> pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
>> pci 0001:01:01.0: can't enable device: BAR 0 [mem 0x00000000-0x00000fff] not claimed
>> pci 0001:01:01.0: Can't enable PCI device, BIOS handoff failed.
>> pci 0001:01:02.0: can't enable device: BAR 0 [mem 0x00000000-0x000000ff] not claimed
>> pci 0001:01:02.0: Can't enable PCI device, BIOS handoff failed.
>> pci 0001:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
>> pci 0001:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
>> rcar-pcie fe000000.pcie: PCIe link down
>> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>> SuperH (H)SCI(F) driver initialized
>> e6e60000.serial: ttySC0 at MMIO 0xe6e60000 (irq = 107, base_baud = 0) is a scif
>> console [ttySC0] enabled
>> e6e68000.serial: ttySC1 at MMIO 0xe6e68000 (irq = 108, base_baud = 0) is a scif
>> [drm] Initialized drm 1.1.0 20060810
>> rcar-du feb00000.display: error: no encoder could be initialized
>> rcar-du feb00000.display: failed to initialize DRM/KMS
>> rcar-du: probe of feb00000.display failed with error -22
>> scsi host0: sata_rcar
>> ata1: SATA max UDMA/133 irq 110
>> renesas_spi e6b10000.spi: DMA available
>> m25p80 spi0.0: s25fl512s (65536 Kbytes)
>> 3 ofpart partitions found on MTD device spi0.0
>> Creating 3 MTD partitions on "spi0.0":
>> 0x000000000000-0x000000080000 : "loader"
>> 0x000000080000-0x000000600000 : "user"
>> 0x000000600000-0x000004000000 : "flash"
>> renesas_spi e6b10000.spi: probed
>> spi_sh_msiof e6e20000.spi: DMA available
>> libphy: sh_mii: probed
>> sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2e:09:0a:00:75:df, IRQ 109.
>> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> ehci-pci: EHCI PCI platform driver
>> ehci-pci 0000:00:02.0: enabling device (0140 -> 0142)
>> ehci-pci 0000:00:02.0: EHCI Host Controller
>> ehci-pci 0000:00:02.0: new USB bus registered, assigned bus number 1
>> ehci-pci 0000:00:02.0: irq 120, io mem 0xee081000
>> ehci-pci 0000:00:02.0: USB 2.0 started, EHCI 1.00
>> hub 1-0:1.0: USB hub found
>> hub 1-0:1.0: 1 port detected
>> ehci-pci 0001:01:02.0: enabling device (0140 -> 0142)
>> ehci-pci 0001:01:02.0: EHCI Host Controller
>> ehci-pci 0001:01:02.0: new USB bus registered, assigned bus number 2
>> ehci-pci 0001:01:02.0: irq 121, io mem 0xee0c1000
>> ehci-pci 0001:01:02.0: USB 2.0 started, EHCI 1.00
>> hub 2-0:1.0: USB hub found
>> hub 2-0:1.0: 1 port detected
>> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
>> ohci-pci: OHCI PCI platform driver
>> ohci-pci 0000:00:01.0: enabling device (0140 -> 0142)
>> ohci-pci 0000:00:01.0: OHCI PCI host controller
>> ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 3
>> ohci-pci 0000:00:01.0: irq 120, io mem 0xee080000
>> ohci-pci 0000:00:01.0: init err (00002edf 0000)
>> ohci-pci 0000:00:01.0: can't start
>> ohci-pci 0000:00:01.0: startup error -75
>> ohci-pci 0000:00:01.0: USB bus 3 deregistered
>> ohci-pci 0000:00:01.0: init 0000:00:01.0 fail, -75
>> ohci-pci: probe of 0000:00:01.0 failed with error -75
>> ohci-pci 0001:01:01.0: enabling device (0140 -> 0142)
>> ohci-pci 0001:01:01.0: OHCI PCI host controller
>> ohci-pci 0001:01:01.0: new USB bus registered, assigned bus number 3
>> ohci-pci 0001:01:01.0: irq 121, io mem 0xee0c0000
>> hub 3-0:1.0: USB hub found
>> hub 3-0:1.0: 1 port detected
>> sh-pfc e6060000.pfc: pin GP_7_23 already requested by ee090000.pci; cannot claim for e6590000.usb
>> sh-pfc e6060000.pfc: pin-247 (e6590000.usb) status -22
>> sh-pfc e6060000.pfc: could not request pin 247 (GP_7_23) from group usb0  on device sh-pfc
>> renesas_usbhs e6590000.usb: Error applying setting, reverse things back
>> renesas_usbhs e6590000.usb: gadget probed
>> renesas_usbhs e6590000.usb: platform init failed.
>> renesas_usbhs e6590000.usb: probe failed
>> mousedev: PS/2 mouse device common for all mice
>> i2c /dev entries driver
>> at24 2-0050: 256 byte 24c02 EEPROM, writable, 16 bytes/write
>> i2c-rcar e6530000.i2c: probed
>> adv7180 2-0020: chip found @ 0x20 (e6530000.i2c)
>> ata1: link resume succeeded after 1 retries
>> soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at drivers/base/devres.c:887 devm_kfree+0x30/0x40()
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc2 #33
>> Hardware name: Generic R8A7791 (Flattened Device Tree)
>> Backtrace:
>> [<c0011e94>] (dump_backtrace) from [<c001203c>] (show_stack+0x18/0x1c)
>>   r7:c058aadd r6:ee82f9c0 r5:00000009 r4:00000000
>> [<c0012024>] (show_stack) from [<c0489724>] (dump_stack+0x78/0x94)
>> [<c04896ac>] (dump_stack) from [<c0025210>] (warn_slowpath_common+0x88/0xb4)
>>   r5:00000009 r4:00000000
>> [<c0025188>] (warn_slowpath_common) from [<c0025314>] (warn_slowpath_null+0x24/0x2c)
>>   r9:eeb0daa8 r8:eefe0398 r7:eeaaf810 r6:eeaafc20 r5:fffffffa r4:eeb0da90
>> [<c00252f0>] (warn_slowpath_null) from [<c025a078>] (devm_kfree+0x30/0x40)
>> [<c025a048>] (devm_kfree) from [<c03270f0>] (soc_of_bind.isra.14+0x194/0x1d4)
>> [<c0326f5c>] (soc_of_bind.isra.14) from [<c0327bb0>] (soc_camera_host_register+0x208/0x31c)
>>   r9:00000070 r8:eefe7384 r7:ee960210 r6:00000000 r5:eefe7000 r4:eeaafc20
>> [<c03279a8>] (soc_camera_host_register) from [<c0329d1c>] (rcar_vin_probe+0x1f8/0x23c)
>>   r9:00000070 r8:ee960200 r7:00000008 r6:ee960210 r5:eeaafc10 r4:c0635470
>> [<c0329b24>] (rcar_vin_probe) from [<c0258314>] (platform_drv_probe+0x50/0xa0)
>>   r10:00000000 r9:c063527c r8:00000000 r7:c0664e40 r6:c063527c r5:ee960210
>>   r4:ffffffef
>> [<c02582c4>] (platform_drv_probe) from [<c0256e98>] (driver_probe_device+0xc4/0x208)
>>   r7:c0664e40 r6:c0664e34 r5:00000000 r4:ee960210
>> [<c0256dd4>] (driver_probe_device) from [<c0257098>] (__driver_attach+0x70/0x94)
>>   r9:c0641740 r8:00000000 r7:c062db60 r6:c063527c r5:ee960244 r4:ee960210
>> [<c0257028>] (__driver_attach) from [<c02557e0>] (bus_for_each_dev+0x74/0x98)
>>   r7:c062db60 r6:c0257028 r5:c063527c r4:00000000
>> [<c025576c>] (bus_for_each_dev) from [<c025716c>] (driver_attach+0x20/0x28)
>>   r6:eea25000 r5:00000000 r4:c063527c
>> [<c025714c>] (driver_attach) from [<c0255f9c>] (bus_add_driver+0xdc/0x1c4)
>> [<c0255ec0>] (bus_add_driver) from [<c0257880>] (driver_register+0xa4/0xe8)
>>   r7:c0600400 r6:c0600400 r5:c05e73a4 r4:c063527c
>> [<c02577dc>] (driver_register) from [<c0258c5c>] (__platform_driver_register+0x50/0x64)
>>   r5:c05e73a4 r4:ee0d9680
>> [<c0258c0c>] (__platform_driver_register) from [<c05e73bc>] (rcar_vin_driver_init+0x18/0x20)
>> [<c05e73a4>] (rcar_vin_driver_init) from [<c05cadec>] (do_one_initcall+0x10c/0x1bc)
>> [<c05cace0>] (do_one_initcall) from [<c05cafb4>] (kernel_init_freeable+0x118/0x1e0)
>>   r8:c0641740 r7:c0608f60 r6:c0600c2c r5:000000ad r4:00000006
>> [<c05cae9c>] (kernel_init_freeable) from [<c0487020>] (kernel_init+0x14/0xec)
>>   r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c048700c r4:c0641740
>> [<c048700c>] (kernel_init) from [<c000eba0>] (ret_from_fork+0x14/0x34)
>>   r5:c048700c r4:00000000
>> ---[ end trace f0b41a6645a18806 ]---
>> rcar_vin e6ef1000.video: group probe failed: -6
>> ata1: SATA link down (SStatus 0 SControl 300)
>> rcar_thermal e61f0000.thermal: 1 sensor probed
>> Driver 'mmcblk' needs updating - please use bus_type methods
>> sh_mobile_sdhi ee100000.sd: Got CD GPIO
>> sh_mobile_sdhi ee100000.sd: Got WP GPIO
>> platform ee100000.sd: Driver sh_mobile_sdhi requests probe deferral
>> sh_mobile_sdhi ee140000.sd: Got CD GPIO
>> sh_mobile_sdhi ee140000.sd: Got WP GPIO
>> platform ee140000.sd: Driver sh_mobile_sdhi requests probe deferral
>> sh_mobile_sdhi ee160000.sd: Got CD GPIO
>> platform ee160000.sd: Driver sh_mobile_sdhi requests probe deferral
>> usbcore: registered new interface driver usbhid
>> usbhid: USB HID core driver
>> platform sound: Driver asoc-simple-card requests probe deferral
>> rcar_sound ec500000.rcar_sound: can't get dma channel
>> rcar_sound ec500000.rcar_sound: src[2] (Gen2) failed
>> rcar_sound ec500000.rcar_sound: ssi[0] fallback to PIO mode
>> rcar_sound ec500000.rcar_sound: can't get dma channel
>> rcar_sound ec500000.rcar_sound: src[3] (Gen2) failed
>> rcar_sound ec500000.rcar_sound: ssi[1] fallback to PIO mode
>> rcar_sound ec500000.rcar_sound: probed
>> TCP: cubic registered
>> NET: Registered protocol family 10
>> sit: IPv6 over IPv4 tunneling driver
>> NET: Registered protocol family 17
>> Key type dns_resolver registered
>> Registering SWP/SWPB emulation handler
>> sh_mobile_sdhi ee100000.sd: Got CD GPIO
>> sh_mobile_sdhi ee100000.sd: Got WP GPIO
>> sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz
>> sh_mobile_sdhi ee140000.sd: Got CD GPIO
>> sh_mobile_sdhi ee140000.sd: Got WP GPIO
>> sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 clock rate 97 MHz
>> sh_mobile_sdhi ee160000.sd: Got CD GPIO
>> sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 97 MHz
>> asoc-simple-card sound: ak4642-hifi <-> ec500000.rcar_sound mapping ok
>> input: keyboard as /devices/platform/keyboard/input/input0
>> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
>> sh-eth ee700000.ethernet eth0: attached PHY 1 (IRQ 375) to driver Micrel KSZ8041RNLI
>> Sending DHCP requests ..
>> sh-eth ee700000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
>> ., OK
>> IP-Config: Got DHCP answer from 172.16.1.9, my address is 172.16.1.36
>> IP-Config: Complete:
>>       device=eth0, hwaddr.:09:0a:00:75:df, ipaddr2.16.1.36, mask%5.255.255.0, gw2.16.1.9
>>       host2.16.1.36, domain=, nis-domain=(none)
>>       bootserver2.16.1.9, rootserver2.16.1.9, rootpath>>       nameserver02.16.1.30, nameserver12.16.1.40, nameserver2=8.8.8.8
>> SDHI2 VccQ: disabling
>> SDHI1 VccQ: disabling
>> SDHI0 VccQ: disabling
>> SDHI2 Vcc: disabling
>> SDHI1 Vcc: disabling
>> SDHI0 Vcc: disabling
>> ALSA device list:
>>    #0: rsnd-dai.0-ak4642-hifi
>> VFS: Mounted root (nfs filesystem) on device 0:13.
>> devtmpfs: mounted
>> Freeing unused kernel memory: 272K (c05ca000 - c060e000)
>> Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory
>> random: init urandom read with 46 bits of entropy available
>> init: plymouth-upstart-bridge main process (790) terminated with status 1
>> init: plymouth-upstart-bridge main process ended, respawning
>> init: plymouth-upstart-bridge main process (799) terminated with status 1
>> init: plymouth-upstart-bridge main process ended, respawning
>> random: nonblocking pool is initialized
>> systemd-udevd[888]: starting version 204
>> Unable to boot CPU1 when MD21 is set
>> CPU1: failed to boot: -524
>> init: udev-fallback-graphics main process (1404) terminated with status 1
>>   * Stopping Send an event to indicate plymouth is up[ OK ]
>>   * Starting Mount filesystems on boot[ OK ]
>>   * Starting Signal sysvinit that the rootfs is mounted[ OK ]
>>   * Starting Populate /dev filesystem[ OK ]
>>   * Stopping Populate /dev filesystem[ OK ]
>>   * Starting Clean /tmp directory[ OK ]
>>   * Stopping Clean /tmp directory[ OK ]
>>   * Starting Populate and link to /run filesystem[ OK ]
>>   * Stopping Populate and link to /run filesystem[ OK ]
>>   * Stopping Track if upstart is running in a container[ OK ]
>>   * Starting set console keymap[ OK ]
>>   * Starting Signal sysvinit that virtual filesystems are mounted[ OK ]
>>   * Starting Signal sysvinit that virtual filesystems are mounted[ OK ]
>>   * Starting Bridge udev events into upstart[ OK ]
>>   * Starting Signal sysvinit that local filesystems are mounted[ OK ]
>>   * Starting Signal sysvinit that remote filesystems are mounted[ OK ]
>>   * Starting device node and kernel event manager[ OK ]
>>   * Stopping set console keymap[ OK ]
>>   * Starting flush early job output to logs[ OK ]
>>   * Stopping Mount filesystems on boot[ OK ]
>>   * Stopping flush early job output to logs[ OK ]
>>   * Starting load modules from /etc/modules[ OK ]
>>   * Starting cold plug devices[ OK ]
>>   * Starting log initial device creation[ OK ]
>>   * Stopping load modules from /etc/modules[ OK ]
>>   * Starting system logging daemon[ OK ]
>>   * Stopping cold plug devices[ OK ]
>>   * Stopping log initial device creation[ OK ]
>>   * Starting load fallback graphics devices[ OK ]
>>   * Starting configure network device security[ OK ]
>>   * Starting load fallback graphics devices[fail]
>>   * Starting save udev log and update rules[ OK ]
>>   * Starting set console font[ OK ]
>>   * Stopping set console font[ OK ]
>>   * Starting userspace bootsplash[ OK ]
>>   * Starting configure network device security[ OK ]
>>   * Stopping userspace bootsplash[ OK ]
>>   * Starting Send an event to indicate plymouth is up[ OK ]
>>   * Starting configure network device[ OK ]
>>   * Stopping Send an event to indicate plymouth is up[ OK ]
>>   * Stopping save udev log and update rules[ OK ]
>>   * Starting System V initialisation compatibility[ OK ]
>>   * Starting configure virtual network devices[ OK ]
>>   * Starting configure network device security[ OK ]
>>   * Starting configure network device security[ OK ]
>>   * Stopping System V initialisation compatibility[ OK ]
>>   * Starting configure network device[ OK ]
>> init: alsa-restore main process (1546) terminated with status 99
>>   * Starting System V runlevel compatibility[ OK ]
>>   * Starting regular background program processing daemon[ OK ]
>>   * Starting save kernel messages[ OK ]
>>   * Stopping System V runlevel compatibility[ OK ]
>> init: auto-serial-console main process ended, respawning
>>   * Starting configure network device[ OK ]
>>   * Starting OpenSSH server[ OK ]
>> init: plymouth-upstart-bridge main process ended, respawning
>> init: auto-serial-console main process ended, respawning
>> init: auto-serial-console main process ended, respawning
>> init: auto-serial-console main process ended, respawning
>> init: auto-serial-console main process ended, respawning
>> init: auto-serial-console main process ended, respawning
>> init: auto-serial-console main process ended, respawning
>> init: tty1 main process (1592) killed by TERM signal
>> init: auto-serial-console main process ended, respawning
>> init: auto-serial-console main process ended, respawning
>> init: auto-serial-console main process ended, respawning
>> init: auto-serial-console respawning too fast, stopped
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

