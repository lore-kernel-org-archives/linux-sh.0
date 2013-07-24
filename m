From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Jul 2013 03:38:29 +0000
Subject: [PATCH 08/08] ARM: shmobile: Remove include <mach/hardware.h>
Message-Id: <20130724033829.30567.27355.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130724033715.30567.82782.sendpatchset@w520>
In-Reply-To: <20130724033715.30567.82782.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when no one is using this file, remove <mach/hardware.h>.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/hardware.h |    4 ----
 1 file changed, 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/hardware.h
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1,4 +0,0 @@
-#ifndef __ASM_MACH_HARDWARE_H
-#define __ASM_MACH_HARDWARE_H
-
-#endif /* __ASM_MACH_HARDWARE_H */
