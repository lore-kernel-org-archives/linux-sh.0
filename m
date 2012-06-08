From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 08 Jun 2012 06:04:59 +0000
Subject: [PATCH 1/5] sh: SH7734: Add devices_setup function of SH7734
Message-Id: <1339135503-1997-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index f799971..6ad884c 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -440,6 +440,13 @@ static struct platform_device *sh7734_devices[] __initdata = {
 	&rtc_device,
 };
 
+static int __init sh7734_devices_setup(void)
+{
+	return platform_add_devices(sh7734_devices,
+		ARRAY_SIZE(sh7734_devices));
+}
+arch_initcall(sh7734_devices_setup);
+
 static struct platform_device *sh7734_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
-- 
1.7.10

