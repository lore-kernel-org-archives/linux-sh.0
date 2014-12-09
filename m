From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 09 Dec 2014 11:25:03 +0000
Subject: [PATCH 5/7] ARM: shmobile: koelsch dts: Replace status value "ok" by "okay"
Message-Id: <1418124305-7445-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1418124305-7445-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

While the DT parsing code recognizes "ok" as a valid value for the
"status" property, ePAPR v1.1 doesn't mention it in the list of valid
values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index a400c27a813f1a8b..18b8bff5d2e67421 100644
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
@@ -570,7 +570,7 @@
 
 /* composite video input */
 &vin1 {
-	status = "ok";
+	status = "okay";
 	pinctrl-0 = <&vin1_pins>;
 	pinctrl-names = "default";
 
-- 
1.9.1

