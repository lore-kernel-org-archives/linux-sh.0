From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 04 Nov 2014 01:50:58 +0000
Subject: [PATCH 28/34] ARM: shmobile: r8a73a4: Add SoC-specific CMT compatible property
Message-Id: <2cd823fc01d61e09f50d64624ec53da090ced742.1415059587.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The CMT1 timer used the generic compatible property only.
Add the SoC-specific one, which is already documented, to make it future
proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 8093967..b5ead84 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -114,7 +114,7 @@
 	};
 
 	cmt1: timer@e6130000 {
-		compatible = "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt-48-r8a73a4", "renesas,cmt-48-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
 
-- 
2.1.1

