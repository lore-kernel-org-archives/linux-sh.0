From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 04 Aug 2014 06:51:48 +0000
Subject: [PATCH] ARM: shmobile: Remove genmai_defconfig from MAINTAINERS
Message-Id: <1407135108-3371-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The genmai defconfig file has been removed by
3ed27bd90d6d0c8b ("ARM: shmobile: genmai: remove defconfig")
so remove its entry in the MAINTAINERS accordingly.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86efa7e..6fb61a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1320,7 +1320,6 @@ F:	arch/arm/boot/dts/sh*
 F:	arch/arm/configs/ape6evm_defconfig
 F:	arch/arm/configs/armadillo800eva_defconfig
 F:	arch/arm/configs/bockw_defconfig
-F:	arch/arm/configs/genmai_defconfig
 F:	arch/arm/configs/koelsch_defconfig
 F:	arch/arm/configs/kzm9g_defconfig
 F:	arch/arm/configs/lager_defconfig
-- 
2.0.1

