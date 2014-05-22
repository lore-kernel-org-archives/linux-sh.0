From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 22 May 2014 12:33:17 +0000
Subject: [PATCH 2/2] ARM: shmobile: marzen dts: Remove superfluous include
Message-Id: <1400761997-13512-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1400761997-13512-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1400761997-13512-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

<dt-bindings/interrupt-controller/irq.h> is already included by
r8a7779.dtsi.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 321290828eee..649129906d6f 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -12,7 +12,6 @@
 /dts-v1/;
 #include "r8a7779.dtsi"
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "marzen";
-- 
1.9.1

