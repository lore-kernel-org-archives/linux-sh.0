From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 16 Nov 2015 21:02:18 +0000
Subject: Re: [PATCH v2 05/10] i2c: rcar: refactor setup of a msg
Message-Id: <2420286.JI0i0lloO0@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1870641.U85dPdquRh"
List-Id: <linux-sh.vger.kernel.org>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de> <1447338715-9955-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1447338715-9955-6-git-send-email-wsa@the-dreams.de>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

This is a multi-part message in MIME format.

--nextPart1870641.U85dPdquRh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

Thank you for the patch.

Sorry for bringing bad news, but as with v1, this patch breaks ADV7511 
detection on my Koelsch board. Reverting it on top of the series fixes the 
problem.

You'll find the dmesg and trace logs with your debugging patch applied 
attached to this e-mail in two versions, one with the whole series applied (-
bad) and one with this patch additionally reverted on top of the series (-
good).

On Thursday 12 November 2015 15:31:50 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> We want to reuse this function later.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-rcar.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 0f2dc74ab8bcc1..4bd3099865b485 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -106,7 +106,8 @@ enum rcar_i2c_type {
>  struct rcar_i2c_priv {
>  	void __iomem *io;
>  	struct i2c_adapter adap;
> -	struct i2c_msg	*msg;
> +	struct i2c_msg *msg;
> +	int msgs_left;
>  	struct clk *clk;
> 
>  	wait_queue_head_t wait;
> @@ -255,6 +256,11 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv
> *priv) {
>  	int read = !!rcar_i2c_is_recv(priv);
> 
> +	priv->pos = 0;
> +	priv->flags = 0;
> +	if (priv->msgs_left == 1)
> +		rcar_i2c_flags_set(priv, ID_LAST_MSG);
> +
>  	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
>  	rcar_i2c_write(priv, ICMSR, 0);
>  	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
> @@ -499,11 +505,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter
> *adap, }
> 
>  		/* init each data */
> -		priv->msg	= &msgs[i];
> -		priv->pos	= 0;
> -		priv->flags	= 0;
> -		if (i == num - 1)
> -			rcar_i2c_flags_set(priv, ID_LAST_MSG);
> +		priv->msg = &msgs[i];
> +		priv->msgs_left = num - i;
> 
>  		rcar_i2c_prepare_msg(priv);

-- 
Regards,

Laurent Pinchart

--nextPart1870641.U85dPdquRh
Content-Disposition: attachment; filename="dmesg-good.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="dmesg-good.log"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.3.0-08388-ga27958726b59-dirty (laurent@avalon) (gcc version 4.7.3 20130205 (prerelease) (crosstool-NG linaro-1.13.1-4.7-2013.02-01-20130221 - Linaro GCC 2013.02) ) #299 SMP Mon Nov 16 22:58:34 EET 2015
[    0.000000] CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), cr=30c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine model: Koelsch
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] cma: Reserved 256 MiB at 0x0000000070000000
[    0.000000] cma: Reserved 64 MiB at 0x000000006c000000
[    0.000000] Forcing write-allocate cache policy for SMP
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 524288
[    0.000000] free_area_init_node: node 0, pgdat c0688fc0, node_mem_map e7fd8000
[    0.000000]   DMA zone: 1536 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 327680 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 12 pages/cpu @e7f90000 s17920 r8192 d23040 u49152
[    0.000000] pcpu-alloc: s17920 r8192 d23040 u49152 alloc=12*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: ignore_loglevel rw root=/dev/nfs ip=dhcp
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1742912K/2097152K available (4308K kernel code, 305K rwdata, 1676K rodata, 400K init, 2183K bss, 26560K reserved, 327680K cma-reserved, 1048576K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05e1034   (5989 kB)
[    0.000000]       .init : 0xc05e2000 - 0xc0646000   ( 400 kB)
[    0.000000]       .data : 0xc0646000 - 0xc0692794   ( 306 kB)
[    0.000000]        .bss : 0xc0695000 - 0xc08b6cdc   (2184 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] 
[    0.000000] **********************************************************
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **                                                      **
[    0.000000] ** trace_printk() being used. Allocating extra memory.  **
[    0.000000] **                                                      **
[    0.000000] ** This means that this is a DEBUG kernel and it is     **
[    0.000000] ** unsafe for production use.                           **
[    0.000000] **                                                      **
[    0.000000] ** If you see this message and you are not debugging    **
[    0.000000] ** the kernel, report this immediately to your vendor!  **
[    0.000000] **                                                      **
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **********************************************************
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Architected cp15 timer(s) running at 10.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
[    0.000004] sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 4398046511100ns
[    0.000013] Switching to timer-based delay loop, resolution 100ns
[    0.000577] Console: colour dummy device 80x30
[    0.001377] console [tty0] enabled
[    0.001401] Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=100000)
[    0.001437] pid_max: default: 32768 minimum: 301
[    0.001573] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001596] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002070] CPU: Testing write buffer coherency: ok
[    0.002115] ftrace: allocating 17235 entries in 51 pages
[    0.023425] CPU0: update cpu_capacity 1024
[    0.023452] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.023555] Setting up static identity map for 0x40009000 - 0x40009058
[    0.026516] CPU1: update cpu_capacity 1024
[    0.026522] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.026610] Brought up 2 CPUs
[    0.026655] SMP: Total of 2 processors activated (40.00 BogoMIPS).
[    0.026671] CPU: All CPU(s) started in SVC mode.
[    0.027096] devtmpfs: initialized
[    0.037829] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.038233] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.043748] pinctrl core: initialized pinctrl subsystem
[    0.044839] NET: Registered protocol family 16
[    0.045768] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.046491] i2c-core: driver [dummy] registered
[    0.073354] cpuidle: using governor ladder
[    0.103333] cpuidle: using governor menu
[    0.103456] ARMREG              : S R
[    0.103480] CRYPT_ENGINE        : S R
[    0.103498] DCU                 : S R
[    0.103513] DDM                 : S R
[    0.103533] ETHER               : S .
[    0.103550] GPIO0               : S R
[    0.103566] GPIO1               : S R
[    0.103581] GPIO2               : S R
[    0.103596] GPIO3               : S R
[    0.103611] GPIO4               : S R
[    0.103626] GPIO5               : S R
[    0.103642] GPIO6               : S R
[    0.103657] GPIO7               : S R
[    0.103677] H_UDI               : S R
[    0.103692] I2C0                : S R
[    0.103707] I2C1                : S R
[    0.103722] I2C2                : S R
[    0.103737] I2C3                : S R
[    0.103752] I2C4                : S R
[    0.103768] I2C5                : S R
[    0.103785] IICDVFS             : S R
[    0.103803] INTC_RT             : S R
[    0.103818] INTC_SYS            : S R
[    0.103833] IPMMU_SGX           : S R
[    0.103850] IRQC                : S R
[    0.103866] MFIS                : S R
[    0.103884] MSIOF0              : S R
[    0.103899] MSIOF1              : S R
[    0.103914] MSIOF2              : S R
[    0.103931] PUBLIC_BOOT_ROM     : S R
[    0.103947] QSPI                : S R
[    0.103963] REMOCON             : S R
[    0.103979] RTDMAC              : S R
[    0.103994] RWDT                : S R
[    0.104011] SCIF0               : S .
[    0.104031] SCIFA0              : S R
[    0.104046] SCIFA1              : S R
[    0.104061] SCIFA2              : S R
[    0.104078] SCIFB0              : S R
[    0.104093] SCIFB1              : S R
[    0.104108] SCIFB2              : S R
[    0.104139] SECURE_BOOT_ROM     : S R
[    0.104154] SECURE_UPTIME_CLOCK : S R
[    0.104183] SYS_DMAC0           : S R
[    0.104198] SYS_DMAC1           : S R
[    0.104214] TMU0                : S .
[    0.104240] Disabling MSTP clocks for the System Core
[    0.104255]   SMSTPCR0: *0xe6150130 |= 0x00640801
[    0.104270]   SMSTPCR1: *0xe6150134 |= 0x9b6c9b5a
[    0.104285]   SMSTPCR2: *0xe6150138 |= 0x100d21fc
[    0.104299]   SMSTPCR3: *0xe615013c |= 0xf08cdc10
[    0.104314]   SMSTPCR4: *0xe6150140 |= 0x80000044
[    0.104328]   SMSTPCR5: *0xe6150144 |= 0x44c00046
[    0.104343]   SMSTPCR6: *0xe615014c |= 0x059fe618
[    0.104358]   SMSTPCR7: *0xe6150990 |= 0x41c0fe85
[    0.104372]   SMSTPCR8: *0xe6150994 |= 0xffd79fff
[    0.104387]   SMSTPCR9: *0xe6150998 |= 0xfffeffe0
[    0.104402]   SMSTPCR10: *0xe615099c |= 0x000001c0
[    0.104416] Disabling MSTP clocks for the Realtime Core
[    0.104431]   RMSTPCR0: *0xe6150110 |= 0x00640801
[    0.104445]   RMSTPCR1: *0xe6150114 |= 0x9b6c9b5a
[    0.104460]   RMSTPCR2: *0xe6150118 |= 0x100d21fc
[    0.104474]   RMSTPCR3: *0xe615011c |= 0xf08cdc10
[    0.104488]   RMSTPCR4: *0xe6150120 |= 0x800001c4
[    0.104503]   RMSTPCR5: *0xe6150124 |= 0x44c00046
[    0.104517]   RMSTPCR6: *0xe615012c |= 0x05bfe618
[    0.104531]   RMSTPCR7: *0xe6150980 |= 0x41c0fe85
[    0.104546]   RMSTPCR8: *0xe6150984 |= 0xffd79fff
[    0.104560]   RMSTPCR9: *0xe6150988 |= 0xfffeffe0
[    0.104575]   RMSTPCR10: *0xe615098c |= 0x000001c0
[    0.104634] INTC_SYS            : S .
[    0.104651] IRQC                : S .
[    0.104683] SCIF0               : S .
[    0.107564] renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
[    0.110632] sh-pfc e6060000.pfc: r8a77910_pfc support registered
[    0.115763] No ATAGs?
[    0.115816] IRQ2 is asserted, installing da9063/da9210 regulator quirk
[    0.134288] i2c-core: driver [pcf857x] registered
[    0.135020] gpio-regulator regulator@1: Could not obtain regulator setting GPIOs: -517
[    0.135122] gpio-regulator regulator@3: Could not obtain regulator setting GPIOs: -517
[    0.135217] gpio-regulator regulator@5: Could not obtain regulator setting GPIOs: -517
[    0.135693] i2c-core: driver [as3711] registered
[    0.136004] usbcore: registered new interface driver usbfs
[    0.136079] usbcore: registered new interface driver hub
[    0.136149] usbcore: registered new device driver usb
[    0.136238] i2c-core: driver [tca6416-keypad] registered
[    0.136836] i2c i2c-6: adapter [e60b0000.i2c] registered
[    0.136886] i2c i2c-6: of_i2c: walking child nodes
[    0.136905] i2c i2c-6: of_i2c: register /i2c@e60b0000/pmic@58
[    0.136994] i2c 6-0058: Masking da9063 interrupt sources
[    0.137016] i2c i2c-6: master_xfer[0] W, addr=0x58, len=2
[    0.137443] i2c i2c-6: master_xfer[0] W, addr=0x58, len=2
[    0.137871] i2c i2c-6: master_xfer[0] W, addr=0x58, len=2
[    0.138295] i2c i2c-6: master_xfer[0] W, addr=0x58, len=2
[    0.138729] i2c 6-0058: uevent
[    0.138771] i2c i2c-6: client [da9063] registered with bus id 6-0058
[    0.138792] i2c i2c-6: of_i2c: register /i2c@e60b0000/regulator@68
[    0.138881] i2c 6-0068: Masking da9210 interrupt sources
[    0.138900] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.139326] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.139751] i2c 6-0068: IRQ2 is not asserted, removing quirk
[    0.139785] i2c 6-0068: uevent
[    0.139821] i2c i2c-6: client [da9210] registered with bus id 6-0068
[    0.139847] i2c-sh_mobile e60b0000.i2c: I2C adapter 6, bus speed 100000 Hz
[    0.140050] media: Linux media interface: v0.10
[    0.140124] Linux video capture interface: v2.00
[    0.140378] sh_cmt ffca0000.timer: ch0: used for clock events
[    0.140403] sh_cmt ffca0000.timer: ch1: used as clock source
[    0.140422] clocksource: ffca0000.timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000000 ns
[    0.141624] clocksource: Switched to clocksource arch_sys_counter
[    0.169670] NET: Registered protocol family 2
[    0.170108] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.170180] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.170292] TCP: Hash tables configured (established 8192 bind 8192)
[    0.170344] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.170379] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.170522] NET: Registered protocol family 1
[    0.170814] RPC: Registered named UNIX socket transport module.
[    0.170833] RPC: Registered udp transport module.
[    0.170847] RPC: Registered tcp transport module.
[    0.170861] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.170891] PCI: CLS 0 bytes, default 64
[    0.171902] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.173251] bounce: pool size: 64 pages
[    0.173279] io scheduler noop registered (default)
[    0.174049] gpio_rcar e6050000.gpio: driving 32 GPIOs
[    0.174471] gpio_rcar e6051000.gpio: driving 26 GPIOs
[    0.174900] gpio_rcar e6052000.gpio: driving 32 GPIOs
[    0.175325] gpio_rcar e6053000.gpio: driving 32 GPIOs
[    0.175758] gpio_rcar e6054000.gpio: driving 32 GPIOs
[    0.176183] gpio_rcar e6055000.gpio: driving 32 GPIOs
[    0.176611] gpio_rcar e6055400.gpio: driving 32 GPIOs
[    0.177005] gpio_rcar e6055800.gpio: driving 26 GPIOs
[    0.177504] pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
[    0.177699] pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
[    0.177722] pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
[    0.177740] pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
[    0.177759] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.177806] pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
[    0.177840] pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
[    0.177863] pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    0.178109] pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
[    0.178150] pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.178224] pci 0000:00:01.0: supports D1 D2
[    0.178240] pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
[    0.178486] pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
[    0.178527] pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    0.178602] pci 0000:00:02.0: supports D1 D2
[    0.178617] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
[    0.178871] PCI: bus0: Fast back to back transfers disabled
[    0.178892] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.178982] pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
[    0.179006] pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
[    0.179052] pci 0000:00:01.0: enabling device (0140 -> 0142)
[    0.179103] pci 0000:00:02.0: enabling device (0140 -> 0142)
[    0.179328] pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
[    0.179507] pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
[    0.179527] pci_bus 0001:01: root bus resource [io  0xee0c0000-0xee0c10ff]
[    0.179550] pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0c10ff]
[    0.179568] pci_bus 0001:01: No busn resource found for root bus, will use [bus 01-ff]
[    0.179611] pci 0001:01:00.0: [1033:0000] type 00 class 0x060000
[    0.179640] pci 0001:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
[    0.179662] pci 0001:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    0.179887] pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310
[    0.179926] pci 0001:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.180000] pci 0001:01:01.0: supports D1 D2
[    0.180017] pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
[    0.180258] pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320
[    0.180297] pci 0001:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    0.180371] pci 0001:01:02.0: supports D1 D2
[    0.180386] pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
[    0.180640] PCI: bus1: Fast back to back transfers disabled
[    0.180661] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[    0.180792] pci 0001:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
[    0.180815] pci 0001:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
[    0.180856] pci 0001:01:01.0: enabling device (0140 -> 0142)
[    0.180900] pci 0001:01:02.0: enabling device (0140 -> 0142)
[    0.181269] da9210 6-0068: probe
[    0.181377] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.181828] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.182340] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.182359] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.183039] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.183057] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.183639] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.183658] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.184238] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.184255] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.184832] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.184849] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.185424] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.185858] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.185875] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.186454] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.186472] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.187187] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.187206] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.187784] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.188247] i2c-core: driver [da9210] registered
[    0.188521] SuperH (H)SCI(F) driver initialized
[    0.188855] e6e60000.serial: ttySC0 at MMIO 0xe6e60000 (irq = 109, base_baud = 0) is a scif
[    1.747256] console [ttySC0] enabled
[    1.751551] e6e68000.serial: ttySC1 at MMIO 0xe6e68000 (irq = 110, base_baud = 0) is a scif
[    1.760744] [drm] Initialized drm 1.1.0 20060810
[    1.765983] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.772769] [drm] No driver support for vblank timestamp query.
[    1.779177] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[    1.786476] i2c-core: driver [adv7511] registered
[    1.792420] libphy: sh_mii: probed
[    1.797191] sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2e:09:0a:00:3d:cf, IRQ 111.
[    1.807129] i2c-core: driver [st1232-ts] registered
[    1.812202] i2c-core: driver [tsc2007] registered
[    1.817577] i2c i2c-2: adapter [e6530000.i2c] registered
[    1.823066] i2c i2c-2: of_i2c: walking child nodes
[    1.827966] i2c i2c-2: of_i2c: register /i2c@e6530000/codec@12
[    1.834023] i2c 2-0012: uevent
[    1.837179] i2c i2c-2: client [ak4643] registered with bus id 2-0012
[    1.843694] i2c i2c-2: of_i2c: register /i2c@e6530000/composite-in@20
[    1.850357] i2c 2-0020: uevent
[    1.853524] i2c i2c-2: client [adv7180] registered with bus id 2-0020
[    1.860108] i2c i2c-2: of_i2c: register /i2c@e6530000/hdmi@39
[    1.866077] i2c 2-0039: uevent
[    1.869271] adv7511 2-0039: probe
[    1.872853] i2c i2c-2: master_xfer[0] W, addr=0x39, len=1
[    1.878374] i2c i2c-2: master_xfer[1] R, addr=0x39, len=1
[    1.884353] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.890196] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.896058] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.901899] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.907738] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.913596] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.919434] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.925295] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.931132] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.936996] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.942857] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.948700] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.954559] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.960476] i2c 2-003f: uevent
[    1.963650] dummy 2-003f: probe
[    1.966871] i2c i2c-2: client [dummy] registered with bus id 2-003f
[    1.973402] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.979264] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.985128] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.990972] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    1.996831] i2c i2c-2: master_xfer[0] W, addr=0x39, len=2
[    2.002697] i2c i2c-2: client [adv7511w] registered with bus id 2-0039
[    2.009372] i2c i2c-2: of_i2c: register /i2c@e6530000/eeprom@50
[    2.015524] i2c 2-0050: uevent
[    2.018677] i2c i2c-2: client [24c02] registered with bus id 2-0050
[    2.025107] i2c-rcar e6530000.i2c: probed
[    2.041956] usbcore: registered new interface driver usbhid
[    2.047663] usbhid: USB HID core driver
[    2.051771] NET: Registered protocol family 17
[    2.056389] Registering SWP/SWPB emulation handler
[    2.062229] Common Chip Code Register = 0x00004700
[    2.067132] Detected Renesas R-Car M2-W ES1.0
[    2.071610] CPU cores: CA15 [ 0 1 - - ] CA7 [ - - - -]
[    2.078834] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.085629] [drm] No driver support for vblank timestamp query.
[    2.093185] [drm] Device feb00000.display probed
[    2.099514] input: keyboard as /devices/platform/keyboard/input/input0
[    2.106664] hctosys: unable to open rtc device (rtc0)
[    2.203436] sh-eth ee700000.ethernet eth0: attached PHY 1 (IRQ 373) to driver Micrel KSZ8041RNLI
[    2.231616] Sending DHCP requests ..
[    5.099160] sh-eth ee700000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
[    8.661601] ., OK
[    8.711609] IP-Config: Got DHCP answer from 192.168.1.47, my address is 192.168.1.254
[    8.719701] IP-Config: Complete:
[    8.723028]      device=eth0, hwaddr=2e:09:0a:00:3d:cf, ipaddr=192.168.1.254, mask=255.255.255.0, gw=255.255.255.255
[    8.733798]      host=192.168.1.254, domain=, nis-domain=(none)
[    8.739848]      bootserver=192.168.1.47, rootserver=192.168.1.47, rootpath=/home/laurent/src/iob/netboot/renesas
[    8.750167]      nameserver0=192.168.1.47
[    8.754501] SDHI0 Vcc: disabling
[    8.757803] SDHI1 Vcc: disabling
[    8.761103] SDHI2 Vcc: disabling
[    8.764418] SDHI0 VccQ: disabling
[    8.767808] SDHI1 VccQ: disabling
[    8.771196] SDHI2 VccQ: disabling
[    8.775098] sh-sci e6e60000.serial: dma_request_slave_channel_compat failed
[    8.782246] sh-sci e6e60000.serial: dma_request_slave_channel_compat failed
[    8.795251] VFS: Mounted root (nfs filesystem) on device 0:15.
[    8.801714] devtmpfs: mounted
[    8.804953] Freeing unused kernel memory: 400K (c05e2000 - c0646000)
[    9.208095] udevd[538]: starting version 1.9
[    9.241882] random: udevd urandom read with 39 bits of entropy available
[    9.260559] udevd[538]: specified group 'input' unknown
[    9.271382] i2c 6-0058: uevent
[    9.274833] da9210 6-0068: uevent
[    9.278610] i2c 2-0012: uevent
[    9.281990] i2c 2-0020: uevent
[    9.285260] adv7511 2-0039: uevent
[    9.288831] dummy 2-003f: uevent
[    9.292359] i2c 2-0050: uevent
[    9.336661] i2c 6-0058: uevent
[    9.339970] da9210 6-0068: uevent
[    9.340029] i2c 6-0058: uevent
[    9.340240] i2c 6-0058: uevent
[    9.351768] da9210 6-0068: uevent
[    9.358148] i2c 2-0012: uevent
[    9.358875] da9210 6-0068: uevent
[    9.365132] i2c 2-0012: uevent
[    9.365386] i2c 2-0020: uevent
[    9.365488] adv7511 2-0039: uevent
[    9.365606] dummy 2-003f: uevent
[    9.378642] adv7511 2-0039: uevent
[    9.382977] i2c 2-0050: uevent
[    9.383541] dummy 2-003f: uevent
[    9.383764] dummy 2-003f: uevent
[    9.386703] rcar_thermal e61f0000.thermal: 1 sensor probed
[    9.396590] i2c 2-0020: uevent
[    9.399773] adv7511 2-0039: uevent
[    9.405586] i2c 2-0050: uevent
[    9.423329] i2c 2-0050: uevent
[    9.450186] adv7180 2-0020: probe
[    9.453656] adv7180 2-0020: chip found @ 0x20 (e6530000.i2c)
[    9.459476] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.467058] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.474175] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.484340] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.491302] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.498717] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.505779] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.513220] soc_scale_crop: module license 'unspecified' taints kernel.
[    9.513237] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.513573] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.513922] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.514272] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.521688] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.523344] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.523682] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[    9.524013] i2c i2c-2: master_xfer[0] W, addr=0x20, len=1
[    9.524018] i2c i2c-2: master_xfer[1] R, addr=0x20, len=1
[    9.524637] i2c-core: driver [adv7180] registered
[    9.525532] adv7180 2-0020: uevent
[    9.578076] Disabling lock debugging due to kernel taint
[    9.605458] spi_sh_msiof e6e20000.spi: DMA available
[    9.628941] renesas_usbhs e6590000.usb: host probed
[    9.634017] renesas_usbhs e6590000.usb: transceiver found
[    9.639737] renesas_usbhs e6590000.usb: gadget probed
[    9.645725] renesas_usbhs e6590000.usb: probed
[    9.650278] sh-pfc e6060000.pfc: pin GP_7_23 already requested by ee090000.pci; cannot claim for e6590000.usb
[    9.660442] sh-pfc e6060000.pfc: pin-247 (e6590000.usb) status -22
[    9.666781] sh-pfc e6060000.pfc: could not request pin 247 (GP_7_23) from group usb0  on device sh-pfc
[    9.676311] renesas_usbhs e6590000.usb: Error applying setting, reverse things back
[    9.684153] renesas_usbhs e6590000.usb: failed to activate default pinctrl state
[    9.692595] renesas_spi e6b10000.spi: DMA available
[    9.700655] renesas_spi e6b10000.spi: probed
[    9.742478] soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
[    9.847595] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    9.852661] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    9.857535] ak4642-codec 2-0012: probe
[    9.857712] i2c-core: driver [ak4642-codec] registered
[    9.858061] ak4642-codec 2-0012: uevent
[    9.909001] SCSI subsystem initialized
[   10.015120] libata version 3.00 loaded.
[   10.046318] sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz
[   10.054567] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[   10.059603] sh_mobile_sdhi ee140000.sd: Got WP GPIO
[   10.137803] random: nonblocking pool is initialized
[   10.261134] sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 clock rate 48 MHz
[   10.269353] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[   10.455534] sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 48 MHz
[   10.468176] rcar_sound ec500000.sound: probed
[   10.475183] scsi host0: sata_rcar
[   10.478818] ata1: SATA max UDMA/133 irq 112
[   10.484472] rcar_jpu fe980000.jpeg-codec: encoder device registered as /dev/video26
[   10.492344] rcar_jpu fe980000.jpeg-codec: decoder device registered as /dev/video27
[   10.501340] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   10.506913] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   10.514125] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   10.519663] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   10.527370] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   10.532950] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   10.540516] i2c i2c-2: master_xfer[0] W, addr=0x12, len=2
[   10.547437] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   10.553001] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   10.560154] i2c i2c-2: master_xfer[0] W, addr=0x12, len=2
[   10.567089] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   10.572651] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   10.579375] i2c i2c-2: master_xfer[0] W, addr=0x12, len=2
[   10.586004] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   10.591541] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   10.598511] i2c i2c-2: master_xfer[0] W, addr=0x12, len=2
[   10.606193] asoc-simple-card sound: ak4642-hifi <-> ec500000.sound mapping ok
[   10.613633] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   10.619168] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   10.625201] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   10.629540] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.631357] i2c i2c-2: master_xfer[0] W, addr=0x20, len=1
[   10.631362] i2c i2c-2: master_xfer[1] R, addr=0x20, len=1
[   10.631931] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.652866] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   10.658871] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   10.664429] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   10.670403] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   10.675949] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   10.681916] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   10.687436] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   10.693535] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   10.699057] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   10.705043] i2c i2c-2: master_xfer[0] W, addr=0x12, len=2
[   10.931618] ata1: link resume succeeded after 1 retries
[   11.051635] ata1: SATA link down (SStatus 0 SControl 300)

