From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Wed, 18 Jun 2008 09:29:06 +0000
Subject: [PATCH 1/2] sh: Solution Enginge 7710/7712 SH-Ether support
Message-Id: <4858D562.30103@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support SH-Ether for Hitachi Solution Engine.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/se/770x/setup.c |   49 ++++++++++++++++++++++++++++++++++++++++
 include/asm-sh/se.h            |   15 ++++++++++++
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/se/770x/setup.c b/arch/sh/boards/se/770x/setup.c
index 318bc8a..25767cc 100644
--- a/arch/sh/boards/se/770x/setup.c
+++ b/arch/sh/boards/se/770x/setup.c
@@ -115,9 +115,58 @@ static struct platform_device heartbeat_device = {
 	.resource	= heartbeat_resources,
 };

+/* SH771X Ethernet driver */
+static struct resource sh_eth0_resources[] = {
+	[0] = {
+		.start = SH_ETH0_BASE,
+		.end = SH_ETH0_BASE + 0x1B8,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = SH_ETH0_IRQ,
+		.end = SH_ETH0_IRQ,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sh_eth0_device = {
+	.name = "sh-eth",
+	.id	= 0,
+	.dev = {
+		.platform_data = PHY_ID,
+	},
+	.num_resources = ARRAY_SIZE(sh_eth0_resources),
+	.resource = sh_eth0_resources,
+};
+
+static struct resource sh_eth1_resources[] = {
+	[0] = {
+		.start = SH_ETH1_BASE,
+		.end = SH_ETH1_BASE + 0x1B8,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = SH_ETH1_IRQ,
+		.end = SH_ETH1_IRQ,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sh_eth1_device = {
+	.name = "sh-eth",
+	.id	= 1,
+	.dev = {
+		.platform_data = PHY_ID,
+	},
+	.num_resources = ARRAY_SIZE(sh_eth1_resources),
+	.resource = sh_eth1_resources,
+};
+
 static struct platform_device *se_devices[] __initdata = {
 	&heartbeat_device,
 	&cf_ide_device,
+	&sh_eth0_device,
+	&sh_eth1_device,
 };

 static int __init se_devices_setup(void)
diff --git a/include/asm-sh/se.h b/include/asm-sh/se.h
index bd2596c..0e2f720 100644
--- a/include/asm-sh/se.h
+++ b/include/asm-sh/se.h
@@ -76,6 +76,21 @@
 #define IRQ_CFCARD	7
 #endif

+/* SH Ether support (SH7710/SH7712) */
+/* Base address */
+#define SH_ETH0_BASE 0xA7000000
+#define SH_ETH1_BASE 0xA7000400
+/* PHY ID */
+#if defined(CONFIG_CPU_SUBTYPE_SH7710)
+# define PHY_ID 0x00
+#elif defined(CONFIG_CPU_SUBTYPE_SH7712)
+# define PHY_ID 0x01
+#endif
+/* Ether IRQ */
+#define SH_ETH0_IRQ	80
+#define SH_ETH1_IRQ	81
+#define SH_TSU_IRQ	82
+
 #define __IO_PREFIX	se
 #include <asm/io_generic.h>

-- 
1.5.5.1


