From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Oct 2014 14:28:37 +0000
Subject: [PATCH 2/3] ARM: dts: koelsch: Stop building r8a7791-koelsch.dtb in legacy builds
Message-Id: <1414592918-25138-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As of commit 595c6a4bb77f0096 ("ARM: shmobile: koelsch: Remove legacy C
board code"), koelsch is no longer supported in legacy builds.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59b6d3e5aaf05880..8df0598ba94832be 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -384,7 +384,6 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	r8a7778-bockw-reference.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
-	r8a7791-koelsch.dtb \
 	sh7372-mackerel.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb
-- 
1.9.1

