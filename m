From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:31:36 +0000
Subject: [PATCH 62/69] ARM: shmobile: r8a7740: add FSI support via DTSI
Message-Id: <efcd869b7c5ef0cff5887842afe2c184e509807a.1386901186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index b1c2ed9..52255bf 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -208,4 +208,13 @@
 		cap-sdio-irq;
 		status = "disabled";
 	};
+
+	sh_fsi2: sound@fe1f0000 {
+		#sound-dai-cells = <1>;
+		compatible = "renesas,sh_fsi2";
+		reg = <0xfe1f0000 0x400>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 9 0x4>;
+		status = "disabled";
+	};
 };
-- 
1.8.4

