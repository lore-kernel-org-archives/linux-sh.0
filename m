From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 09 Jul 2014 12:23:37 +0000
Subject: [PATCH 07/13] ARM: shmobile: r8a73a4 dtsi: Add SoC-specific irqc compatible property
Message-Id: <1404908623-909-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1404908623-909-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

The interrupt controller used the generic compatible property only.
Add the SoC-specific one, to make it future proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 82c5ac825386..f3bd3d4603d7 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -51,7 +51,7 @@
 	};
 
 	irqc0: interrupt-controller@e61c0000 {
-		compatible = "renesas,irqc";
+		compatible = "renesas,irqc-r8a73a4", "renesas,irqc";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0 0xe61c0000 0 0x200>;
@@ -90,7 +90,7 @@
 	};
 
 	irqc1: interrupt-controller@e61c0200 {
-		compatible = "renesas,irqc";
+		compatible = "renesas,irqc-r8a73a4", "renesas,irqc";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0 0xe61c0200 0 0x200>;
-- 
1.9.1

