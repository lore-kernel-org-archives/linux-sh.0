From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Wed, 01 Apr 2009 15:25:19 +0000
Subject: Re: qemu-sh CF access perormance
Message-Id: <49D3875F.5020103@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <49D2185C.4050909@juno.dti.ne.jp>
In-Reply-To: <49D2185C.4050909@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Magnus!  Thank you for your explanation.

Magnus Damm wrote:
> 2009/3/31 Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>:
>> I'd like to ask following questions to linux-sh experts,
>>
>>  - Why such io-traps are used to access CF?
>>  - Will this io-traps are used for SH7785LCR's SD card access?
>>
>> I guess these io-traps can be the reason why gcc takes so much time on qemu-sh.
> 
> The r2d hardware implements 16-bit only CF interface while driver
> software requires 8-bit access. To work around this issue io_trapped
> is used to convert 8-bit accesses to 16-bit accesses. This is quite
> slow.
> 
> For more information, please see the comment in arch/sh/boards/mach-r2d/setup.c
> 
> To improve performance, consider adding a command line flag to the
> kernel that disables io_trapped. This flag can then be set on the
> kernel command line by the person running qemu.
> 
> Hope this helps!

It really helps!

The attached patch is a rough implementation to add a command line
flag 'avoid_trap', which Magnus suggested.  It is just a reference,
but it reduces the gcc compile time from 40 seconds to around 4 seconds.
10 times faster!

Is it OK to add such qemu specific options to linux kernel mainline?

Regards,
Shin-ichiro KAWASAKI


--- a/linux-2.6.28/arch/sh/boards/mach-r2d/setup.c	2008-12-25 08:26:37.000000000 +0900
+++ b/linux-2.6.28/arch/sh/boards/mach-r2d/setup.c	2009-04-01 23:38:44.000000000 +0900
@@ -198,9 +198,11 @@
 	.minimum_bus_width	= 16,
 };
 
+static int avoid_trap;
+
 static int __init rts7751r2d_devices_setup(void)
 {
-	if (register_trapped_io(&cf_trapped_io) = 0)
+	if (avoid_trap || register_trapped_io(&cf_trapped_io) = 0)
 		platform_device_register(&cf_ide_device);
 
 	spi_register_board_info(spi_bus, ARRAY_SIZE(spi_bus));
@@ -245,6 +247,9 @@
 
 	sm501_reg = (void __iomem *)0xb3e00000 + SM501_DRAM_CONTROL;
 	writel(readl(sm501_reg) | 0x00f107c0, sm501_reg);
+
+    if (strstr(*cmdline_p, "avoid_trap"))
+        avoid_trap = 1;
 }
 
 /*

