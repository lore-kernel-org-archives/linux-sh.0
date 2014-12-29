From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 29 Dec 2014 01:43:38 +0000
Subject: [PATCH 4/7] ARM: shmobile: henninger dts: Replace status value "ok" by "okay"
Message-Id: <deb9eb3ea1e5fa685b53744f1ff291ee18118029.1419809027.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7791-henninger.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index 740e386..d2ebf11 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -156,7 +156,7 @@
 
 	phy-handle = <&phy1>;
 	renesas,ether-link-active-low;
-	status = "ok";
+	status = "okay";
 
 	phy1: ethernet-phy@1 {
 		reg = <1>;
@@ -293,7 +293,7 @@
 
 /* composite video input */
 &vin0 {
-	status = "ok";
+	status = "okay";
 	pinctrl-0 = <&vin0_pins>;
 	pinctrl-names = "default";
 
-- 
2.1.3

