From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Jul 2013 15:09:13 +0000
Subject: [PATCH] ARM: shmobile: r8a73a4: fix PFC DT node
Message-Id: <Pine.LNX.4.64.1307191703040.26183@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The pfc DT node should use 2 cells for address and size, fix it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

This is against Simon's renesas.git devel branch. Feel free to merge with 
the offending patch, if possible.

 arch/arm/boot/dts/r8a73a4.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 2f1bec8..3c9c7f2 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -257,7 +257,7 @@
 
 	pfc: pfc@e6050000 {
 		compatible = "renesas,pfc-r8a73a4";
-		reg = <0xe6050000 0x9000>;
+		reg = <0 0xe6050000 0 0x9000>;
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
-- 
1.7.2.5

