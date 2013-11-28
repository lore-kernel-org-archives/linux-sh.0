From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 15:44:53 +0000
Subject: [PATCH 2/2] ARM: shmobile: armadillo: Set vccq_sdhi0 regulator type in DT
Message-Id: <1385653493-9952-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The mandatory regulator-type property is missing, add it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 7b80f19..013a7cd 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -53,6 +53,8 @@
 		regulator-name = "SDHI0 VccQ";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-type = "voltage";
+
 		vin-supply = <&vcc_sdhi0>;
 
 		enable-gpio = <&pfc 74 GPIO_ACTIVE_HIGH>;
-- 
1.8.3.2

