From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 06 Mar 2014 19:54:08 +0000
Subject: [PATCH RFC] ARM: shmobile: r8a7791 legacy: Disable RMSTP clocks
Message-Id: <1394135648-10193-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Each module clock has actually two disable bits: one for the System Core
(ARM) in an SMSTPCRx register, and one for the Realtime Core (SH) in an
RMSTPRx register. Currently we don't touch the bits meant for the
Realtime Core, so some clocks may inadvertently be enabled and still run,
wasting power, while they're disabled in the SMSTPCRx register.
The actual state of the clock is indicated in the corresponding status
register.

Set the disable bits for the Realtime Core for all module clocks we
currently care about to fix this. After this, e.g. QSPI fails to work if
we deliberately keep its clock gated.

Thanks to Laurent for the Realtime Core hint.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
This is a quick hack, NOT to be applied!

Notes/Questions/...:
  - The good news is that the system booted fine, hence so far I didn't
    notice any clocks that were not enabled correctly in our driver code,
    for both legacy and DT case (I used a slightly different version of
    this hack to test the DT case).
  - After bootup, the following clocks seem to be enabled for the Realtime
    Core:
      SCIFA0-2, SCIFB0-2, QSPI, MSIOF0-2, I2C0-5
  - The following clocks were disabled for the Realtime Core:
      LVDS0, DU0-1, SCIF0-5, SCIFA3-5, SDHI0-2, CMT0, Thermal, Ether,
      VIN0-1, SATA0-1
  - These are only the clocks we're currently using. There exist other
    clocks, I did not check their states.
  - Just setting all RMSTPCRx registers to 0xffffffff is not an option, as
    reserved bits should be written back using their read values.
  - Should we add a new enable_reg to struct clk for the legacy case? Or
    just disable them at initialization time, without enlarging struct clk?
  - Add more registers to the bindings for the DT case?
  - How to tell the system that it should (not) disable the RMSTP clocks?
    Someone may want to run something on the SH core, and we don't want to
    interfere with that.

Thanks for your feedback!

 arch/arm/mach-shmobile/clock-r8a7791.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index 8e4c12a752b7..595111f79428 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -305,6 +305,7 @@ void __init r8a7791_clock_init(void)
 	void __iomem *modemr = ioremap_nocache(MODEMR, PAGE_SIZE);
 	u32 mode;
 	int k, ret = 0;
+	unsigned int i;
 
 	BUG_ON(!modemr);
 	mode = ioread32(modemr);
@@ -349,6 +350,19 @@ void __init r8a7791_clock_init(void)
 	else
 		goto epanic;
 
+	printk("Disabling all MSTP clocks for the Realtime Core\n");
+	for (i = 0; i < ARRAY_SIZE(mstp_clks); i++) {
+		const struct clk *clk = &mstp_clks[i];
+		void __iomem *reg = clk->mapped_reg - 0x20;
+		unsigned long physreg = (unsigned long)clk->enable_reg;
+		if ((unsigned long)clk->enable_reg >= SMSTPCR8) {
+			reg += 0x10;
+			physreg += 0x10;
+		}
+		iowrite32(ioread32(reg) | (1 << clk->enable_bit), reg);
+	}
+	printk("DONE\n");
+
 	return;
 
 epanic:
-- 
1.7.9.5

