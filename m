From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Apr 2014 12:48:15 +0000
Subject: [PATCH 02/02] ARM: shmobile: r8a7790 CCI configuration
Message-Id: <20140408124815.9773.87441.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Add the settings of CCI-400 for enabling ca15/ca7 snoop on r8a7790.
Needed to configure the CCI boot cluster port regardless of MCPM.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies on top of renesas-devel-v3.14-20140408

 arch/arm/mach-shmobile/smp-r8a7790.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- 0001/arch/arm/mach-shmobile/smp-r8a7790.c
+++ work/arch/arm/mach-shmobile/smp-r8a7790.c	2014-04-08 18:17:48.000000000 +0900
@@ -28,6 +28,11 @@
 #define CA15RESCNT	0x0040
 #define CA7RESCNT	0x0044
 #define MERAM		0xe8080000
+#define CCI_BASE	0xf0090000
+#define CCI_SLAVE3	0x4000
+#define CCI_SLAVE4	0x5000
+#define CCI_SNOOP	0x0000
+#define CCI_STATUS	0x000c
 
 static struct rcar_sysc_ch r8a7790_ca15_scu = {
 	.chan_offs = 0x180, /* PWRSR5 .. PWRER5 */
@@ -71,6 +76,16 @@ static void __init r8a7790_smp_prepare_c
 	r8a7790_pm_init();
 	rcar_sysc_power_up(&r8a7790_ca15_scu);
 	rcar_sysc_power_up(&r8a7790_ca7_scu);
+
+	/* enable snoop and DVM */
+	p = ioremap_nocache(CCI_BASE, 0x8000);
+	writel_relaxed(readl_relaxed(p + CCI_SLAVE3 + CCI_SNOOP) | 0x3,
+		p + CCI_SLAVE3 + CCI_SNOOP);    /* ca15 */
+	writel_relaxed(readl_relaxed(p + CCI_SLAVE4 + CCI_SNOOP) | 0x3,
+		p + CCI_SLAVE4 + CCI_SNOOP);    /* ca7 */
+	while (__raw_readl(p + CCI_STATUS));
+	/* wait for pending bit low */
+	iounmap(p);
 }
 
 struct smp_operations r8a7790_smp_ops __initdata = {
