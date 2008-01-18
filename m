From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Fri, 18 Jan 2008 08:40:05 +0000
Subject: [PATCH] sh: Add SH Ethernet platform device for Solution Engine
Message-Id: <479065E5.70109@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add SH Ethernet platform device for Solution Engine.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/boards/se/770x/setup.c |   53 +++++++++++++++++++++++++++++++
 include/asm-sh/se.h            |   15 ++++++++
 2 files changed, 68 insertions(+)

diff -uprN a/arch/sh/boards/se/770x/setup.c b/arch/sh/boards/se/770x/setup.c
--- a/arch/sh/boards/se/770x/setup.c	2008-01-18 10:53:54.000000000 +0900
+++ b/arch/sh/boards/se/770x/setup.c	2008-01-18 16:49:15.000000000 +0900
@@ -2,6 +2,7 @@
  * linux/arch/sh/boards/se/770x/setup.c
  *
  * Copyright (C) 2000  Kazumoto Kojima
+ * Copyright (C) 2007,2008  Nobuhiro Iwamatsu
  *
  * Hitachi SolutionEngine Support.
  *
@@ -115,9 +116,61 @@ static struct platform_device heartbeat_
 	.resource	= heartbeat_resources,
 };

+#if defined(CONFIG_SH_ETH)
+static struct resource sh_eth0_resources[] = {
+	[0] = {
+		.start	= SH_ETH0_BASE,
+		.end	= SH_ETH0_BASE + 0x1B8,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_SH_ETH0,
+		.end	= IRQ_SH_ETH0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sh_eth0_device = {
+	.name	= "sh-eth",
+	.id	= 0,
+	.dev	= {
+		.platform_data = (void *)PHY_ID,
+	},
+	.num_resources	= ARRAY_SIZE(sh_eth0_resources),
+	.resource	= sh_eth0_resources,
+};
+
+static struct resource sh_eth1_resources[] = {
+	[0] = {
+		.start  = SH_ETH1_BASE,
+		.end    = SH_ETH1_BASE + 0x1B8,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_SH_ETH1,
+		.end	= IRQ_SH_ETH1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sh_eth1_device = {
+	.name	= "sh-eth",
+	.id	= 1,
+	.dev	= {
+		.platform_data = (void *)PHY_ID,
+	},
+	.num_resources	= ARRAY_SIZE(sh_eth1_resources),
+	.resource	= sh_eth1_resources,
+};
+#endif /* CONFIG_SH_ETH */
+
 static struct platform_device *se_devices[] __initdata = {
 	&heartbeat_device,
 	&cf_ide_device,
+#if defined(CONFIG_SH_ETH)
+	&sh_eth0_device,
+	&sh_eth1_device,
+#endif
 };

 static int __init se_devices_setup(void)
diff -uprN a/include/asm-sh/se.h b/include/asm-sh/se.h
--- a/include/asm-sh/se.h	2008-01-18 10:55:02.000000000 +0900
+++ b/include/asm-sh/se.h	2008-01-18 16:36:53.000000000 +0900
@@ -76,6 +76,21 @@
 #define IRQ_CFCARD	7
 #endif

+/* SH Ethernet */
+#if defined(CONFIG_CPU_SUBTYPE_SH7710)
+#define PHY_ID	0x00
+#elif defined(CONFIG_CPU_SUBTYPE_SH7712)
+#define PHY_ID	0x01
+#endif
+/* Ether Base Address */
+#define SH_ETH0_BASE	0xA7000000
+#define SH_ETH1_BASE	0xA7000400
+#define SH_TSU_ADDR	0xA7000804
+/* Ether IRQs */
+#define IRQ_SH_ETH0	80
+#define IRQ_SH_ETH1	81
+#define IRQ_SH_TSU	82
+
 #define __IO_PREFIX	se
 #include <asm/io_generic.h>

