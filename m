From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:20:23 +0000
Subject: [PATCH] sh: sh_mobile mstpcr clocks for sh7366
Message-Id: <20081031112023.2986.18862.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20081031111548.2969.82771.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081031111548.2969.82771.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add sh7366 mstpcr bits and information about their parent clocks.
The datasheet is pretty clear about the clocks on this device.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

--- 0007/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2008-10-31 16:24:43.000000000 +0900
@@ -785,6 +785,46 @@ static struct clk sh7722_mstpcr_clocks[]
 	MSTPCR("vpu0", "bus_clk", 2, 1),
 	MSTPCR("lcdc0", "bus_clk", 2, 0),
 #endif
+#if defined(CONFIG_CPU_SUBTYPE_SH7366)
+	/* See page 52 of Datasheet V0.40: Overview -> Block Diagram */
+	MSTPCR("tlb0", "cpu_clk", 0, 31),
+	MSTPCR("ic0", "cpu_clk", 0, 30),
+	MSTPCR("oc0", "cpu_clk", 0, 29),
+	MSTPCR("rsmem0", "sh_clk", 0, 28),
+	MSTPCR("xymem0", "cpu_clk", 0, 26),
+	MSTPCR("intc30", "peripheral_clk", 0, 23),
+	MSTPCR("intc0", "peripheral_clk", 0, 22),
+	MSTPCR("dmac0", "bus_clk", 0, 21),
+	MSTPCR("sh0", "sh_clk", 0, 20),
+	MSTPCR("hudi0", "peripheral_clk", 0, 19),
+	MSTPCR("ubc0", "cpu_clk", 0, 17),
+	MSTPCR("tmu0", "peripheral_clk", 0, 15),
+	MSTPCR("cmt0", "r_clk", 0, 14),
+	MSTPCR("rwdt0", "r_clk", 0, 13),
+	MSTPCR("flctl0", "peripheral_clk", 0, 10),
+	MSTPCR("scif0", "peripheral_clk", 0, 7),
+	MSTPCR("scif1", "bus_clk", 0, 6),
+	MSTPCR("scif2", "bus_clk", 0, 5),
+	MSTPCR("msiof0", "peripheral_clk", 0, 2),
+	MSTPCR("sbr0", "peripheral_clk", 0, 1),
+	MSTPCR("i2c0", "peripheral_clk", 1, 9),
+	MSTPCR("icb0", "bus_clk", 2, 27),
+	MSTPCR("meram0", "sh_clk", 2, 26),
+	MSTPCR("dacc0", "peripheral_clk", 2, 24),
+	MSTPCR("dacy0", "peripheral_clk", 2, 23),
+	MSTPCR("tsif0", "bus_clk", 2, 22),
+	MSTPCR("sdhi0", "bus_clk", 2, 18),
+	MSTPCR("mmcif0", "bus_clk", 2, 17),
+	MSTPCR("usb0", "bus_clk", 2, 11),
+	MSTPCR("siu0", "bus_clk", 2, 8),
+	MSTPCR("veu1", "bus_clk", 2, 7),
+	MSTPCR("vou0", "bus_clk", 2, 5),
+	MSTPCR("beu0", "bus_clk", 2, 4),
+	MSTPCR("ceu0", "bus_clk", 2, 3),
+	MSTPCR("veu0", "bus_clk", 2, 2),
+	MSTPCR("vpu0", "bus_clk", 2, 1),
+	MSTPCR("lcdc0", "bus_clk", 2, 0),
+#endif
 };
 
 static struct clk *sh7722_clocks[] = {
