From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Tue, 29 Jul 2008 05:37:25 +0000
Subject: [PATCH] sh: Fix compile error of Solution Engine
Message-Id: <488EAC95.4060507@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

When I compiled Solution Engine, this become compile error
because plaform device of sh_eth device becomes enable.
When sh7710/sh7712 which could use sh_eth was chosen,
revised it so that platform device of sh_eth device became enable.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/se/770x/setup.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/se/770x/setup.c b/arch/sh/boards/se/770x/setup.c
index cf4a5ba..6c64d77 100644
--- a/arch/sh/boards/se/770x/setup.c
+++ b/arch/sh/boards/se/770x/setup.c
@@ -113,6 +113,8 @@ static struct platform_device heartbeat_device = {
 	.resource	= heartbeat_resources,
 };

+#if defined(CONFIG_CPU_SUBTYPE_SH7710) ||\
+	defined(CONFIG_CPU_SUBTYPE_SH7712)
 /* SH771X Ethernet driver */
 static struct resource sh_eth0_resources[] = {
 	[0] = {
@@ -159,12 +161,16 @@ static struct platform_device sh_eth1_device = {
 	.num_resources = ARRAY_SIZE(sh_eth1_resources),
 	.resource = sh_eth1_resources,
 };
+#endif

 static struct platform_device *se_devices[] __initdata = {
 	&heartbeat_device,
 	&cf_ide_device,
+#if defined(CONFIG_CPU_SUBTYPE_SH7710) ||\
+	defined(CONFIG_CPU_SUBTYPE_SH7712)
 	&sh_eth0_device,
 	&sh_eth1_device,
+#endif
 };

 static int __init se_devices_setup(void)
-- 1.5.6.2
