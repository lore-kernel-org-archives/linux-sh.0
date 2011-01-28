From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 28 Jan 2011 21:58:34 +0000
Subject: [PATCH] sh: sh7750: Fix incompatible pointer type
Message-Id: <1296252241-25330-1-git-send-email-iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

It is necessary to set array of struct platform_device in
early_platform_add_devices().

arch/sh/kernel/cpu/sh4/setup-sh7750.c: In function ‘plat_early_device_setup’:
arch/sh/kernel/cpu/sh4/setup-sh7750.c:260: warning: passing argument 1 of ‘early_platform_add_devices’ from incompatible pointer type
include/linux/platform_device.h:159: note: expected ‘struct platform_device **’ but argument is of type ‘struct platform_device *’
arch/sh/kernel/cpu/sh4/setup-sh7750.c:262: warning: passing argument 1 of ‘early_platform_add_devices’ from incompatible pointer type
include/linux/platform_device.h:159: note: expected ‘struct platform_device **’ but argument is of type ‘struct platform_device *’
arch/sh/kernel/cpu/sh4/setup-sh7750.c:263: warning: passing argument 1 of ‘early_platform_add_devices’ from incompatible pointer type
include/linux/platform_device.h:159: note: expected ‘struct platform_device **’ but argument is of type ‘struct platform_device *’

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/kernel/cpu/sh4/setup-sh7750.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index 84230e9..e53b4b3 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -255,12 +255,17 @@ static struct platform_device *sh7750_early_devices[] __initdata = {
 
 void __init plat_early_device_setup(void)
 {
+	struct platform_device *dev[1];
+
 	if (mach_is_rts7751r2d()) {
 		scif_platform_data.scscr |= SCSCR_CKE1;
-		early_platform_add_devices(&scif_device, 1);
+		dev[0] = &scif_device;
+		early_platform_add_devices(dev, 1);
 	} else {
-		early_platform_add_devices(&sci_device, 1);
-		early_platform_add_devices(&scif_device, 1);
+		dev[0] = &sci_device;
+		early_platform_add_devices(dev, 1);
+		dev[0] = &scif_device;
+		early_platform_add_devices(dev, 1);
 	}
 
 	early_platform_add_devices(sh7750_early_devices,
-- 
1.7.2.3

