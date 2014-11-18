From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 18 Nov 2014 00:51:12 +0000
Subject: [PATCH 1/4] ARM: shmobile: armadillo800eva: Use keyboard as gpio-keys node name
Message-Id: <04a5656fbcc960a519674f05d5458e6013d67467.1416271777.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1416271777.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1416271777.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This appears to be the best match for ePAPR.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 2703428..e183a33 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -78,7 +78,7 @@
 		regulator-boot-on;
 	};
 
-	gpio-keys {
+	keyboard {
 		compatible = "gpio-keys";
 
 		power-key {
-- 
2.1.1

