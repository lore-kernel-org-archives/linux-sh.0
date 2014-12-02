From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Dec 2014 08:37:16 +0000
Subject: [PATCH 2/5] ARM: shmobile: r8a73a4: Add r8a73a4-ape6evm-reference.dtb to ARCH_SHMOBILE_MULTI
Message-Id: <1417509439-31739-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Makes sure the dtb is built for multiplatform builds.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8df0598..bfcf6c2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -389,6 +389,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	sh73a0-kzm9g-reference.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
+	r8a73a4-ape6evm-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7779-marzen.dtb \
 	r8a7790-lager.dtb \
-- 
1.8.4.5

