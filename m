From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 09 Jan 2015 13:08:52 +0000
Subject: [PATCH 4/4] ARM: shmobile: kzm9g: Build DTS for Multiplatform
Message-Id: <1420808932-3899-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1420808932-3899-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1420808932-3899-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Build the sh73a0 KZM9G board DTB in case of Multiplatform.
The DT reference case will be removed in the future and
can be ignored for now.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59e79e9167af28dd..52844bf64d22cc8c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -421,7 +421,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r8a7790-lager.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
-	r8a7794-alt.dtb
+	r8a7794-alt.dtb \
+	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_arria10_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
-- 
1.9.1

