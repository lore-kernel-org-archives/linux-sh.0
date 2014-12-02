From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Dec 2014 08:37:18 +0000
Subject: [PATCH 4/5] ARM: shmobile: r8a73a4: Remove r8a73a4-ape6evm-reference.dtb from ARCH_SHMOBILE_LEGACY
Message-Id: <1417509439-31739-5-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

No longer needed thanks to multiplatform support.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bfcf6c2..d8ab74e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -378,7 +378,6 @@ dtb-$(CONFIG_ARCH_S5PV210) += s5pv210-aquila.dtb \
 	s5pv210-torbreck.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	r8a73a4-ape6evm.dtb \
-	r8a73a4-ape6evm-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
-- 
1.8.4.5

