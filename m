From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:53:32 +0000
Subject: [PATCH/RFC 06/15] ARM: shmobile: r8a7794 dtsi: Add L2 cache-controller node
Message-Id: <1433444021-22167-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a device node for the L2 cache:
  - The L2 cache for the Cortex-A7 CPU cores is 512 KiB large (organized
    as 64 KiB x 8 ways).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
What are the DT bindings for a Cortex-A15 L2 cache controller?
---
 arch/arm/boot/dts/r8a7794.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index d26cce1f609dd7b8..0c3ab5febe0a88d8 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -38,6 +38,17 @@
 		};
 	};
 
+	L2_CA7: cache-controller@1 {
+		compatible = "cache";
+
+		cache-unified;
+		cache-level = <2>;
+		cache-size = <0x80000>;
+		cache-sets = <2048>;
+		cache-block-size = <32>;
+		cache-line-size = <32>;
+	};
+
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,cortex-a7-gic";
 		#interrupt-cells = <3>;
-- 
1.9.1