--nextPart1870641.U85dPdquRh
Content-Disposition: attachment; filename="dmesg-bad.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="dmesg-bad.log"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.3.0-08388-ga27958726b59-dirty (laurent@avalon) (gcc version 4.7.3 20130205 (prerelease) (crosstool-NG linaro-1.13.1-4.7-2013.02-01-20130221 - Linaro GCC 2013.02) ) #297 SMP Mon Nov 16 22:48:44 EET 2015
[    0.000000] CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), cr=30c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine model: Koelsch
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] cma: Reserved 256 MiB at 0x0000000070000000
[    0.000000] cma: Reserved 64 MiB at 0x000000006c000000
[    0.000000] Forcing write-allocate cache policy for SMP
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 524288
[    0.000000] free_area_init_node: node 0, pgdat c0688fc0, node_mem_map e7fd8000
[    0.000000]   DMA zone: 1536 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 327680 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 12 pages/cpu @e7f90000 s17920 r8192 d23040 u49152
[    0.000000] pcpu-alloc: s17920 r8192 d23040 u49152 alloc=12*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: ignore_loglevel rw root=/dev/nfs ip=dhcp
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 1742912K/2097152K available (4308K kernel code, 305K rwdata, 1676K rodata, 400K init, 2183K bss, 26560K reserved, 327680K cma-reserved, 1048576K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05e1034   (5989 kB)
[    0.000000]       .init : 0xc05e2000 - 0xc0646000   ( 400 kB)
[    0.000000]       .data : 0xc0646000 - 0xc0692794   ( 306 kB)
[    0.000000]        .bss : 0xc0695000 - 0xc08b6cdc   (2184 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] 
[    0.000000] **********************************************************
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **                                                      **
[    0.000000] ** trace_printk() being used. Allocating extra memory.  **
[    0.000000] **                                                      **
[    0.000000] ** This means that this is a DEBUG kernel and it is     **
[    0.000000] ** unsafe for production use.                           **
[    0.000000] **                                                      **
[    0.000000] ** If you see this message and you are not debugging    **
[    0.000000] ** the kernel, report this immediately to your vendor!  **
[    0.000000] **                                                      **
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **********************************************************
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Architected cp15 timer(s) running at 10.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
[    0.000004] sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 4398046511100ns
[    0.000013] Switching to timer-based delay loop, resolution 100ns
[    0.000585] Console: colour dummy device 80x30
[    0.001386] console [tty0] enabled
[    0.001410] Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=100000)
[    0.001445] pid_max: default: 32768 minimum: 301
[    0.001579] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001603] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.002077] CPU: Testing write buffer coherency: ok
[    0.002121] ftrace: allocating 17236 entries in 51 pages
[    0.023420] CPU0: update cpu_capacity 1024
[    0.023447] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.023552] Setting up static identity map for 0x40009000 - 0x40009058
[    0.026516] CPU1: update cpu_capacity 1024
[    0.026521] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.026609] Brought up 2 CPUs
[    0.026653] SMP: Total of 2 processors activated (40.00 BogoMIPS).
[    0.026669] CPU: All CPU(s) started in SVC mode.
[    0.027093] devtmpfs: initialized
[    0.038091] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.038485] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.044017] pinctrl core: initialized pinctrl subsystem
[    0.045134] NET: Registered protocol family 16
[    0.046058] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.046807] i2c-core: driver [dummy] registered
[    0.073354] cpuidle: using governor ladder
[    0.103333] cpuidle: using governor menu
[    0.103460] ARMREG              : S R
[    0.103484] CRYPT_ENGINE        : S R
[    0.103501] DCU                 : S R
[    0.103517] DDM                 : S R
[    0.103537] ETHER               : S .
[    0.103554] GPIO0               : S R
[    0.103569] GPIO1               : S R
[    0.103584] GPIO2               : S R
[    0.103600] GPIO3               : S R
[    0.103615] GPIO4               : S R
[    0.103630] GPIO5               : S R
[    0.103645] GPIO6               : S R
[    0.103660] GPIO7               : S R
[    0.103680] H_UDI               : S R
[    0.103695] I2C0                : S R
[    0.103710] I2C1                : S R
[    0.103725] I2C2                : S R
[    0.103740] I2C3                : S R
[    0.103755] I2C4                : S R
[    0.103770] I2C5                : S R
[    0.103787] IICDVFS             : S R
[    0.103805] INTC_RT             : S R
[    0.103820] INTC_SYS            : S R
[    0.103835] IPMMU_SGX           : S R
[    0.103851] IRQC                : S R
[    0.103868] MFIS                : S R
[    0.103886] MSIOF0              : S R
[    0.103901] MSIOF1              : S R
[    0.103916] MSIOF2              : S R
[    0.103932] PUBLIC_BOOT_ROM     : S R
[    0.103948] QSPI                : S R
[    0.103965] REMOCON             : S R
[    0.103981] RTDMAC              : S R
[    0.103996] RWDT                : S R
[    0.104013] SCIF0               : S .
[    0.104032] SCIFA0              : S R
[    0.104048] SCIFA1              : S R
[    0.104063] SCIFA2              : S R
[    0.104080] SCIFB0              : S R
[    0.104095] SCIFB1              : S R
[    0.104110] SCIFB2              : S R
[    0.104141] SECURE_BOOT_ROM     : S R
[    0.104156] SECURE_UPTIME_CLOCK : S R
[    0.104184] SYS_DMAC0           : S R
[    0.104200] SYS_DMAC1           : S R
[    0.104216] TMU0                : S .
[    0.104242] Disabling MSTP clocks for the System Core
[    0.104257]   SMSTPCR0: *0xe6150130 |= 0x00640801
[    0.104272]   SMSTPCR1: *0xe6150134 |= 0x9b6c9b5a
[    0.104286]   SMSTPCR2: *0xe6150138 |= 0x100d21fc
[    0.104301]   SMSTPCR3: *0xe615013c |= 0xf08cdc10
[    0.104315]   SMSTPCR4: *0xe6150140 |= 0x80000044
[    0.104330]   SMSTPCR5: *0xe6150144 |= 0x44c00046
[    0.104344]   SMSTPCR6: *0xe615014c |= 0x059fe618
[    0.104358]   SMSTPCR7: *0xe6150990 |= 0x41c0fe85
[    0.104373]   SMSTPCR8: *0xe6150994 |= 0xffd79fff
[    0.104387]   SMSTPCR9: *0xe6150998 |= 0xfffeffe0
[    0.104402]   SMSTPCR10: *0xe615099c |= 0x000001c0
[    0.104416] Disabling MSTP clocks for the Realtime Core
[    0.104430]   RMSTPCR0: *0xe6150110 |= 0x00640801
[    0.104444]   RMSTPCR1: *0xe6150114 |= 0x9b6c9b5a
[    0.104458]   RMSTPCR2: *0xe6150118 |= 0x100d21fc
[    0.104472]   RMSTPCR3: *0xe615011c |= 0xf08cdc10
[    0.104487]   RMSTPCR4: *0xe6150120 |= 0x800001c4
[    0.104501]   RMSTPCR5: *0xe6150124 |= 0x44c00046
[    0.104515]   RMSTPCR6: *0xe615012c |= 0x05bfe618
[    0.104529]   RMSTPCR7: *0xe6150980 |= 0x41c0fe85
[    0.104543]   RMSTPCR8: *0xe6150984 |= 0xffd79fff
[    0.104558]   RMSTPCR9: *0xe6150988 |= 0xfffeffe0
[    0.104572]   RMSTPCR10: *0xe615098c |= 0x000001c0
[    0.104631] INTC_SYS            : S .
[    0.104648] IRQC                : S .
[    0.104680] SCIF0               : S .
[    0.107565] renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
[    0.110673] sh-pfc e6060000.pfc: r8a77910_pfc support registered
[    0.115807] No ATAGs?
[    0.115862] IRQ2 is asserted, installing da9063/da9210 regulator quirk
[    0.134310] i2c-core: driver [pcf857x] registered
[    0.135055] gpio-regulator regulator@1: Could not obtain regulator setting GPIOs: -517
[    0.135156] gpio-regulator regulator@3: Could not obtain regulator setting GPIOs: -517
[    0.135252] gpio-regulator regulator@5: Could not obtain regulator setting GPIOs: -517
[    0.135726] i2c-core: driver [as3711] registered
[    0.136042] usbcore: registered new interface driver usbfs
[    0.136117] usbcore: registered new interface driver hub
[    0.136188] usbcore: registered new device driver usb
[    0.136279] i2c-core: driver [tca6416-keypad] registered
[    0.136877] i2c i2c-6: adapter [e60b0000.i2c] registered
[    0.136929] i2c i2c-6: of_i2c: walking child nodes
[    0.136948] i2c i2c-6: of_i2c: register /i2c@e60b0000/pmic@58
[    0.137036] i2c 6-0058: Masking da9063 interrupt sources
[    0.137057] i2c i2c-6: master_xfer[0] W, addr=0x58, len=2
[    0.137486] i2c i2c-6: master_xfer[0] W, addr=0x58, len=2
[    0.137914] i2c i2c-6: master_xfer[0] W, addr=0x58, len=2
[    0.138338] i2c i2c-6: master_xfer[0] W, addr=0x58, len=2
[    0.138774] i2c 6-0058: uevent
[    0.138817] i2c i2c-6: client [da9063] registered with bus id 6-0058
[    0.138838] i2c i2c-6: of_i2c: register /i2c@e60b0000/regulator@68
[    0.138930] i2c 6-0068: Masking da9210 interrupt sources
[    0.138949] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.139375] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.139800] i2c 6-0068: IRQ2 is not asserted, removing quirk
[    0.139833] i2c 6-0068: uevent
[    0.139869] i2c i2c-6: client [da9210] registered with bus id 6-0068
[    0.139895] i2c-sh_mobile e60b0000.i2c: I2C adapter 6, bus speed 100000 Hz
[    0.140095] media: Linux media interface: v0.10
[    0.140170] Linux video capture interface: v2.00
[    0.140425] sh_cmt ffca0000.timer: ch0: used for clock events
[    0.140450] sh_cmt ffca0000.timer: ch1: used as clock source
[    0.140469] clocksource: ffca0000.timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000000 ns
[    0.141687] clocksource: Switched to clocksource arch_sys_counter
[    0.172097] NET: Registered protocol family 2
[    0.172522] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.172593] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.172705] TCP: Hash tables configured (established 8192 bind 8192)
[    0.172759] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.172794] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.172938] NET: Registered protocol family 1
[    0.173271] RPC: Registered named UNIX socket transport module.
[    0.173290] RPC: Registered udp transport module.
[    0.173304] RPC: Registered tcp transport module.
[    0.173318] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.173349] PCI: CLS 0 bytes, default 64
[    0.174285] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.175744] bounce: pool size: 64 pages
[    0.175773] io scheduler noop registered (default)
[    0.176529] gpio_rcar e6050000.gpio: driving 32 GPIOs
[    0.176950] gpio_rcar e6051000.gpio: driving 26 GPIOs
[    0.177374] gpio_rcar e6052000.gpio: driving 32 GPIOs
[    0.177801] gpio_rcar e6053000.gpio: driving 32 GPIOs
[    0.178225] gpio_rcar e6054000.gpio: driving 32 GPIOs
[    0.178657] gpio_rcar e6055000.gpio: driving 32 GPIOs
[    0.179084] gpio_rcar e6055400.gpio: driving 32 GPIOs
[    0.179482] gpio_rcar e6055800.gpio: driving 26 GPIOs
[    0.179976] pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
[    0.180166] pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
[    0.180189] pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
[    0.180208] pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
[    0.180226] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.180273] pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
[    0.180307] pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
[    0.180329] pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    0.180577] pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
[    0.180619] pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.180695] pci 0000:00:01.0: supports D1 D2
[    0.180711] pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
[    0.180955] pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
[    0.180995] pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    0.181068] pci 0000:00:02.0: supports D1 D2
[    0.181084] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
[    0.181340] PCI: bus0: Fast back to back transfers disabled
[    0.181362] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.181451] pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
[    0.181474] pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
[    0.181523] pci 0000:00:01.0: enabling device (0140 -> 0142)
[    0.181572] pci 0000:00:02.0: enabling device (0140 -> 0142)
[    0.181868] pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
[    0.182051] pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
[    0.182073] pci_bus 0001:01: root bus resource [io  0xee0c0000-0xee0c10ff]
[    0.182091] pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0c10ff]
[    0.182110] pci_bus 0001:01: No busn resource found for root bus, will use [bus 01-ff]
[    0.182155] pci 0001:01:00.0: [1033:0000] type 00 class 0x060000
[    0.182185] pci 0001:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
[    0.182207] pci 0001:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    0.182434] pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310
[    0.182475] pci 0001:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    0.182549] pci 0001:01:01.0: supports D1 D2
[    0.182565] pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
[    0.182807] pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320
[    0.182847] pci 0001:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    0.182920] pci 0001:01:02.0: supports D1 D2
[    0.182936] pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
[    0.183190] PCI: bus1: Fast back to back transfers disabled
[    0.183211] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[    0.183342] pci 0001:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
[    0.183365] pci 0001:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
[    0.183407] pci 0001:01:01.0: enabling device (0140 -> 0142)
[    0.183452] pci 0001:01:02.0: enabling device (0140 -> 0142)
[    0.183832] da9210 6-0068: probe
[    0.183939] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.184393] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.184901] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.184920] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.185598] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.185617] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.186197] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.186215] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.186793] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.186811] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.187388] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.187405] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.187980] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.188415] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.188432] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.189023] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.189040] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.189765] i2c i2c-6: master_xfer[0] W, addr=0x68, len=1
[    0.189785] i2c i2c-6: master_xfer[1] R, addr=0x68, len=1
[    0.190364] i2c i2c-6: master_xfer[0] W, addr=0x68, len=2
[    0.190827] i2c-core: driver [da9210] registered
[    0.191081] SuperH (H)SCI(F) driver initialized
[    0.191410] e6e60000.serial: ttySC0 at MMIO 0xe6e60000 (irq = 109, base_baud = 0) is a scif
[    1.750894] console [ttySC0] enabled
[    1.755170] e6e68000.serial: ttySC1 at MMIO 0xe6e68000 (irq = 110, base_baud = 0) is a scif
[    1.764363] [drm] Initialized drm 1.1.0 20060810
[    1.769554] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.776356] [drm] No driver support for vblank timestamp query.
[    1.782795] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[    1.790054] i2c-core: driver [adv7511] registered
[    1.796012] libphy: sh_mii: probed
[    1.800781] sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2e:09:0a:00:3d:cf, IRQ 111.
[    1.810689] i2c-core: driver [st1232-ts] registered
[    1.815760] i2c-core: driver [tsc2007] registered
[    1.821129] i2c i2c-2: adapter [e6530000.i2c] registered
[    1.826609] i2c i2c-2: of_i2c: walking child nodes
[    1.831510] i2c i2c-2: of_i2c: register /i2c@e6530000/codec@12
[    1.837567] i2c 2-0012: uevent
[    1.840724] i2c i2c-2: client [ak4643] registered with bus id 2-0012
[    1.847233] i2c i2c-2: of_i2c: register /i2c@e6530000/composite-in@20
[    1.853901] i2c 2-0020: uevent
[    1.857050] i2c i2c-2: client [adv7180] registered with bus id 2-0020
[    1.863645] i2c i2c-2: of_i2c: register /i2c@e6530000/hdmi@39
[    1.869597] i2c 2-0039: uevent
[    1.872799] adv7511 2-0039: probe
[    1.876354] i2c i2c-2: master_xfer[0] W, addr=0x39, len=1
[    1.881884] i2c i2c-2: master_xfer[1] R, addr=0x39, len=1
[    1.888062] i2c i2c-2: client [adv7511w] registered with bus id 2-0039
[    1.894755] i2c i2c-2: of_i2c: register /i2c@e6530000/eeprom@50
[    1.900889] i2c 2-0050: uevent
[    1.904054] i2c i2c-2: client [24c02] registered with bus id 2-0050
[    1.910468] i2c-rcar e6530000.i2c: probed
[    1.928984] usbcore: registered new interface driver usbhid
[    1.934739] usbhid: USB HID core driver
[    1.938880] NET: Registered protocol family 17
[    1.943536] Registering SWP/SWPB emulation handler
[    1.949417] Common Chip Code Register = 0x00004700
[    1.954352] Detected Renesas R-Car M2-W ES1.0
[    1.958812] CPU cores: CA15 [ 0 1 - - ] CA7 [ - - - -]
[    1.966038] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.972826] [drm] No driver support for vblank timestamp query.
[    1.979224] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[    1.987786] input: keyboard as /devices/platform/keyboard/input/input0
[    1.994855] hctosys: unable to open rtc device (rtc0)
[    1.995047] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.995049] [drm] No driver support for vblank timestamp query.
[    1.995362] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[    2.103492] sh-eth ee700000.ethernet eth0: attached PHY 1 (IRQ 373) to driver Micrel KSZ8041RNLI
[    2.131680] Sending DHCP requests ..
[    5.067005] sh-eth ee700000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
[    9.281665] ., OK
[    9.331672] IP-Config: Got DHCP answer from 192.168.1.47, my address is 192.168.1.254
[    9.339767] IP-Config: Complete:
[    9.343094]      device=eth0, hwaddr=2e:09:0a:00:3d:cf, ipaddr=192.168.1.254, mask=255.255.255.0, gw=255.255.255.255
[    9.353864]      host=192.168.1.254, domain=, nis-domain=(none)
[    9.359914]      bootserver=192.168.1.47, rootserver=192.168.1.47, rootpath=/home/laurent/src/iob/netboot/renesas
[    9.370233]      nameserver0=192.168.1.47
[    9.374567] SDHI0 Vcc: disabling
[    9.377868] SDHI1 Vcc: disabling
[    9.381168] SDHI2 Vcc: disabling
[    9.384483] SDHI0 VccQ: disabling
[    9.387873] SDHI1 VccQ: disabling
[    9.391262] SDHI2 VccQ: disabling
[    9.395159] sh-sci e6e60000.serial: dma_request_slave_channel_compat failed
[    9.402309] sh-sci e6e60000.serial: dma_request_slave_channel_compat failed
[    9.415686] VFS: Mounted root (nfs filesystem) on device 0:14.
[    9.423952] devtmpfs: mounted
[    9.427190] Freeing unused kernel memory: 400K (c05e2000 - c0646000)
[    9.826361] udevd[529]: starting version 1.9
[    9.862134] random: udevd urandom read with 37 bits of entropy available
[    9.881210] udevd[529]: specified group 'input' unknown
[    9.896770] i2c 6-0058: uevent
[    9.899971] da9210 6-0068: uevent
[    9.903724] i2c 2-0012: uevent
[    9.906910] i2c 2-0020: uevent
[    9.910097] i2c 2-0039: uevent
[    9.913306] i2c 2-0050: uevent
[    9.954702] i2c 6-0058: uevent
[    9.958039] da9210 6-0068: uevent
[    9.958109] i2c 6-0058: uevent
[    9.958323] i2c 6-0058: uevent
[    9.967984] da9210 6-0068: uevent
[    9.974441] i2c 2-0012: uevent
[    9.974475] da9210 6-0068: uevent
[    9.981212] i2c 2-0020: uevent
[    9.981259] i2c 2-0012: uevent
[    9.987710] i2c 2-0039: uevent
[    9.987911] i2c 2-0020: uevent
[    9.991917] rcar_thermal e61f0000.thermal: 1 sensor probed
[   10.000075] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.002140] i2c 2-0039: uevent
[   10.002902] i2c 2-0039: uevent
[   10.003253] i2c 2-0050: uevent
[   10.016309] [drm] No driver support for vblank timestamp query.
[   10.022801] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.030473] i2c 2-0050: uevent
[   10.034656] i2c 2-0050: uevent
[   10.037445] renesas_usbhs e6590000.usb: host probed
[   10.037454] renesas_usbhs e6590000.usb: transceiver found
[   10.037764] renesas_usbhs e6590000.usb: gadget probed
[   10.037989] renesas_usbhs e6590000.usb: probed
[   10.037997] sh-pfc e6060000.pfc: pin GP_7_23 already requested by ee090000.pci; cannot claim for e6590000.usb
[   10.038003] sh-pfc e6060000.pfc: pin-247 (e6590000.usb) status -22
[   10.038008] sh-pfc e6060000.pfc: could not request pin 247 (GP_7_23) from group usb0  on device sh-pfc
[   10.038012] renesas_usbhs e6590000.usb: Error applying setting, reverse things back
[   10.038016] renesas_usbhs e6590000.usb: failed to activate default pinctrl state
[   10.054641] renesas_spi e6b10000.spi: dma_request_slave_channel_compat failed
[   10.054646] renesas_spi e6b10000.spi: DMA not available, using PIO
[   10.071396] adv7180 2-0020: probe
[   10.071408] adv7180 2-0020: chip found @ 0x20 (e6530000.i2c)
[   10.071446] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.074535] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.074974] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.075329] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.075681] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.076031] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.076377] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.076729] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.077085] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.077434] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.077779] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.081712] i2c i2c-2: master_xfer[0] W, addr=0x20, len=2
[   10.082540] i2c-core: driver [adv7180] registered
[   10.082834] i2c 2-0020: uevent
[   10.097966] soc_scale_crop: module license 'unspecified' taints kernel.
[   10.097969] Disabling lock debugging due to kernel taint
[   10.208820] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.209053] renesas_spi e6b10000.spi: probed
[   10.210134] spi_sh_msiof e6e20000.spi: dma_request_slave_channel_compat failed
[   10.210155] spi_sh_msiof e6e20000.spi: DMA not available, using PIO
[   10.233848] [drm] No driver support for vblank timestamp query.
[   10.240300] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.248842] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.255658] [drm] No driver support for vblank timestamp query.
[   10.262145] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.270556] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.277374] [drm] No driver support for vblank timestamp query.
[   10.283870] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.295405] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.302217] [drm] No driver support for vblank timestamp query.
[   10.308702] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.320290] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.327107] [drm] No driver support for vblank timestamp query.
[   10.333582] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.345080] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.351889] [drm] No driver support for vblank timestamp query.
[   10.358355] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.368855] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.375686] [drm] No driver support for vblank timestamp query.
[   10.382265] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.382637] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[   10.382669] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[   10.384873] ak4642-codec 2-0012: probe
[   10.385036] i2c-core: driver [ak4642-codec] registered
[   10.385394] ak4642-codec 2-0012: uevent
[   10.413674] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.420459] [drm] No driver support for vblank timestamp query.
[   10.426989] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.502211] SCSI subsystem initialized
[   10.562079] sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz
[   10.570261] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[   10.575332] sh_mobile_sdhi ee140000.sd: Got WP GPIO
[   10.583420] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.590211] [drm] No driver support for vblank timestamp query.
[   10.596753] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.620728] libata version 3.00 loaded.
[   10.675876] random: nonblocking pool is initialized
[   10.783397] sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 clock rate 48 MHz
[   10.791550] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[   10.797451] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.804257] [drm] No driver support for vblank timestamp query.
[   10.810718] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   10.989344] sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 48 MHz
[   10.997968] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.002120] rcar_sound ec500000.sound: probed
[   11.009305] [drm] No driver support for vblank timestamp query.
[   11.015855] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   11.022022] scsi host0: sata_rcar
[   11.022428] ata1: SATA max UDMA/133 irq 112
[   11.047884] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.054697] [drm] No driver support for vblank timestamp query.
[   11.061176] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   11.092479] rcar_jpu fe980000.jpeg-codec: encoder device registered as /dev/video25
[   11.100335] rcar_jpu fe980000.jpeg-codec: decoder device registered as /dev/video26
[   11.109636] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.114523] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.114529] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.115510] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.115515] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.116111] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.116116] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.118807] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.118812] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.119372] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.119377] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.120160] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.120164] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.122189] asoc-simple-card sound: ak4642-hifi <-> ec500000.sound mapping ok
[   11.122260] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.122265] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.122835] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.122839] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.123405] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.123410] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.123967] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.123971] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.124952] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.124957] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.125786] i2c i2c-2: master_xfer[0] W, addr=0x12, len=1
[   11.125792] i2c i2c-2: master_xfer[1] R, addr=0x12, len=1
[   11.256312] [drm] No driver support for vblank timestamp query.
[   11.262824] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   11.271747] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.278527] [drm] No driver support for vblank timestamp query.
[   11.284997] rcar-du feb00000.display: failed to initialize DRM/KMS (-517)
[   11.471692] ata1: link resume succeeded after 1 retries
[   11.591697] ata1: SATA link down (SStatus 0 SControl 300)

