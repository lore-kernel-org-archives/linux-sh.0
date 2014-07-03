From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 03 Jul 2014 12:02:45 +0000
Subject: [PATCH v6] ARM: shmobile: genmai reference dts: Add RSPI node
Message-Id: <1404388965-4853-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add SPI device for RSPI on Genmai.

On this board, only rspi4 is in use. Its bus contains a single device
(a wm8978 audio codec), for which no bindings are defined yet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6:
  - Rebased on top of renesas-devel-v3.16-rc3-20140701,
  - Dropped pinctrl settings, as the pinctrl driver is not yet integrated.
v5:
  - Rebased on top of renesas-devel-v3.14-rc1-20140204
v4:
  - No changes
v3:
  - No changes
v2:
  - Use generic "codec" instead of specific "wm8978" node name.
---
 arch/arm/boot/dts/r7s72100-genmai.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
index 56849b55e1c2..20705467f4c9 100644
--- a/arch/arm/boot/dts/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai.dts
@@ -57,3 +57,13 @@
 &scif2 {
 	status = "okay";
 };
+
+&spi4 {
+	status = "okay";
+
+	codec: codec@0 {
+		compatible = "wlf,wm8978";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+	};
+};
-- 
1.7.9.5

