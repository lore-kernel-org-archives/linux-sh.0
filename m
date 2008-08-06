From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Wed, 06 Aug 2008 23:53:31 +0000
Subject: [PATCH 1/2] sh_eth Add SH7619 support (platform)
Message-Id: <87iqudzon8.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add EDMAC endian infomation.

 arch/sh/boards/mach-se/770x/setup.c   |   10 ++++++++--
 arch/sh/kernel/cpu/sh2/setup-sh7619.c |    9 ++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-se/770x/setup.c b/arch/sh/boards/mach-se/770x/setup.c
index 9123d96..5f5af82 100644
--- a/arch/sh/boards/mach-se/770x/setup.c
+++ b/arch/sh/boards/mach-se/770x/setup.c
@@ -13,6 +13,7 @@
 #include <asm/io.h>
 #include <asm/smc37c93x.h>
 #include <asm/heartbeat.h>
+#include <asm/sh_eth.h>
 
 /*
  * Configure the Super I/O chip
@@ -129,11 +130,16 @@ static struct resource sh_eth0_resources[] = {
 	},
 };
 
+static struct sh_eth_plat_data eth_platform_data = {
+	.phy = PHY_ID,
+	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+};
+
 static struct platform_device sh_eth0_device = {
 	.name = "sh-eth",
 	.id	= 0,
 	.dev = {
-		.platform_data = PHY_ID,
+		.platform_data = &eth_platform_data,
 	},
 	.num_resources = ARRAY_SIZE(sh_eth0_resources),
 	.resource = sh_eth0_resources,
@@ -156,7 +162,7 @@ static struct platform_device sh_eth1_device = {
 	.name = "sh-eth",
 	.id	= 1,
 	.dev = {
-		.platform_data = PHY_ID,
+		.platform_data = &eth_platform_data,
 	},
 	.num_resources = ARRAY_SIZE(sh_eth1_resources),
 	.resource = sh_eth1_resources,
diff --git a/arch/sh/kernel/cpu/sh2/setup-sh7619.c b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
index 56e5878..1f006e1 100644
--- a/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -12,6 +12,8 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 
+#include <asm/sh_eth.h>
+
 enum {
 	UNUSED = 0,
 
@@ -109,11 +111,16 @@ static struct resource eth_resources[] = {
 	},
 };
 
+static struct sh_eth_plat_data eth_platform_data = {
+	.phy = 1,
+	.edmac_endian = EDMAC_BIG_ENDIAN,
+};
+
 static struct platform_device eth_device = {
 	.name = "sh-eth",
 	.id	= -1,
 	.dev = {
-		.platform_data = (void *)1,
+		.platform_data = &eth_platform_data,
 	},
 	.num_resources = ARRAY_SIZE(eth_resources),
 	.resource = eth_resources,
-- 
1.5.6.3

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
