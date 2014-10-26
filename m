From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 26 Oct 2014 14:11:15 +0000
Subject: [PATCH v5 10/14] ARM: shmobile: marzen-reference: Don't include legacy clock.h
Message-Id: <1414332679-15497-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The marzen-reference board file doesn't need the clock.h header, don't
include it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 38d9cdd26587..644883a29502 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -26,7 +26,6 @@
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 
-#include "clock.h"
 #include "common.h"
 #include "irqs.h"
 #include "r8a7779.h"
-- 
2.0.4

