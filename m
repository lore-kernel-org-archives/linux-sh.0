From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 May 2012 02:27:13 +0000
Subject: [PATCH 02/11] ARM: mach-shmobile: setup-r8a7740: add MERAM work-around
Message-Id: <87fwatar29.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

r8a7740 chip has lasting errata on MERAM buffer.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index ec4eb49..a45ca43 100644
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
+static void r8a7740_meram_workaround(void)
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
 
@@ -380,6 +398,9 @@ void __init r8a7740_add_standard_devices(void)
 	r8a7740_i2c_workaround(&i2c0_device);
 	r8a7740_i2c_workaround(&i2c1_device);
 
+	/* MERAM work-around */
+	r8a7740_meram_workaround();
+
 	platform_add_devices(r8a7740_early_devices,
 			    ARRAY_SIZE(r8a7740_early_devices));
 	platform_add_devices(r8a7740_late_devices,
-- 
1.7.5.4

