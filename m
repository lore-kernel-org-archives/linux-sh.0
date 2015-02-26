From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 26 Feb 2015 06:21:14 +0000
Subject: [PATCH 17/32] ARM: shmobile: r8a7794: alt: Enable ethernet controller
Message-Id: <a895b7cda38cd2fa155be22b531d164f17ec84ec.1424849129.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Enable the ethernet controller for the Alt board. Pin muxing entries are
currently left out as r8a7794 pin control support isn't available yet.
We thus rely on the boot loader to configure ethernet pins for now.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 0d848e6..25bf434 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -43,6 +43,19 @@
 	status = "okay";
 };
 
+&ether {
+	phy-handle = <&phy1>;
+	renesas,ether-link-active-low;
+	status = "okay";
+
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		micrel,led-mode = <1>;
+	};
+};
+
 &scif2 {
 	status = "okay";
 };
-- 
2.1.4

