From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 04 Nov 2014 01:50:20 +0000
Subject: [PATCH] ARM: shmobile: marzen-reference: Don't include legacy clock.h
Message-Id: <803fc9b590f74ef1066be328f2f33c2b285ca3af.1415059054.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415059054.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415059054.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The marzen-reference board file doesn't need the clock.h header, don't
include it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 38d9cdd..644883a 100644
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
2.1.1

