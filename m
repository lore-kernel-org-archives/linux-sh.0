From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Mon, 24 Jan 2011 01:40:17 +0000
Subject: [PATCH] sh: Fix build of sh7750 base boards
Message-Id: <1295833217-5799-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Renamed platform_register_device to platform_device_register.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4/setup-sh7750.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index c2b0aaa..672944f 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -230,10 +230,10 @@ static struct platform_device *sh7750_devices[] __initdata = {
 static int __init sh7750_devices_setup(void)
 {
 	if (mach_is_rts7751r2d()) {
-		platform_register_device(&scif_device);
+		platform_device_register(&scif_device);
 	} else {
-		platform_register_device(&sci_device);
-		platform_register_device(&scif_device);
+		platform_device_register(&sci_device);
+		platform_device_register(&scif_device);
 	}
 
 	return platform_add_devices(sh7750_devices,
-- 
1.7.2.3