--nextPart1870641.U85dPdquRh
Content-Disposition: attachment; filename="trace-good.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="trace-good.log"

# tracer: nop
#
# entries-in-buffer/entries-written: 232/232   #P:2
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
          <idle>-0     [000] d.h1     1.884018: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.884033: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.884222: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1     1.884304: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1     1.884324: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.889979: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.889985: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.890071: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.890173: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.895841: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.895848: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.895933: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.896036: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.901681: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.901688: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.901773: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.901876: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.907523: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.907529: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.907615: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.907717: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.913379: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.913386: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.913471: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.913573: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.919219: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.919225: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.919311: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.919413: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.925078: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.925084: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.925170: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.925273: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.930918: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.930924: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.931010: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.931112: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.936774: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.936781: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.936866: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.936968: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.942636: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.942643: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.942728: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.942830: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.948480: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.948487: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.948572: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.948674: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.954336: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.954343: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.954428: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.954530: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.960182: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.960189: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.960274: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.960376: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.979037: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.979046: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.979129: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.979232: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.984905: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.984912: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.984997: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.985099: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.990752: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.990759: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.990843: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.990946: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     1.996610: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.996617: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.996702: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     1.996804: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     2.002470: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     2.002477: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     2.002562: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     2.002664: rcar_i2c_irq: msr 14141414
    kworker/0:1H-513   [000] d.H3     9.465798: rcar_i2c_irq: msr 09090909
    kworker/0:1H-513   [000] d.H3     9.465808: rcar_i2c_irq: msr 08080808
    kworker/0:1H-513   [000] d.H2     9.465894: rcar_i2c_irq: msr 0c0c0c0c
    kworker/0:1H-513   [000] d.h.     9.465997: rcar_i2c_irq: msr 14141414
     ksoftirqd/0-3     [000] d.H5     9.472737: rcar_i2c_irq: msr 09090909
     ksoftirqd/0-3     [000] d.H5     9.472744: rcar_i2c_irq: msr 08080808
     ksoftirqd/0-3     [000] dnH6     9.472832: rcar_i2c_irq: msr 0c0c0c0c
     ksoftirqd/0-3     [000] dnH.     9.472934: rcar_i2c_irq: msr 14141414
      S20urandom-540   [000] d.h1     9.480210: rcar_i2c_irq: msr 09090909
      S20urandom-540   [000] d.h1     9.480218: rcar_i2c_irq: msr 08080808
           udevd-548   [000] d.h.     9.480305: rcar_i2c_irq: msr 0c0c0c0c
           udevd-552   [000] d.h.     9.480408: rcar_i2c_irq: msr 14141414
           udevd-548   [000] d.h.     9.490643: rcar_i2c_irq: msr 09090909
           udevd-548   [000] d.h.     9.490653: rcar_i2c_irq: msr 08080808
    kworker/0:1H-513   [000] d.h.     9.490740: rcar_i2c_irq: msr 0c0c0c0c
    kworker/0:1H-513   [000] d.h.     9.490841: rcar_i2c_irq: msr 14141414
           klogd-529   [000] d.h1     9.496985: rcar_i2c_irq: msr 09090909
           klogd-529   [000] d.H1     9.496993: rcar_i2c_irq: msr 08080808
           klogd-529   [000] dnH1     9.497079: rcar_i2c_irq: msr 0c0c0c0c
           klogd-529   [000] dnH1     9.497182: rcar_i2c_irq: msr 14141414
     ksoftirqd/0-3     [000] d.H7     9.504417: rcar_i2c_irq: msr 09090909
     ksoftirqd/0-3     [000] d.H7     9.504425: rcar_i2c_irq: msr 08080808
           udevd-548   [000] d.h.     9.504513: rcar_i2c_irq: msr 0c0c0c0c
           udevd-548   [000] dnh.     9.504622: rcar_i2c_irq: msr 14141414
        kthreadd-2     [000] d.h2     9.512140: rcar_i2c_irq: msr 09090909
        kthreadd-2     [000] d.h2     9.512148: rcar_i2c_irq: msr 08080808
    kworker/0:1H-513   [000] d.h1     9.512236: rcar_i2c_irq: msr 0c0c0c0c
    kworker/0:1H-513   [000] d.H1     9.512338: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     9.513351: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     9.513360: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     9.513445: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     9.513547: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     9.513683: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     9.513690: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.H4     9.513779: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.H1     9.513882: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] dnH5     9.514032: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] dnH5     9.514038: rcar_i2c_irq: msr 08080808
    kworker/0:1H-513   [000] d.H1     9.514126: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     9.514229: rcar_i2c_irq: msr 14141414
    kworker/0:1H-513   [000] d.h2     9.514384: rcar_i2c_irq: msr 09090909
    kworker/0:1H-513   [000] d.h2     9.514389: rcar_i2c_irq: msr 08080808
     kworker/0:1-194   [000] d.h.     9.514477: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     9.514569: rcar_i2c_irq: msr 44444444
          <idle>-0     [000] d.h1     9.514579: rcar_i2c_irq: msr 54545454
    kworker/0:1H-513   [000] d.h.     9.521819: rcar_i2c_irq: msr 09090909
    kworker/0:1H-513   [000] d.h.     9.521828: rcar_i2c_irq: msr 08080808
           udevd-552   [000] d.h.     9.521915: rcar_i2c_irq: msr 0c0c0c0c
           udevd-552   [000] dnh1     9.522018: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     9.523456: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     9.523465: rcar_i2c_irq: msr 08080808
    kworker/0:1H-513   [000] d.h.     9.523554: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     9.523654: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     9.523792: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     9.523798: rcar_i2c_irq: msr 08080808
    kworker/0:1H-513   [000] d.h1     9.523884: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1     9.523987: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1     9.524128: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     9.524134: rcar_i2c_irq: msr 08080808
           udevd-552   [000] d.h1     9.524327: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1     9.524411: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.H1     9.524433: rcar_i2c_irq: msr 14141414
         syslogd-526   [000] d.h2    10.512587: rcar_i2c_irq: msr 09090909
         syslogd-526   [000] d.h2    10.512598: rcar_i2c_irq: msr 08080808
           udevd-545   [000] d.h.    10.513965: rcar_i2c_irq: msr 03030303
           udevd-545   [000] d.h1    10.514050: rcar_i2c_irq: msr 02020202
           udevd-545   [000] d.h1    10.514072: rcar_i2c_irq: msr 10101010
           udevd-538   [000] d.h.    10.525325: rcar_i2c_irq: msr 09090909
           udevd-538   [000] d.h.    10.525334: rcar_i2c_irq: msr 08080808
           udevd-546   [000] d.h.    10.527179: rcar_i2c_irq: msr 03030303
           udevd-546   [000] d.h.    10.527262: rcar_i2c_irq: msr 02020202
           udevd-546   [000] d.h.    10.527283: rcar_i2c_irq: msr 10101010
           udevd-544   [000] d.h1    10.538597: rcar_i2c_irq: msr 09090909
           udevd-544   [000] d.h1    10.538607: rcar_i2c_irq: msr 08080808
           udevd-548   [000] d.h.    10.540372: rcar_i2c_irq: msr 03030303
           udevd-548   [000] d.h.    10.540455: rcar_i2c_irq: msr 02020202
           udevd-548   [000] d.h2    10.540477: rcar_i2c_irq: msr 10101010
           udevd-546   [000] d.h.    10.546197: rcar_i2c_irq: msr 09090909
           udevd-546   [000] d.h.    10.546205: rcar_i2c_irq: msr 08080808
           udevd-546   [000] d.h.    10.546292: rcar_i2c_irq: msr 0c0c0c0c
           udevd-538   [000] d.h.    10.546394: rcar_i2c_irq: msr 14141414
           udevd-538   [000] d.h.    10.558632: rcar_i2c_irq: msr 09090909
           udevd-538   [000] d.h.    10.558641: rcar_i2c_irq: msr 08080808
           udevd-538   [000] d.h.    10.560013: rcar_i2c_irq: msr 03030303
           udevd-538   [000] d.h.    10.560096: rcar_i2c_irq: msr 02020202
           udevd-538   [000] d.h.    10.560116: rcar_i2c_irq: msr 10101010
           udevd-538   [000] d.h.    10.565832: rcar_i2c_irq: msr 09090909
           udevd-538   [000] d.h.    10.565840: rcar_i2c_irq: msr 08080808
           udevd-549   [000] d.h.    10.565927: rcar_i2c_irq: msr 0c0c0c0c
           udevd-549   [000] d.h.    10.566029: rcar_i2c_irq: msr 14141414
           udevd-545   [000] d.h.    10.578283: rcar_i2c_irq: msr 09090909
           udevd-545   [000] d.h.    10.578292: rcar_i2c_irq: msr 08080808
           udevd-549   [000] d.h.    10.579230: rcar_i2c_irq: msr 03030303
           udevd-549   [000] d.h.    10.579312: rcar_i2c_irq: msr 02020202
           udevd-549   [000] d.h1    10.579334: rcar_i2c_irq: msr 10101010
           udevd-538   [000] d.h2    10.585049: rcar_i2c_irq: msr 09090909
           udevd-538   [000] d.h2    10.585057: rcar_i2c_irq: msr 08080808
           udevd-538   [000] d.h.    10.585144: rcar_i2c_irq: msr 0c0c0c0c
           udevd-548   [000] d.h1    10.585246: rcar_i2c_irq: msr 14141414
           udevd-538   [000] d.h.    10.597218: rcar_i2c_irq: msr 09090909
           udevd-538   [000] d.h.    10.597227: rcar_i2c_irq: msr 08080808
           udevd-538   [000] d.h.    10.598359: rcar_i2c_irq: msr 03030303
           udevd-538   [000] d.h.    10.598443: rcar_i2c_irq: msr 02020202
           udevd-538   [000] d.h.    10.598465: rcar_i2c_irq: msr 10101010
           udevd-546   [000] d.h1    10.604191: rcar_i2c_irq: msr 09090909
           udevd-546   [000] d.h1    10.604199: rcar_i2c_irq: msr 08080808
           udevd-546   [000] d.h.    10.604286: rcar_i2c_irq: msr 0c0c0c0c
           udevd-538   [000] d.h2    10.604389: rcar_i2c_irq: msr 14141414
         syslogd-526   [000] d.h.    10.624845: rcar_i2c_irq: msr 09090909
         syslogd-526   [000] d.h.    10.624854: rcar_i2c_irq: msr 08080808
          v4l_id-704   [000] d.h.    10.625049: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1    10.625132: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1    10.625153: rcar_i2c_irq: msr 14141414
          v4l_id-705   [000] d.h.    10.629654: rcar_i2c_irq: msr 09090909
          v4l_id-705   [000] d.h.    10.629663: rcar_i2c_irq: msr 08080808
          v4l_id-705   [000] d.h.    10.629749: rcar_i2c_irq: msr 0c0c0c0c
          v4l_id-705   [000] d.h.    10.629851: rcar_i2c_irq: msr 14141414
          v4l_id-704   [000] d.h1    10.631474: rcar_i2c_irq: msr 09090909
          v4l_id-704   [000] d.h1    10.631482: rcar_i2c_irq: msr 08080808
          v4l_id-704   [000] d.h.    10.631676: rcar_i2c_irq: msr 07070707
          v4l_id-704   [000] d.h.    10.631759: rcar_i2c_irq: msr 06060606
          v4l_id-704   [000] d.h.    10.631781: rcar_i2c_irq: msr 14141414
          v4l_id-705   [000] d.h1    10.632042: rcar_i2c_irq: msr 09090909
          v4l_id-705   [000] d.h1    10.632048: rcar_i2c_irq: msr 08080808
          v4l_id-705   [000] d.h1    10.632140: rcar_i2c_irq: msr 0c0c0c0c
           udevd-545   [000] d.h1    10.632238: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1    10.658496: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1    10.658508: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1    10.658700: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1    10.658781: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1    10.658802: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1    10.670058: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1    10.670066: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1    10.670259: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1    10.670340: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1    10.670361: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1    10.681574: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1    10.681581: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1    10.681775: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1    10.681856: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1    10.681877: rcar_i2c_irq: msr 14141414
         syslogd-526   [000] d.h.    10.693080: rcar_i2c_irq: msr 09090909
         syslogd-526   [000] d.h.    10.693085: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1    10.693280: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1    10.693361: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1    10.693382: rcar_i2c_irq: msr 14141414
         syslogd-526   [000] d.h.    10.704712: rcar_i2c_irq: msr 09090909
         syslogd-526   [000] d.h.    10.704717: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1    10.704912: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1    10.704994: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1    10.705014: rcar_i2c_irq: msr 14141414
          <idle>-0     [000] d.h1    10.710666: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1    10.710672: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1    10.710758: rcar_i2c_irq: msr 0c0c0c0c
          <idle>-0     [000] d.h1    10.710860: rcar_i2c_irq: msr 14141414

