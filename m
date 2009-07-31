From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Jul 2009 07:47:17 +0000
Subject: [PATCH 01/09] sh: Runtime PM pdev hwblk - header change
Message-Id: <20090731074717.29009.57874.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add a hwblk_id member to struct pdev_archdata. This member
should be used to point out on-chip hardware block id.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/device.h |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- 0001/arch/sh/include/asm/device.h
+++ work/arch/sh/include/asm/device.h	2009-07-30 15:00:23.000000000 +0900
@@ -3,7 +3,9 @@
  *
  * This file is released under the GPLv2
  */
-#include <asm-generic/device.h>
+
+struct dev_archdata {
+};
 
 struct platform_device;
 /* allocate contiguous memory chunk and fill in struct resource */
@@ -12,3 +14,8 @@ int platform_resource_setup_memory(struc
 
 void plat_early_device_setup(void);
 
+struct pdev_archdata {
+#ifdef CONFIG_ARCH_SHMOBILE
+	int hwblk_id;
+#endif
+};
