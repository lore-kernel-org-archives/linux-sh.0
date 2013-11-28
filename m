From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 28 Nov 2013 08:54:31 +0000
Subject: [PATCH 07/16] ARM: shmobile: bockw: header cleanup
Message-Id: <22e247ef146b9a13c836a005e04ce909e3e16966.1385628709.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

linux/pinctrl/machine.h is no longer needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw-reference.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index ae88fda..1687df9 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -19,7 +19,6 @@
  */
 
 #include <linux/of_platform.h>
-#include <linux/pinctrl/machine.h>
 #include <mach/common.h>
 #include <mach/r8a7778.h>
 #include <asm/mach/arch.h>
-- 
1.8.4

