From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2015 09:31:19 +0000
Subject: [PATCH 03/15] ARM: shmobile: Drop sh73a0-kzm9g.dtb for legacy builds
Message-Id: <1434533491-21979-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The legacy board code for KZM-A9-GT has been removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 679d7cc2f57c4981..e9eed01d48c5ccb5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -504,8 +504,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	r8a7740-armadillo800eva.dtb \
 	r8a7778-bockw.dtb \
 	r8a7778-bockw-reference.dtb \
-	r8a7779-marzen.dtb \
-	sh73a0-kzm9g.dtb
+	r8a7779-marzen.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
-- 
1.9.1

