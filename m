From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 09 Dec 2014 11:25:00 +0000
Subject: [PATCH 2/7] ARM: shmobile: armadillo800eva dts: Replace status value "ok" by "okay"
Message-Id: <1418124305-7445-2-git-send-email-geert+renesas@glider.be>
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
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index d4af4d86c6b03d01..9bd0cb439f448d03 100644
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
1.9.1

