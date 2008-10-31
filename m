From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:16:08 +0000
Subject: [PATCH] sh: sh_mobile mstpcr clocks for sh7723
Message-Id: <20081031111608.2970.2184.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20081031111548.2969.82771.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081031111548.2969.82771.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add sh7723 mstpcr bits and information about their parent clocks.
The datasheet is pretty clear about the clocks on this device.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   50 ++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

--- 0005/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2008-10-30 19:42:09.000000000 +0900
@@ -711,6 +711,56 @@ static struct clk sh7722_mstpcr_clocks[]
 	MSTPCR("vpu0", "bus_clk", 2, 1),
 	MSTPCR("lcdc0", "bus_clk", 2, 0),
 #endif
+#if defined(CONFIG_CPU_SUBTYPE_SH7723)
+	/* See page 60 of Datasheet V1.0: Overview -> Block Diagram */
+	MSTPCR("tlb0", "cpu_clk", 0, 31),
+	MSTPCR("ic0", "cpu_clk", 0, 30),
+	MSTPCR("oc0", "cpu_clk", 0, 29),
+	MSTPCR("l2c0", "sh_clk", 0, 28),
+	MSTPCR("ilmem0", "cpu_clk", 0, 27),
+	MSTPCR("fpu0", "cpu_clk", 0, 24),
+	MSTPCR("intc0", "cpu_clk", 0, 22),
+	MSTPCR("dmac0", "bus_clk", 0, 21),
+	MSTPCR("sh0", "sh_clk", 0, 20),
+	MSTPCR("hudi0", "peripheral_clk", 0, 19),
+	MSTPCR("ubc0", "cpu_clk", 0, 17),
+	MSTPCR("tmu0", "peripheral_clk", 0, 15),
+	MSTPCR("cmt0", "r_clk", 0, 14),
+	MSTPCR("rwdt0", "r_clk", 0, 13),
+	MSTPCR("dmac1", "bus_clk", 0, 12),
+	MSTPCR("tmu1", "peripheral_clk", 0, 11),
+	MSTPCR("flctl0", "peripheral_clk", 0, 10),
+	MSTPCR("scif0", "peripheral_clk", 0, 9),
+	MSTPCR("scif1", "peripheral_clk", 0, 8),
+	MSTPCR("scif2", "peripheral_clk", 0, 7),
+	MSTPCR("scif3", "bus_clk", 0, 6),
+	MSTPCR("scif4", "bus_clk", 0, 5),
+	MSTPCR("scif5", "bus_clk", 0, 4),
+	MSTPCR("msiof0", "bus_clk", 0, 2),
+	MSTPCR("msiof1", "bus_clk", 0, 1),
+	MSTPCR("meram0", "sh_clk", 0, 0),
+	MSTPCR("i2c0", "peripheral_clk", 1, 9),
+	MSTPCR("rtc0", "r_clk", 1, 8),
+	MSTPCR("atapi0", "sh_clk", 2, 28),
+	MSTPCR("adc0", "peripheral_clk", 2, 28),
+	MSTPCR("tpu0", "bus_clk", 2, 25),
+	MSTPCR("irda0", "peripheral_clk", 2, 24),
+	MSTPCR("tsif0", "bus_clk", 2, 22),
+	MSTPCR("icb0", "bus_clk", 2, 21),
+	MSTPCR("sdhi0", "bus_clk", 2, 18),
+	MSTPCR("sdhi1", "bus_clk", 2, 17),
+	MSTPCR("keysc0", "r_clk", 2, 14),
+	MSTPCR("usb0", "bus_clk", 2, 11),
+	MSTPCR("2dg0", "bus_clk", 2, 10),
+	MSTPCR("siu0", "bus_clk", 2, 8),
+	MSTPCR("veu1", "bus_clk", 2, 6),
+	MSTPCR("vou0", "bus_clk", 2, 5),
+	MSTPCR("beu0", "bus_clk", 2, 4),
+	MSTPCR("ceu0", "bus_clk", 2, 3),
+	MSTPCR("veu0", "bus_clk", 2, 2),
+	MSTPCR("vpu0", "bus_clk", 2, 1),
+	MSTPCR("lcdc0", "bus_clk", 2, 0),
+#endif
 };
 
 static struct clk *sh7722_clocks[] = {
