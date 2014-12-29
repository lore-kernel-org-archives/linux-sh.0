From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 29 Dec 2014 01:43:36 +0000
Subject: [PATCH 2/7] ARM: shmobile: armadillo800eva dts: Replace status value "ok" by "okay"
Message-Id: <16d3b8845ef3934a0586df5662254d54785d7741.1419809027.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1419809027.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1419809027.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

While the DT parsing code recognizes "ok" as a valid value for the
"status" property, ePAPR v1.1 doesn't mention it in the list of valid
values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index d4af4d8..9bd0cb4 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -172,7 +172,7 @@
 	pinctrl-names = "default";
 
 	phy-handle = <&phy0>;
-	status = "ok";
+	status = "okay";
 
 	phy0: ethernet-phy@0 {
 		reg = <0>;
@@ -193,7 +193,7 @@
 };
 
 &cmt1 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c0 {
-- 
2.1.3

