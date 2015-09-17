From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Sep 2015 08:59:34 +0000
Subject: [PATCH 18/21] ARM: shmobile: bockw: remove legacy DTB build target
Message-Id: <6263ef7c25d3e081642c22d2e6d0dc1e9cb7c015.1442478814.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Obsoleted by removal of legacy platform.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ad74cf99bc1f..08f85bcc7da7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -522,8 +522,6 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-smdkc110.dtb \
 	s5pv210-smdkv210.dtb \
 	s5pv210-torbreck.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
-	r8a7778-bockw.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
-- 
2.1.4

