From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 29 Dec 2014 01:43:39 +0000
Subject: [PATCH 5/7] ARM: shmobile: koelsch dts: Replace status value "ok" by "okay"
Message-Id: <815446d624f692b197ec5dde00cf341196513e03.1419809027.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7791-koelsch.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 990af16..e2faa62 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -366,7 +366,7 @@
 
 	phy-handle = <&phy1>;
 	renesas,ether-link-active-low;
-	status = "ok";
+	status = "okay";
 
 	phy1: ethernet-phy@1 {
 		reg = <1>;
@@ -377,7 +377,7 @@
 };
 
 &cmt0 {
-	status = "ok";
+	status = "okay";
 };
 
 &sata0 {
@@ -563,7 +563,7 @@
 
 /* composite video input */
 &vin1 {
-	status = "ok";
+	status = "okay";
 	pinctrl-0 = <&vin1_pins>;
 	pinctrl-names = "default";
 
-- 
2.1.3

