From: Simon Horman <horms+renesas@verge.net.au>
Date: Sat, 12 Jul 2014 13:53:34 +0000
Subject: [PATCH] ARM: shmobile: marzen: Consistently use tabs for indentation
Message-Id: <08af64097d4c5cb17f9df4dadf80ed5f508db743.1405173109.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1405173109.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1405173109.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Unify white space usage by consistently using tabs for indentation.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 20b1768..5745555 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -112,17 +112,17 @@
 };
 
 &scif2 {
-       pinctrl-0 = <&scif2_pins>;
-       pinctrl-names = "default";
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
 
-       status = "okay";
+	status = "okay";
 };
 
 &scif4 {
-       pinctrl-0 = <&scif4_pins>;
-       pinctrl-names = "default";
+	pinctrl-0 = <&scif4_pins>;
+	pinctrl-names = "default";
 
-       status = "okay";
+	status = "okay";
 };
 
 &sdhi0 {
-- 
2.0.0.rc2

