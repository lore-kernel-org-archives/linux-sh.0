From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 24 Oct 2014 11:36:03 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7778: Add SoC-specific TMU compatible property
Message-Id: <1414150563-6645-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1414150563-6645-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414150563-6645-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The TMU timers used the generic compatible property only.
Add the SoC-specific one, to make it future proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 1e80e4c694828e15..96297f67fda8e632 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -163,7 +163,7 @@
 	};
 
 	tmu0: timer@ffd80000 {
-		compatible = "renesas,tmu";
+		compatible = "renesas,tmu-r8a7778", "renesas,tmu";
 		reg = <0xffd80000 0x30>;
 		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
@@ -175,7 +175,7 @@
 	};
 
 	tmu1: timer@ffd81000 {
-		compatible = "renesas,tmu";
+		compatible = "renesas,tmu-r8a7778", "renesas,tmu";
 		reg = <0xffd81000 0x30>;
 		interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
@@ -187,7 +187,7 @@
 	};
 
 	tmu2: timer@ffd82000 {
-		compatible = "renesas,tmu";
+		compatible = "renesas,tmu-r8a7778", "renesas,tmu";
 		reg = <0xffd82000 0x30>;
 		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
-- 
1.9.1

