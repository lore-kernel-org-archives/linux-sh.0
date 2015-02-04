From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 04 Feb 2015 14:15:15 +0000
Subject: [PATCH v2 5/5] ARM: shmobile: r8a7740: Add L1 cache information to CPU node
Message-Id: <1423059315-28519-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1423059315-28519-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1423059315-28519-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Describe the L1 cache in the CPU node:
  - L1 instruction cache: 32 KiB (8 KiB x 4 ways),
  - L1 data cache: 32 KiB (8 KiB x 4 ways).

Add a link to the L2 cache.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/arm/boot/dts/r8a7740.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index c84a99931e30304c..81c26cf63ba0e78d 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -26,6 +26,15 @@
 			reg = <0x0>;
 			clock-frequency = <800000000>;
 			power-domains = <&pd_a3sm>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <256>;
+			i-cache-block-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <256>;
+			d-cache-block-size = <32>;
+			d-cache-line-size = <32>;
+			next-level-cache = <&L2>;
 		};
 	};
 
-- 
1.9.1

