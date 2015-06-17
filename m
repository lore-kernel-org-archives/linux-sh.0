From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2015 09:31:23 +0000
Subject: [PATCH 07/15] ARM: shmobile: Drop r8a7740-armadillo800eva.dtb for legacy builds
Message-Id: <1434533491-21979-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The legacy board code for Armadillo-800 EVA has been removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e9eed01d48c5ccb5..332e9b1ed7a02c8f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -501,7 +501,6 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-smdkv210.dtb \
 	s5pv210-torbreck.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
-	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
 	r8a7779-marzen.dtb
-- 
1.9.1

