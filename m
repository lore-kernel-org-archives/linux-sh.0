From: Simon Horman <horms@verge.net.au>
Date: Thu, 29 Jan 2015 12:19:09 +0000
Subject: Re: [PATCH 2/2] usb: renesas_usbhs: add support for requesting DT DMA
Message-Id: <20150129121909.GA11832@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <4F05318F.9060209@renesas.com>
In-Reply-To: <4F05318F.9060209@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Shimoda-san,

On Mon, Jan 19, 2015 at 12:53:17PM +0900, Yoshihiro Shimoda wrote:
> This patch adds dma_request_slave_channel_reason() calling to request
> dma slave channels for multiplatform environment.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../devicetree/bindings/usb/renesas_usbhs.txt      |    2 ++
>  drivers/usb/renesas_usbhs/fifo.c                   |   11 ++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)

I have observed what appears to be a regression caused by this
patch when booting a kernel built using shmobile_defconfig on the koelsch
and lager boards.

I noticed this problem while testing next-20150129.

I have provided boot logs at the end of this email.

> 
> diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> index b08c903..61b045b 100644
> --- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> +++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> @@ -14,6 +14,8 @@ Optional properties:
>  			 function should be enabled
>    - phys: phandle + phy specifier pair
>    - phy-names: must be "usb"
> +  - dmas: Must contain a list of references to DMA specifiers.
> +  - dma-names : Must contain a list of DMA names, "tx" or "rx".
>  
>  Example:
>  	usbhs: usb@e6590000 {
> diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
> index 48e31b9..4c086b1 100644
> --- a/drivers/usb/renesas_usbhs/fifo.c
> +++ b/drivers/usb/renesas_usbhs/fifo.c
> @@ -1069,12 +1069,21 @@ static void usbhsf_dma_init_pdev(struct usbhs_fifo *fifo)
>  					    &fifo->rx_slave);
>  }
>  
> +static void usbhsf_dma_init_dt(struct device *dev, struct usbhs_fifo *fifo)
> +{
> +	fifo->tx_chan = dma_request_slave_channel_reason(dev, "tx");
> +	fifo->rx_chan = dma_request_slave_channel_reason(dev, "rx");
> +}
> +
>  static void usbhsf_dma_init(struct usbhs_priv *priv,
>  			    struct usbhs_fifo *fifo)
>  {
>  	struct device *dev = usbhs_priv_to_dev(priv);
>  
> -	usbhsf_dma_init_pdev(fifo);
> +	if (dev->of_node)
> +		usbhsf_dma_init_dt(dev, fifo);
> +	else
> +		usbhsf_dma_init_pdev(fifo);
>  
>  	if (fifo->tx_chan || fifo->rx_chan)
>  		dev_dbg(dev, "enable DMAEngine (%s%s%s)\n",


Koelsch
-------

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 3.19.0-rc5-00129-gabd2dbf (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #959 SMP Thu Jan 29 20:40:07 JST 2015
CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), crc5307d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: Koelsch
Ignoring memory block 0x200000000 - 0x240000000
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c0612a80, node_mem_map eeff9000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 67584 pages, LIFO batch:15
PERCPU: Embedded 7 pages/cpu @eefca000 s7552 r0 d21120 u32768
pcpu-alloc: s7552 r0 d21120 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: ignore_loglevel rw root=/dev/nfs ip=dhcp
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032964K/1048576K available (4524K kernel code, 264K rwdata, 1128K rodata, 268K init, 191K bss, 15612K reserved, 0K cma-reserved, 270336K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc058e024   (5657 kB)
      .init : 0xc058f000 - 0xc05d2000   ( 268 kB)
      .data : 0xc05d2000 - 0xc06143a0   ( 265 kB)
       .bss : 0xc06143a0 - 0xc064407c   ( 192 kB)
Hierarchical RCU implementation.
        RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf, nr_cpu_ids=2
NR_IRQS:16 nr_irqs:16 16
Architected cp15 timer(s) running at 10.00MHz (virt).
sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 3435973836800ns
Switching to timer-based delay loop, resolution 100ns
Console: colour dummy device 80x30
console [tty0] enabled
Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj0000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: update cpu_capacity 1024
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x40471350 - 0x404713a8
Unable to boot CPU1 when MD21 is set
CPU1: failed to boot: -524
Brought up 1 CPUs
SMP: Total of 1 processors activated (20.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
sh-pfc e6060000.pfc: r8a77910_pfc support registered
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
platform regulator@0: Driver reg-fixed-voltage requests probe deferral
platform regulator@2: Driver reg-fixed-voltage requests probe deferral
platform regulator@4: Driver reg-fixed-voltage requests probe deferral
gpio-regulator regulator@1: Could not obtain regulator setting GPIOs: -517
platform regulator@1: Driver gpio-regulator requests probe deferral
gpio-regulator regulator@3: Could not obtain regulator setting GPIOs: -517
platform regulator@3: Driver gpio-regulator requests probe deferral
gpio-regulator regulator@5: Could not obtain regulator setting GPIOs: -517
platform regulator@5: Driver gpio-regulator requests probe deferral
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c-sh_mobile e60b0000.i2c: I2C adapter 6, bus speed 100000 Hz
media: Linux media interface: v0.10
Linux video capture interface: v2.00
sh_cmt ffca0000.timer: ch0: used for clock events
sh_cmt ffca0000.timer: ch1: used as clock source
Advanced Linux Sound Architecture Driver Initialized.
Switched to clocksource arch_sys_counter
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
futex hash table entries: 512 (order: 3, 32768 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
gpio_rcar e6050000.gpio: driving 32 GPIOs
gpio_rcar e6051000.gpio: driving 32 GPIOs
gpio_rcar e6052000.gpio: driving 32 GPIOs
gpio_rcar e6053000.gpio: driving 32 GPIOs
gpio_rcar e6054000.gpio: driving 32 GPIOs
gpio_rcar e6055000.gpio: driving 32 GPIOs
gpio_rcar e6055400.gpio: driving 32 GPIOs
gpio_rcar e6055800.gpio: driving 26 GPIOs
pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
pci 0000:00:01.0: supports D1 D2
pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
PCI: bus0: Fast back to back transfers disabled
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
pci 0000:00:01.0: can't enable device: BAR 0 [mem 0x00000000-0x00000fff] not claimed
pci 0000:00:01.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:00:02.0: can't enable device: BAR 0 [mem 0x00000000-0x000000ff] not claimed
pci 0000:00:02.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0000:01
pci_bus 0000:01: root bus resource [io  0xee0c0000-0xee0c10ff]
pci_bus 0000:01: root bus resource [mem 0xee0c0000-0xee0c10ff]
pci_bus 0000:01: No busn resource found for root bus, will use [bus 01-ff]
pci 0000:01:00.0: [1033:0000] type 00 class 0x060000
pci 0000:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
pci 0000:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
pci 0000:01:01.0: [1033:0035] type 00 class 0x0c0310
pci 0000:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
pci 0000:01:01.0: supports D1 D2
pci 0000:01:01.0: PME# supported from D0 D1 D2 D3hot
pci 0000:01:02.0: [1033:00e0] type 00 class 0x0c0320
pci 0000:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
pci 0000:01:02.0: supports D1 D2
pci 0000:01:02.0: PME# supported from D0 D1 D2 D3hot
PCI: bus1: Fast back to back transfers disabled
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:01:01.0: can't enable device: BAR 0 [mem 0x00000000-0x00000fff] not claimed
pci 0000:01:01.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:01:02.0: can't enable device: BAR 0 [mem 0x00000000-0x000000ff] not claimed
pci 0000:01:02.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
pci 0000:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
rcar-pcie fe000000.pcie: PCIe link down
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
SuperH (H)SCI(F) driver initialized
e6e60000.serial: ttySC6 at MMIO 0xe6e60000 (irq = 107, base_baud = 0) is a scif
console [ttySC6] enabled
e6e68000.serial: ttySC7 at MMIO 0xe6e68000 (irq = 108, base_baud = 0) is a scif
[drm] Initialized drm 1.1.0 20060810
rcar-du feb00000.display: Failed to initialize drm fb helper.
rcar-du feb00000.display: failed to initialize DRM/KMS
rcar-du: probe of feb00000.display failed with error -22
scsi host0: sata_rcar
ata1: SATA max UDMA/133 irq 110
renesas_spi e6b10000.spi: dma_request_slave_channel_compat failed
renesas_spi e6b10000.spi: DMA not available, using PIO
m25p80 spi0.0: s25fl512s (65536 Kbytes)
3 ofpart partitions found on MTD device spi0.0
Creating 3 MTD partitions on "spi0.0":
0x000000000000-0x000000080000 : "loader"
0x000000080000-0x000000100000 : "bootenv"
0x000000100000-0x000004000000 : "data"
renesas_spi e6b10000.spi: probed
spi_sh_msiof e6e20000.spi: dma_request_slave_channel_compat failed
spi_sh_msiof e6e20000.spi: DMA not available, using PIO
libphy: sh_mii: probed
sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2e:09:0a:00:6d:00, IRQ 109.
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:00:02.0: enabling device (0140 -> 0142)
ehci-pci 0000:00:02.0: EHCI Host Controller
ehci-pci 0000:00:02.0: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:02.0: irq 120, io mem 0xee081000
ehci-pci 0000:00:02.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ehci-pci 0000:01:02.0: enabling device (0140 -> 0142)
ehci-pci 0000:01:02.0: EHCI Host Controller
ehci-pci 0000:01:02.0: new USB bus registered, assigned bus number 2
ehci-pci 0000:01:02.0: irq 121, io mem 0xee0c1000
ehci-pci 0000:01:02.0: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-pci 0000:00:01.0: enabling device (0140 -> 0142)
ohci-pci 0000:00:01.0: OHCI PCI host controller
ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 3
ohci-pci 0000:00:01.0: irq 120, io mem 0xee080000
ohci-pci 0000:00:01.0: init err (00002edf 0000)
ohci-pci 0000:00:01.0: can't start
ohci-pci 0000:00:01.0: startup error -75
ohci-pci 0000:00:01.0: USB bus 3 deregistered
ohci-pci 0000:00:01.0: init 0000:00:01.0 fail, -75
ohci-pci: probe of 0000:00:01.0 failed with error -75
ohci-pci 0000:01:01.0: enabling device (0140 -> 0142)
ohci-pci 0000:01:01.0: OHCI PCI host controller
ohci-pci 0000:01:01.0: new USB bus registered, assigned bus number 3
ohci-pci 0000:01:01.0: irq 121, io mem 0xee0c0000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 1 port detected
sh-pfc e6060000.pfc: pin GP_7_23 already requested by ee090000.pci; cannot claim for e6590000.usb
sh-pfc e6060000.pfc: pin-247 (e6590000.usb) status -22
sh-pfc e6060000.pfc: could not request pin 247 (GP_7_23) from group usb0  on device sh-pfc
renesas_usbhs e6590000.usb: Error applying setting, reverse things back
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
renesas_usbhs e6590000.usb: gadget probed
renesas_usbhs e6590000.usb: platform init failed.
ata1: link resume succeeded after 1 retries
Unable to handle kernel NULL pointer dereference at virtual address 0000000d
pgd = c0004000
[0000000d] *pgd 000000
Internal error: Oops: 5 [#1] SMP ARM
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.19.0-rc5-00129-gabd2dbf #959
Hardware name: Generic R8A7791 (Flattened Device Tree)
task: ee84bb40 ti: ee84c000 task.ti: ee84c000
PC is at dma_release_channel+0x18/0xbc
LR is at dma_release_channel+0x18/0xbc
pc : [<c01e7fe8>]    lr : [<c01e7fe8>]    psr: 60000113
sp : ee84dd78  ip : ee84dd78  fp : ee84dd8c
r10: c058f5d4  r9 : c05ce67c  r8 : 00000024
r7 : ee303010  r6 : 00000000  r5 : ee303100  r4 : ffffffed
r3 : 00000003  r2 : ee84dd60  r1 : 0002e30a  r0 : c05f8e90
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5307d  Table: 4000406a  DAC: 00000015
Process swapper/0 (pid: 1, stack limit = 0xee84c238)
Stack: (0xee84dd78 to 0xee84e000)
dd60:                                                       00000000 ee303100
dd80: ee84ddb4 ee84dd90 c02d06c0 c01e7fdc 00000003 ee303010 ee949600 ffffffed
dda0: ee949610 00000000 ee84dde4 ee84ddb8 c02cd524 c02d069c ee949618 00000004
ddc0: ee949610 ffffffed ee949610 c0605bd0 c0605bd0 c05c4c78 ee84de04 ee84dde8
dde0: c024b54c c02cd1a8 c024b4fc ee949610 00000000 00000000 ee84de24 ee84de08
de00: c024a010 c024b508 ee949610 ee949644 c0605bd0 00000000 ee84de44 ee84de28
de20: c024a1c4 c0249f4c c024a15c c0605bd0 ee84de48 c024a15c ee84de6c ee84de48
de40: c024895c c024a168 ee82db5c ee8f3834 c0605bd0 eeb31a00 c0600d78 00000000
de60: ee84de7c ee84de70 c024a2e0 c024890c ee84dea4 ee84de80 c02490ec c024a2cc
de80: c056d039 ee84de90 c0605bd0 ee307300 00000000 c05c4c78 ee84debc ee84dea8
dea0: c024a9f0 c0249044 c05ab770 ee307300 ee84decc ee84dec0 c024bdb4 c024a958
dec0: ee84dedc ee84ded0 c05ab788 c024bd70 ee84df54 ee84dee0 c058fdc8 c05ab77c
dee0: 60000153 ef7fcce1 ee84df0c ee84def8 c058f500 c01a9c94 c058f5d4 c056e1da
df00: ee84df54 ee84df10 c003c47c c058f5e0 ef7fcce8 00000006 00000006 000000aa
df20: c058c0e8 00000000 ee84df54 00000006 00000006 c05c54d0 c05c54b0 c06143c0
df40: 000000aa c05ce67c ee84df94 ee84df58 c058ff84 c058fccc 00000006 00000006
df60: c058f5d4 78f7f1ef ffffffff 00000000 c0469290 00000000 00000000 00000000
df80: 00000000 00000000 ee84dfac ee84df98 c04692a0 c058fe84 ee84c000 00000000
dfa0: 00000000 ee84dfb0 c000ebf8 c046929c 00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 9d5cdd68 bead4f78
Backtrace: 
[<c01e7fd0>] (dma_release_channel) from [<c02d06c0>] (usbhs_fifo_remove+0x30/0x60)
 r5:ee303100 r4:00000000
[<c02d0690>] (usbhs_fifo_remove) from [<c02cd524>] (usbhs_probe+0x388/0x3f0)
 r8:00000000 r7:ee949610 r6:ffffffed r5:ee949600 r4:ee303010 r3:00000003
[<c02cd19c>] (usbhs_probe) from [<c024b54c>] (platform_drv_probe+0x50/0x98)
 r8:c05c4c78 r7:c0605bd0 r6:c0605bd0 r5:ee949610 r4:ffffffed
[<c024b4fc>] (platform_drv_probe) from [<c024a010>] (driver_probe_device+0xd0/0x21c)
 r6:00000000 r5:00000000 r4:ee949610 r3:c024b4fc
[<c0249f40>] (driver_probe_device) from [<c024a1c4>] (__driver_attach+0x68/0x8c)
 r7:00000000 r6:c0605bd0 r5:ee949644 r4:ee949610
[<c024a15c>] (__driver_attach) from [<c024895c>] (bus_for_each_dev+0x5c/0x94)
 r6:c024a15c r5:ee84de48 r4:c0605bd0 r3:c024a15c
[<c0248900>] (bus_for_each_dev) from [<c024a2e0>] (driver_attach+0x20/0x28)
 r7:00000000 r6:c0600d78 r5:eeb31a00 r4:c0605bd0
[<c024a2c0>] (driver_attach) from [<c02490ec>] (bus_add_driver+0xb4/0x1bc)
[<c0249038>] (bus_add_driver) from [<c024a9f0>] (driver_register+0xa4/0xe8)
 r7:c05c4c78 r6:00000000 r5:ee307300 r4:c0605bd0
[<c024a94c>] (driver_register) from [<c024bdb4>] (__platform_driver_register+0x50/0x64)
 r5:ee307300 r4:c05ab770
[<c024bd64>] (__platform_driver_register) from [<c05ab788>] (renesas_usbhs_driver_init+0x18/0x20)
[<c05ab770>] (renesas_usbhs_driver_init) from [<c058fdc8>] (do_one_initcall+0x108/0x1b8)
[<c058fcc0>] (do_one_initcall) from [<c058ff84>] (kernel_init_freeable+0x10c/0x1d8)
 r9:c05ce67c r8:000000aa r7:c06143c0 r6:c05c54b0 r5:c05c54d0 r4:00000006
[<c058fe78>] (kernel_init_freeable) from [<c04692a0>] (kernel_init+0x10/0xec)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0469290
 r4:00000000
[<c0469290>] (kernel_init) from [<c000ebf8>] (ret_from_fork+0x14/0x3c)
 r4:00000000 r3:ee84c000
Code: e24cb004 e1a04000 e59f0094 eb0a1caa (e5943020) 
---[ end trace c4f5636aa673cc02 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b


Lager
-----


Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 3.19.0-rc5-00129-gabd2dbf (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #961 SMP Thu Jan 29 20:46:17 JST 2015
CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), crc5307d
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
Machine model: Lager
Ignoring memory block 0x140000000 - 0x200000000
debug: ignoring loglevel setting.
Memory policy: Data cache writealloc
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c0612a80, node_mem_map eeff9000
  Normal zone: 1520 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 194560 pages, LIFO batch:31
  HighMem zone: 67584 pages, LIFO batch:15
PERCPU: Embedded 7 pages/cpu @eef9a000 s7552 r0 d21120 u32768
pcpu-alloc: s7552 r0 d21120 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260624
Kernel command line: console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032784K/1048576K available (4524K kernel code, 264K rwdata, 1128K rodata, 268K init, 191K bss, 15792K reserved, 0K cma-reserved, 270336K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc058e024   (5657 kB)
      .init : 0xc058f000 - 0xc05d2000   ( 268 kB)
      .data : 0xc05d2000 - 0xc06143a0   ( 265 kB)
       .bss : 0xc06143a0 - 0xc064407c   ( 192 kB)
Hierarchical RCU implementation.
NR_IRQS:16 nr_irqs:16 16
Architected cp15 timer(s) running at 10.00MHz (virt).
sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 3435973836800ns
Switching to timer-based delay loop, resolution 100ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj0000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
CPU: Testing write buffer coherency: ok
CPU0: update cpu_capacity 1535
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x40471350 - 0x404713a8
CPU1: update cpu_capacity 1535
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
CPU2: update cpu_capacity 1535
CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
CPU3: update cpu_capacity 1535
CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
CPU4: failed to boot: -22
CPU5: failed to boot: -22
CPU6: failed to boot: -22
CPU7: failed to boot: -22
Brought up 4 CPUs
SMP: Total of 4 processors activated (80.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_irqc e61c0000.interrupt-controller: driving 4 irqs
sh-pfc e6060000.pfc: r8a77900_pfc support registered
No ATAGs?
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
platform regulator@1: Driver reg-fixed-voltage requests probe deferral
platform regulator@3: Driver reg-fixed-voltage requests probe deferral
gpio-regulator regulator@2: Could not obtain regulator setting GPIOs: -517
platform regulator@2: Driver gpio-regulator requests probe deferral
gpio-regulator regulator@4: Could not obtain regulator setting GPIOs: -517
platform regulator@4: Driver gpio-regulator requests probe deferral
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c-sh_mobile e6500000.i2c: I2C adapter 4, bus speed 100000 Hz
i2c-sh_mobile e6510000.i2c: I2C adapter 5, bus speed 100000 Hz
i2c-sh_mobile e6520000.i2c: I2C adapter 6, bus speed 100000 Hz
i2c-sh_mobile e60b0000.i2c: I2C adapter 7, bus speed 100000 Hz
media: Linux media interface: v0.10
Linux video capture interface: v2.00
sh_cmt ffca0000.timer: ch0: used for clock events
sh_cmt ffca0000.timer: ch1: used as clock source
Advanced Linux Sound Architecture Driver Initialized.
Switched to clocksource arch_sys_counter
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP: reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
futex hash table entries: 2048 (order: 5, 131072 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
bounce: pool size: 64 pages
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
gpio_rcar e6050000.gpio: driving 32 GPIOs
gpio_rcar e6051000.gpio: driving 32 GPIOs
gpio_rcar e6052000.gpio: driving 32 GPIOs
gpio_rcar e6053000.gpio: driving 32 GPIOs
gpio_rcar e6054000.gpio: driving 32 GPIOs
gpio_rcar e6055000.gpio: driving 32 GPIOs
pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
pci 0000:00:01.0: supports D1 D2
pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
pci 0000:00:02.0: supports D1 D2
pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
PCI: bus0: Fast back to back transfers disabled
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
pci 0000:00:01.0: can't enable device: BAR 0 [mem 0x00000000-0x00000fff] not claimed
pci 0000:00:01.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:00:02.0: can't enable device: BAR 0 [mem 0x00000000-0x000000ff] not claimed
pci 0000:00:02.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
pci-rcar-gen2 ee0b0000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee0b0000.pci: PCI host bridge to bus 0000:01
pci_bus 0000:01: root bus resource [io  0xee0a0000-0xee0a10ff]
pci_bus 0000:01: root bus resource [mem 0xee0a0000-0xee0a10ff]
pci_bus 0000:01: No busn resource found for root bus, will use [bus 01-ff]
pci 0000:01:00.0: [1033:0000] type 00 class 0x060000
pci 0000:01:00.0: reg 0x10: [mem 0xee0b0800-0xee0b0bff]
pci 0000:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
pci 0000:01:01.0: [1033:0035] type 00 class 0x0c0310
pci 0000:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
pci 0000:01:01.0: supports D1 D2
pci 0000:01:01.0: PME# supported from D0 D1 D2 D3hot
pci 0000:01:02.0: [1033:00e0] type 00 class 0x0c0320
pci 0000:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
pci 0000:01:02.0: supports D1 D2
pci 0000:01:02.0: PME# supported from D0 D1 D2 D3hot
PCI: bus1: Fast back to back transfers disabled
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:01:01.0: can't enable device: BAR 0 [mem 0x00000000-0x00000fff] not claimed
pci 0000:01:01.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:01:02.0: can't enable device: BAR 0 [mem 0x00000000-0x000000ff] not claimed
pci 0000:01:02.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:01:01.0: BAR 0: assigned [mem 0xee0a0000-0xee0a0fff]
pci 0000:01:02.0: BAR 0: assigned [mem 0xee0a1000-0xee0a10ff]
pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0000:02
pci_bus 0000:02: root bus resource [io  0xee0c0000-0xee0c10ff]
pci_bus 0000:02: root bus resource [mem 0xee0c0000-0xee0c10ff]
pci_bus 0000:02: No busn resource found for root bus, will use [bus 02-ff]
pci 0000:02:00.0: [1033:0000] type 00 class 0x060000
pci 0000:02:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
pci 0000:02:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
pci 0000:02:01.0: [1033:0035] type 00 class 0x0c0310
pci 0000:02:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
pci 0000:02:01.0: supports D1 D2
pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot
pci 0000:02:02.0: [1033:00e0] type 00 class 0x0c0320
pci 0000:02:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
pci 0000:02:02.0: supports D1 D2
pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot
PCI: bus2: Fast back to back transfers disabled
pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
pci 0000:02:01.0: can't enable device: BAR 0 [mem 0x00000000-0x00000fff] not claimed
pci 0000:02:01.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:02:02.0: can't enable device: BAR 0 [mem 0x00000000-0x000000ff] not claimed
pci 0000:02:02.0: Can't enable PCI device, BIOS handoff failed.
pci 0000:02:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
pci 0000:02:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
SuperH (H)SCI(F) driver initialized
e6c40000.serial: ttySC6 at MMIO 0xe6c40000 (irq = 101, base_baud = 0) is a scifa
console [ttySC6] enabled
e6c50000.serial: ttySC7 at MMIO 0xe6c50000 (irq = 102, base_baud = 0) is a scifa
[drm] Initialized drm 1.1.0 20060810
rcar-du feb00000.display: fb0:  frame buffer device
rcar-du feb00000.display: registered panic notifier
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
[drm] Initialized rcar-du 1.0.0 20130110 on minor 0
scsi host0: sata_rcar
ata1: SATA max UDMA/133 irq 104
renesas_spi e6b10000.spi: dma_request_slave_channel_compat failed
renesas_spi e6b10000.spi: DMA not available, using PIO
m25p80 spi0.0: s25fl512s (65536 Kbytes)
3 ofpart partitions found on MTD device spi0.0
Creating 3 MTD partitions on "spi0.0":
0x000000000000-0x000000040000 : "loader"
0x000000040000-0x000000440000 : "user"
0x000000440000-0x000004000000 : "flash"
renesas_spi e6b10000.spi: probed
spi_sh_msiof e6e10000.spi: dma_request_slave_channel_compat failed
spi_sh_msiof e6e10000.spi: DMA not available, using PIO
libphy: sh_mii: probed
sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2e:09:0a:00:6e:71, IRQ 103.
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:00:02.0: enabling device (0140 -> 0142)
ehci-pci 0000:00:02.0: EHCI Host Controller
ehci-pci 0000:00:02.0: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:02.0: irq 117, io mem 0xee081000
ehci-pci 0000:00:02.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ehci-pci 0000:01:02.0: enabling device (0140 -> 0142)
ehci-pci 0000:01:02.0: EHCI Host Controller
ehci-pci 0000:01:02.0: new USB bus registered, assigned bus number 2
ehci-pci 0000:01:02.0: irq 118, io mem 0xee0a1000
ehci-pci 0000:01:02.0: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
ehci-pci 0000:02:02.0: enabling device (0140 -> 0142)
ehci-pci 0000:02:02.0: EHCI Host Controller
ehci-pci 0000:02:02.0: new USB bus registered, assigned bus number 3
ehci-pci 0000:02:02.0: irq 119, io mem 0xee0c1000
ehci-pci 0000:02:02.0: USB 2.0 started, EHCI 1.00
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 1 port detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-pci 0000:00:01.0: enabling device (0140 -> 0142)
ohci-pci 0000:00:01.0: OHCI PCI host controller
ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 4
ohci-pci 0000:00:01.0: irq 117, io mem 0xee080000
ohci-pci 0000:00:01.0: init err (00002edf 0000)
ohci-pci 0000:00:01.0: can't start
ohci-pci 0000:00:01.0: startup error -75
ohci-pci 0000:00:01.0: USB bus 4 deregistered
ohci-pci 0000:00:01.0: init 0000:00:01.0 fail, -75
ohci-pci: probe of 0000:00:01.0 failed with error -75
ohci-pci 0000:01:01.0: enabling device (0140 -> 0142)
ohci-pci 0000:01:01.0: OHCI PCI host controller
ohci-pci 0000:01:01.0: new USB bus registered, assigned bus number 4
ohci-pci 0000:01:01.0: irq 118, io mem 0xee0a0000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 1 port detected
ohci-pci 0000:02:01.0: enabling device (0140 -> 0142)
ata1: link resume succeeded after 1 retries
ohci-pci 0000:02:01.0: OHCI PCI host controller
ohci-pci 0000:02:01.0: new USB bus registered, assigned bus number 5
ohci-pci 0000:02:01.0: irq 119, io mem 0xee0c0000
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 1 port detected
sh-pfc e6060000.pfc: pin GP_5_19 already requested by ee090000.pci; cannot claim for e6590000.usb
ata1: SATA link down (SStatus 0 SControl 300)
sh-pfc e6060000.pfc: pin-179 (e6590000.usb) status -22
sh-pfc e6060000.pfc: could not request pin 179 (GP_5_19) from group usb0_ovc_vbus  on device sh-pfc
renesas_usbhs e6590000.usb: Error applying setting, reverse things back
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
of_dma_request_slave_channel: dma-names property of node '/usb@e6590000' missing or empty
renesas_usbhs e6590000.usb: gadget probed
renesas_usbhs e6590000.usb: platform init failed.
Unable to handle kernel NULL pointer dereference at virtual address 0000000d
pgd = c0004000
[0000000d] *pgd 000000
Internal error: Oops: 5 [#1] SMP ARM
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.19.0-rc5-00129-gabd2dbf #961
Hardware name: lager
task: ee84bb40 ti: ee84c000 task.ti: ee84c000
PC is at dma_release_channel+0x18/0xbc
LR is at dma_release_channel+0x18/0xbc
pc : [<c01e7fe8>]    lr : [<c01e7fe8>]    psr: 60000113
sp : ee84dd78  ip : ee84dd78  fp : ee84dd8c
r10: c058f5d4  r9 : c05ce67c  r8 : 00000024
r7 : edfec010  r6 : 00000000  r5 : edfec100  r4 : ffffffed
r3 : 00000003  r2 : ee84dd60  r1 : 0002dfe4  r0 : c05f8e90
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5307d  Table: 4000406a  DAC: 00000015
Process swapper/0 (pid: 1, stack limit = 0xee84c238)
Stack: (0xee84dd78 to 0xee84e000)
dd60:                                                       00000000 edfec100
dd80: ee84ddb4 ee84dd90 c02d06c0 c01e7fdc 00000003 edfec010 eea78e00 ffffffed
dda0: eea78e10 00000000 ee84dde4 ee84ddb8 c02cd524 c02d069c eea78e18 00000004
ddc0: eea78e10 ffffffed eea78e10 c0605bd0 c0605bd0 c05c4c78 ee84de04 ee84dde8
dde0: c024b54c c02cd1a8 c024b4fc eea78e10 00000000 00000000 ee84de24 ee84de08
de00: c024a010 c024b508 eea78e10 eea78e44 c0605bd0 00000000 ee84de44 ee84de28
de20: c024a1c4 c0249f4c c024a15c c0605bd0 ee84de48 c024a15c ee84de6c ee84de48
de40: c024895c c024a168 ee82d15c eea37f34 c0605bd0 ee153f00 c0600d78 00000000
de60: ee84de7c ee84de70 c024a2e0 c024890c ee84dea4 ee84de80 c02490ec c024a2cc
de80: c056d039 ee84de90 c0605bd0 edfe9240 00000000 c05c4c78 ee84debc ee84dea8
dea0: c024a9f0 c0249044 c05ab770 edfe9240 ee84decc ee84dec0 c024bdb4 c024a958
dec0: ee84dedc ee84ded0 c05ab788 c024bd70 ee84df54 ee84dee0 c058fdc8 c05ab77c
dee0: 60000113 ef7fccf7 ee84df0c ee84def8 c058f500 c01a9c94 c058f5d4 c056e1da
df00: ee84df54 ee84df10 c003c47c c058f5e0 ef7fccfe 00000006 00000006 000000aa
df20: c058c0e8 00000000 ee84df54 00000006 00000006 c05c54d0 c05c54b0 c06143c0
df40: 000000aa c05ce67c ee84df94 ee84df58 c058ff84 c058fccc 00000006 00000006
df60: c058f5d4 00041164 ffffffff 00000000 c0469290 00000000 00000000 00000000
df80: 00000000 00000000 ee84dfac ee84df98 c04692a0 c058fe84 ee84c000 00000000
dfa0: 00000000 ee84dfb0 c000ebf8 c046929c 00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 5303c810 7110f809
Backtrace: 
[<c01e7fd0>] (dma_release_channel) from [<c02d06c0>] (usbhs_fifo_remove+0x30/0x60)
 r5:edfec100 r4:00000000
[<c02d0690>] (usbhs_fifo_remove) from [<c02cd524>] (usbhs_probe+0x388/0x3f0)
 r8:00000000 r7:eea78e10 r6:ffffffed r5:eea78e00 r4:edfec010 r3:00000003
[<c02cd19c>] (usbhs_probe) from [<c024b54c>] (platform_drv_probe+0x50/0x98)
 r8:c05c4c78 r7:c0605bd0 r6:c0605bd0 r5:eea78e10 r4:ffffffed
[<c024b4fc>] (platform_drv_probe) from [<c024a010>] (driver_probe_device+0xd0/0x21c)
 r6:00000000 r5:00000000 r4:eea78e10 r3:c024b4fc
[<c0249f40>] (driver_probe_device) from [<c024a1c4>] (__driver_attach+0x68/0x8c)
 r7:00000000 r6:c0605bd0 r5:eea78e44 r4:eea78e10
[<c024a15c>] (__driver_attach) from [<c024895c>] (bus_for_each_dev+0x5c/0x94)
 r6:c024a15c r5:ee84de48 r4:c0605bd0 r3:c024a15c
[<c0248900>] (bus_for_each_dev) from [<c024a2e0>] (driver_attach+0x20/0x28)
 r7:00000000 r6:c0600d78 r5:ee153f00 r4:c0605bd0
[<c024a2c0>] (driver_attach) from [<c02490ec>] (bus_add_driver+0xb4/0x1bc)
[<c0249038>] (bus_add_driver) from [<c024a9f0>] (driver_register+0xa4/0xe8)
 r7:c05c4c78 r6:00000000 r5:edfe9240 r4:c0605bd0
[<c024a94c>] (driver_register) from [<c024bdb4>] (__platform_driver_register+0x50/0x64)
 r5:edfe9240 r4:c05ab770
[<c024bd64>] (__platform_driver_register) from [<c05ab788>] (renesas_usbhs_driver_init+0x18/0x20)
[<c05ab770>] (renesas_usbhs_driver_init) from [<c058fdc8>] (do_one_initcall+0x108/0x1b8)
[<c058fcc0>] (do_one_initcall) from [<c058ff84>] (kernel_init_freeable+0x10c/0x1d8)
 r9:c05ce67c r8:000000aa r7:c06143c0 r6:c05c54b0 r5:c05c54d0 r4:00000006
[<c058fe78>] (kernel_init_freeable) from [<c04692a0>] (kernel_init+0x10/0xec)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0469290
 r4:00000000
[<c0469290>] (kernel_init) from [<c000ebf8>] (ret_from_fork+0x14/0x3c)
 r4:00000000 r3:ee84c000
Code: e24cb004 e1a04000 e59f0094 eb0a1caa (e5943020)
---[ end trace 06a71daccda9eecb ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

CPU2: stopping
CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D        3.19.0-rc5-00129-gabd2dbf #961
Hardware name: lager
Backtrace:
[<c0011854>] (dump_backtrace) from [<c00119f4>] (show_stack+0x18/0x1c)
 r6:c05da90c r5:00000002 r4:00000000 r3:00200040
[<c00119dc>] (show_stack) from [<c046ca18>] (dump_stack+0x74/0x90)
[<c046c9a4>] (dump_stack) from [<c0014244>] (handle_IPI+0xcc/0x164)
 r4:c06147ac r3:c05e830c
[<c0014178>] (handle_IPI) from [<c00093a8>] (gic_handle_irq+0x5c/0x64)
 r5:ee86df78 r4:f0002000
[<c000934c>] (gic_handle_irq) from [<c00125c0>] (__irq_svc+0x40/0x54)
Exception stack(0xee86df78 to 0xee86dfc0)
df60:                                                       00000000 00000000
df80: ee86dfd0 c001d980 c06141f0 c05da4f0 c0474304 c06147d4 4000406a 413fc0f2
dfa0: 00000000 ee86dfcc ee86dfd0 ee86dfc0 c000f6d4 c000f6d8 60000113 ffffffff
 r6:ffffffff r5:60000113 r4:c000f6d8 r3:c000f6d4
[<c000f6a4>] (arch_cpu_idle) from [<c005186c>] (cpu_startup_entry+0xf4/0x170)
[<c0051778>] (cpu_startup_entry) from [<c0013efc>] (secondary_start_kernel+0x114/0x130)
[<c0013de8>] (secondary_start_kernel) from [<40009444>] (0x40009444)
 r4:6e85006a r3:c000942c
CPU0: stopping
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D        3.19.0-rc5-00129-gabd2dbf #961
Hardware name: lager
Backtrace:
[<c0011854>] (dump_backtrace) from [<c00119f4>] (show_stack+0x18/0x1c)
 r6:c05da90c r5:00000000 r4:00000000 r3:00200000
[<c00119dc>] (show_stack) from [<c046ca18>] (dump_stack+0x74/0x90)
[<c046c9a4>] (dump_stack) from [<c0014244>] (handle_IPI+0xcc/0x164)
 r4:c06147ac r3:c05e830c
[<c0014178>] (handle_IPI) from [<c00093a8>] (gic_handle_irq+0x5c/0x64)
 r5:c05d3f40 r4:f0002000
[<c000934c>] (gic_handle_irq) from [<c00125c0>] (__irq_svc+0x40/0x54)
Exception stack(0xc05d3f40 to 0xc05d3f88)
3f40: 00000000 00000000 c05d3f98 c001d980 c06141f0 c05da4f0 c0474304 c06143c0
3f60: c05c56a8 413fc0f2 ef7fcc80 c05d3f94 c05d3f98 c05d3f88 c000f6d4 c000f6d8
3f80: 60000113 ffffffff
 r6:ffffffff r5:60000113 r4:c000f6d8 r3:c000f6d4
[<c000f6a4>] (arch_cpu_idle) from [<c005186c>] (cpu_startup_entry+0xf4/0x170)
[<c0051778>] (cpu_startup_entry) from [<c0469278>] (rest_init+0x68/0x80)
[<c0469210>] (rest_init) from [<c058fc54>] (start_kernel+0x34c/0x3b8)
[<c058f908>] (start_kernel) from [<40008074>] (0x40008074)
 r10:00000000 r8:4000406a r7:c05de5cc r6:c05c56a4 r5:c05da47c r4:c0614754
CPU3: stopping
CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D        3.19.0-rc5-00129-gabd2dbf #961
Hardware name: lager
Backtrace:
[<c0011854>] (dump_backtrace) from [<c00119f4>] (show_stack+0x18/0x1c)
 r6:c05da90c r5:00000003 r4:00000000 r3:00200040
[<c00119dc>] (show_stack) from [<c046ca18>] (dump_stack+0x74/0x90)
[<c046c9a4>] (dump_stack) from [<c0014244>] (handle_IPI+0xcc/0x164)
 r4:c06147ac r3:c05e830c
[<c0014178>] (handle_IPI) from [<c00093a8>] (gic_handle_irq+0x5c/0x64)
 r5:ee86ff78 r4:f0002000
[<c000934c>] (gic_handle_irq) from [<c00125c0>] (__irq_svc+0x40/0x54)
Exception stack(0xee86ff78 to 0xee86ffc0)
ff60:                                                       00000000 00000000
ff80: ee86ffd0 c001d980 c06141f0 c05da4f0 c0474304 c06147d4 4000406a 413fc0f2
ffa0: 00000000 ee86ffcc ee86ffd0 ee86ffc0 c000f6d4 c000f6d8 60000113 ffffffff
 r6:ffffffff r5:60000113 r4:c000f6d8 r3:c000f6d4
[<c000f6a4>] (arch_cpu_idle) from [<c005186c>] (cpu_startup_entry+0xf4/0x170)
[<c0051778>] (cpu_startup_entry) from [<c0013efc>] (secondary_start_kernel+0x114/0x130)
[<c0013de8>] (secondary_start_kernel) from [<40009444>] (0x40009444)
 r4:6e85006a r3:c000942c
drm_kms_helper: panic occurred, switching back to text console
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

