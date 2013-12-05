From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Dec 2013 01:32:54 +0000
Subject: [PATCH 2/3] ARM: shmobile: sh73a0: add FSI support via DTSI
Message-Id: <877gbkqdz0.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/sh73a0.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 29d2ee6..8cb6071 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -243,4 +243,13 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	sh_fsi2: sound@ec230000 {
+		#sound-dai-cells = <1>;
+		compatible = "renesas,sh_fsi2";
+		reg = <0xec230000 0x400>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 146 0x4>;
+		status = "disabled";
+	};
 };
-- 
1.7.9.5

