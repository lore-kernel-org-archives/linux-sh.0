From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 27 Oct 2015 23:05:28 +0000
Subject: [PATCH v4 2/3] arm64: renesas: salvator-x: enable I2C
Message-Id: <1445987129-13496-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1445987129-13496-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1445987129-13496-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index f522fda7843a..0599b2be90ab 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -45,6 +45,11 @@
 		renesas,groups = "scif2_data_a";
 		renesas,function = "scif2";
 	};
+
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2_a";
+		renesas,function = "i2c2";
+	};
 };
 
 &scif1 {
@@ -60,3 +65,10 @@
 
 	status = "okay";
 };
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
2.1.4

