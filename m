From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Oct 2014 14:28:36 +0000
Subject: [PATCH 1/3] MAINTAINERS: Remove reference to shmobile / koelsch_defconfig
Message-Id: <1414592918-25138-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

koelsch_defconfig was removed in commit 595c6a4bb77f0096 ("ARM:
shmobile: koelsch: Remove legacy C board code").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d9038077258b722..7095c6de7bbc1beb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1381,7 +1381,6 @@ F:	arch/arm/boot/dts/sh*
 F:	arch/arm/configs/ape6evm_defconfig
 F:	arch/arm/configs/armadillo800eva_defconfig
 F:	arch/arm/configs/bockw_defconfig
-F:	arch/arm/configs/koelsch_defconfig
 F:	arch/arm/configs/kzm9g_defconfig
 F:	arch/arm/configs/lager_defconfig
 F:	arch/arm/configs/mackerel_defconfig
-- 
1.9.1

