From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Dec 2013 02:08:23 +0000
Subject: [PATCH 1/3] ARM: shmobile: sh73a0: add FSI support via DTSI
Message-Id: <63b1303d1922f7660bd9e90da56dfbf93134c5aa.1387764079.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1387764079.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1387764079.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 241c8cd..c460dd2 100644
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
1.8.4

