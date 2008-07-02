From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Wed, 02 Jul 2008 02:20:24 +0000
Subject: [PATCH] SH7619 add ethernet controler support
Message-Id: <87iqvp6n87.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

- Add EtherC + PHY resource define.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

diff --git a/arch/sh/kernel/cpu/sh2/setup-sh7619.c b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
index cc530f4..56e5878 100644
--- a/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -96,8 +96,32 @@ static struct platform_device sci_device = {
 	},
 };
 
+static struct resource eth_resources[] = {
+	[0] = {
+		.start = 0xfb000000,
+		.end =   0xfb0001c8,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = 85,
+		.end = 85,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device eth_device = {
+	.name = "sh-eth",
+	.id	= -1,
+	.dev = {
+		.platform_data = (void *)1,
+	},
+	.num_resources = ARRAY_SIZE(eth_resources),
+	.resource = eth_resources,
+};
+
 static struct platform_device *sh7619_devices[] __initdata = {
 	&sci_device,
+	&eth_device,
 };
 
 static int __init sh7619_devices_setup(void)

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
