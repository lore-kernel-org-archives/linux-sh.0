From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:31:28 +0000
Subject: [PATCH 54/69] ARM: shmobile: Include all 2 GiB of memory on APE6EVM DT Ref
Message-Id: <9701f442139bd21c4db5b6354611b3d793431a95.1386901186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add 1GiB of DRAM at 0x2_0000_0000 to support the full 2GiB
of APE6EVM system memory also in case of DT reference.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 338f0cb..70b1fff 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -25,6 +25,11 @@
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
+	memory@200000000 {
+		device_type = "memory";
+		reg = <2 0x00000000 0 0x40000000>;
+	};
+
 	vcc_mmc0: regulator@0 {
 		compatible = "regulator-fixed";
 		regulator-name = "MMC0 Vcc";
-- 
1.8.4