--nextPart1870641.U85dPdquRh
Content-Disposition: attachment; filename="trace-bad.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="trace-bad.log"

# tracer: nop
#
# entries-in-buffer/entries-written: 125/125   #P:2
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
          <idle>-0     [000] d.h1     1.887512: rcar_i2c_irq: msr 09090909
          <idle>-0     [000] d.h1     1.887527: rcar_i2c_irq: msr 08080808
          <idle>-0     [000] d.h1     1.887717: rcar_i2c_irq: msr 07070707
          <idle>-0     [000] d.h1     1.887798: rcar_i2c_irq: msr 06060606
          <idle>-0     [000] d.h1     1.887915: rcar_i2c_irq: msr 49494949
          <idle>-0     [000] d.h1     1.887926: rcar_i2c_irq: msr 59595959
           udevd-536   [000] d.h.    10.071581: rcar_i2c_irq: msr 09090909
           udevd-536   [000] d.h.    10.071593: rcar_i2c_irq: msr 08080808
           udevd-533   [000] d.H2    10.071681: rcar_i2c_irq: msr 0c0c0c0c
           udevd-533   [000] d.h.    10.071783: rcar_i2c_irq: msr 14141414
           udevd-536   [000] d.h2    10.074648: rcar_i2c_irq: msr 09090909
           udevd-536   [000] d.h2    10.074656: rcar_i2c_irq: msr 08080808
           udevd-536   [000] dnH.    10.074746: rcar_i2c_irq: msr 0c0c0c0c
           udevd-536   [000] d.h2    10.074848: rcar_i2c_irq: msr 14141414
           udevd-529   [000] dnH6    10.075087: rcar_i2c_irq: msr 09090909
           udevd-529   [000] dnH6    10.075094: rcar_i2c_irq: msr 08080808
     kworker/0:1-194   [000] d.H3    10.075181: rcar_i2c_irq: msr 0c0c0c0c
           udevd-529   [000] d.h.    10.075284: rcar_i2c_irq: msr 14141414
           udevd-529   [000] dnH4    10.075439: rcar_i2c_irq: msr 09090909
           udevd-529   [000] dnH4    10.075446: rcar_i2c_irq: msr 08080808
     kworker/0:1-194   [000] d.H3    10.075533: rcar_i2c_irq: msr 0c0c0c0c
           udevd-529   [000] d.h.    10.075636: rcar_i2c_irq: msr 14141414
           udevd-529   [000] dnH.    10.075792: rcar_i2c_irq: msr 09090909
           udevd-529   [000] dnH.    10.075797: rcar_i2c_irq: msr 08080808
     kworker/0:1-194   [000] d.H1    10.075884: rcar_i2c_irq: msr 0c0c0c0c
           udevd-529   [000] d.h.    10.075987: rcar_i2c_irq: msr 14141414
           udevd-529   [000] dnH4    10.076141: rcar_i2c_irq: msr 09090909
           udevd-529   [000] dnH4    10.076146: rcar_i2c_irq: msr 08080808
     kworker/0:1-194   [000] d.H2    10.076233: rcar_i2c_irq: msr 0c0c0c0c
           udevd-529   [000] d.h.    10.076336: rcar_i2c_irq: msr 14141414
           udevd-529   [000] dnH6    10.076488: rcar_i2c_irq: msr 09090909
           udevd-529   [000] dnH6    10.076494: rcar_i2c_irq: msr 08080808
           udevd-529   [000] d.H2    10.076581: rcar_i2c_irq: msr 0c0c0c0c
           udevd-529   [000] d.h.    10.076683: rcar_i2c_irq: msr 14141414
           udevd-529   [000] dnH6    10.076839: rcar_i2c_irq: msr 09090909
           udevd-529   [000] dnH6    10.076844: rcar_i2c_irq: msr 08080808
     kworker/0:1-194   [000] d.H.    10.076931: rcar_i2c_irq: msr 0c0c0c0c
           udevd-529   [000] d.h2    10.077034: rcar_i2c_irq: msr 14141414
           udevd-529   [000] dnH1    10.077195: rcar_i2c_irq: msr 09090909
           udevd-529   [000] dnH1    10.077200: rcar_i2c_irq: msr 08080808
     kworker/0:1-194   [000] d.H3    10.077287: rcar_i2c_irq: msr 0c0c0c0c
           udevd-529   [000] d.h.    10.077390: rcar_i2c_irq: msr 14141414
           udevd-529   [000] dnH1    10.077544: rcar_i2c_irq: msr 09090909
           udevd-529   [000] dnH1    10.077550: rcar_i2c_irq: msr 08080808
           udevd-529   [000] d.H3    10.077638: rcar_i2c_irq: msr 0c0c0c0c
           udevd-529   [000] d.h.    10.077740: rcar_i2c_irq: msr 14141414
           udevd-529   [000] dnH6    10.077890: rcar_i2c_irq: msr 09090909
           udevd-529   [000] dnH6    10.077895: rcar_i2c_irq: msr 08080808
           udevd-533   [000] d.H1    10.077983: rcar_i2c_irq: msr 0c0c0c0c
           udevd-529   [000] d.h.    10.078075: rcar_i2c_irq: msr 44444444
           udevd-529   [000] d.h.    10.078084: rcar_i2c_irq: msr 54545454
           udevd-533   [000] dnH5    10.081889: rcar_i2c_irq: msr 49494949
           udevd-533   [000] dnH5    10.081897: rcar_i2c_irq: msr 59595959
           udevd-529   [000] d.h.    11.114668: rcar_i2c_irq: msr 09090909
           udevd-529   [000] d.h.    11.114681: rcar_i2c_irq: msr 08080808
           udevd-536   [000] d.h1    11.114874: rcar_i2c_irq: msr 07070707
           udevd-536   [000] d.h.    11.114958: rcar_i2c_irq: msr 06060606
           udevd-529   [000] d.h2    11.115080: rcar_i2c_irq: msr 49494949
           udevd-529   [000] d.h.    11.115087: rcar_i2c_irq: msr 59595959
           udevd-529   [000] d.h.    11.115626: rcar_i2c_irq: msr 09090909
           udevd-529   [000] d.h.    11.115632: rcar_i2c_irq: msr 08080808
           udevd-546   [000] d.h.    11.115828: rcar_i2c_irq: msr 07070707
           udevd-546   [000] d.h.    11.115911: rcar_i2c_irq: msr 06060606
           udevd-546   [000] d.h.    11.116030: rcar_i2c_irq: msr 49494949
           udevd-546   [000] d.h1    11.116039: rcar_i2c_irq: msr 59595959
           udevd-529   [000] d.h.    11.116225: rcar_i2c_irq: msr 09090909
           udevd-529   [000] d.h.    11.116231: rcar_i2c_irq: msr 08080808
           udevd-529   [000] d.h.    11.116425: rcar_i2c_irq: msr 07070707
           udevd-529   [000] d.h.    11.116506: rcar_i2c_irq: msr 06060606
           udevd-529   [000] d.h.    11.116623: rcar_i2c_irq: msr 49494949
           udevd-529   [000] d.h.    11.116634: rcar_i2c_irq: msr 59595959
           udevd-529   [000] d.h.    11.118924: rcar_i2c_irq: msr 09090909
           udevd-529   [000] d.h.    11.118931: rcar_i2c_irq: msr 08080808
           udevd-536   [000] d.h.    11.119126: rcar_i2c_irq: msr 07070707
           udevd-536   [000] d.h.    11.119209: rcar_i2c_irq: msr 06060606
           udevd-536   [000] d.h.    11.119328: rcar_i2c_irq: msr 49494949
           udevd-536   [000] d.h.    11.119337: rcar_i2c_irq: msr 59595959
           udevd-537   [000] d.h.    11.119488: rcar_i2c_irq: msr 09090909
           udevd-537   [000] d.h.    11.119493: rcar_i2c_irq: msr 08080808
           udevd-537   [000] d.h.    11.119688: rcar_i2c_irq: msr 07070707
           udevd-529   [000] d.h2    11.119772: rcar_i2c_irq: msr 06060606
           udevd-546   [000] d.h.    11.119890: rcar_i2c_irq: msr 49494949
           udevd-546   [000] d.h.    11.119900: rcar_i2c_irq: msr 59595959
           udevd-529   [000] d.h.    11.120274: rcar_i2c_irq: msr 09090909
           udevd-529   [000] d.h.    11.120280: rcar_i2c_irq: msr 08080808
           udevd-529   [000] d.h.    11.120473: rcar_i2c_irq: msr 07070707
           udevd-529   [000] d.h.    11.120555: rcar_i2c_irq: msr 06060606
           udevd-529   [000] d.h.    11.120672: rcar_i2c_irq: msr 49494949
           udevd-529   [000] d.h.    11.120683: rcar_i2c_irq: msr 59595959
           udevd-529   [000] d.h.    11.122389: rcar_i2c_irq: msr 09090909
           udevd-529   [000] d.h.    11.122396: rcar_i2c_irq: msr 08080808
           udevd-529   [000] d.h.    11.122589: rcar_i2c_irq: msr 07070707
           udevd-529   [000] d.h.    11.122670: rcar_i2c_irq: msr 06060606
           udevd-529   [000] d.h.    11.122787: rcar_i2c_irq: msr 49494949
           udevd-529   [000] d.h.    11.122798: rcar_i2c_irq: msr 59595959
           udevd-529   [000] d.h.    11.122949: rcar_i2c_irq: msr 09090909
           udevd-529   [000] d.h.    11.122954: rcar_i2c_irq: msr 08080808
           udevd-529   [000] d.h.    11.123148: rcar_i2c_irq: msr 07070707
           udevd-529   [000] d.h.    11.123229: rcar_i2c_irq: msr 06060606
           udevd-529   [000] d.h.    11.123346: rcar_i2c_irq: msr 49494949
           udevd-529   [000] d.h.    11.123357: rcar_i2c_irq: msr 59595959
           udevd-529   [000] d.h.    11.123520: rcar_i2c_irq: msr 09090909
           udevd-529   [000] d.h.    11.123525: rcar_i2c_irq: msr 08080808
           udevd-529   [000] d.h.    11.123719: rcar_i2c_irq: msr 07070707
           udevd-529   [000] d.h.    11.123800: rcar_i2c_irq: msr 06060606
           udevd-529   [000] d.h.    11.123917: rcar_i2c_irq: msr 49494949
           udevd-529   [000] d.h.    11.123928: rcar_i2c_irq: msr 59595959
           udevd-529   [000] d.h.    11.124081: rcar_i2c_irq: msr 09090909
           udevd-529   [000] d.h.    11.124086: rcar_i2c_irq: msr 08080808
           udevd-529   [000] d.h.    11.124281: rcar_i2c_irq: msr 07070707
           udevd-534   [000] d.h.    11.124364: rcar_i2c_irq: msr 06060606
           udevd-534   [000] d.h.    11.124483: rcar_i2c_irq: msr 49494949
           udevd-534   [000] d.h.    11.124493: rcar_i2c_irq: msr 59595959
           udevd-529   [000] d.h1    11.125070: rcar_i2c_irq: msr 09090909
           udevd-529   [000] d.h1    11.125077: rcar_i2c_irq: msr 08080808
           udevd-536   [000] d.h.    11.125270: rcar_i2c_irq: msr 07070707
           udevd-536   [000] d.h.    11.125353: rcar_i2c_irq: msr 06060606
           udevd-536   [000] d.h2    11.125472: rcar_i2c_irq: msr 49494949
           udevd-536   [000] d.h.    11.125481: rcar_i2c_irq: msr 59595959
           udevd-529   [000] d.h.    11.125912: rcar_i2c_irq: msr 09090909
           udevd-529   [000] d.h.    11.125918: rcar_i2c_irq: msr 08080808
           udevd-537   [000] d.h.    11.126112: rcar_i2c_irq: msr 07070707
           udevd-537   [000] d.h1    11.126196: rcar_i2c_irq: msr 06060606
           udevd-537   [000] d.h.    11.126314: rcar_i2c_irq: msr 49494949
           udevd-537   [000] d.h1    11.126324: rcar_i2c_irq: msr 59595959

--nextPart1870641.U85dPdquRh--

