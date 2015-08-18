From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 18 Aug 2015 13:12:17 +0000
Subject: [PATCH 1/2] ARM: shmobile: bockw: remove legacy DTB build target
Message-Id: <1439903538-19201-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1438965297-12888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1438965297-12888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Obsoleted by removal of legacy platform.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c005f2e..d8e102f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -500,8 +500,6 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-smdkc110.dtb \
 	s5pv210-smdkv210.dtb \
 	s5pv210-torbreck.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
-	r8a7778-bockw.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
-- 
2.4.6

