From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 05 Mar 2015 01:58:20 +0000
Subject: [PATCH 04/11] ARM: shmobile: kzm9g: Build DTS for Multiplatform
Message-Id: <36356bcc4d6a4208f9b6088e1df9781351c6d7bf.1425518682.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1425518682.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1425518682.git.horms+renesas@verge.net.au>
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
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..287ebca 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -482,7 +482,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7790-lager.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
-	r8a7794-alt.dtb
+	r8a7794-alt.dtb \
+	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
 	socfpga_arria10_socdk.dtb \
-- 
2.1.4

