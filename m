From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2012 09:36:21 +0000
Subject: [PATCH 10/27 v2] ARM: shmobile: r8a7740: add MERAM work-around
Message-Id: <87sje0x46l.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

r8a7740 chip has lasting errata on MERAM buffer, and this patch adds
its work-around on setup-r8a7740.c
It solved CEU/VIO6C/2D-DMAC/VCP1/VPU5F/JPU/DISP memroy access error.

But MERAM driver can't control this issue,
since this work-around requires access to non-MERAM register address.
So, This it will be called as board specific code at this point.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
 arch/arm/mach-shmobile/include/mach/common.h   |    1 +
 arch/arm/mach-shmobile/setup-r8a7740.c         |   18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 9e37026..6e6839d 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -587,6 +587,7 @@ static void __init eva_init(void)
 	eva_clock_init();
 
 	r8a7740_pinmux_init();
+	r8a7740_meram_workaround();
 
 	/* SCIFA1 */
 	gpio_request(GPIO_FN_SCIFA1_RXD, NULL);
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 01e2bc0..45e61da 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -77,6 +77,7 @@ extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
+extern void r8a7740_meram_workaround(void);
 
 extern unsigned int r8a7779_get_core_count(void);
 extern int r8a7779_platform_cpu_kill(unsigned int cpu);
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index ec4eb49..366311b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -324,6 +324,24 @@ static struct platform_device *r8a7740_late_devices[] __initdata = {
 	&i2c1_device,
 };
 
+/*
+ * r8a7740 chip has lasting errata on MERAM buffer.
+ * this is work-around for it.
+ * see
+ *	"Media RAM (MERAM)" on r8a7740 documentation
+ */
+#define MEBUFCNTR	0xFE950098
+void r8a7740_meram_workaround(void)
+{
+	void __iomem *reg;
+
+	reg = ioremap_nocache(MEBUFCNTR, 4);
+	if (reg) {
+		iowrite32(0x01600164, reg);
+		iounmap(reg);
+	}
+}
+
 #define ICCR	0x0004
 #define ICSTART	0x0070
 
-- 
1.7.5.4

