From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 06 Jan 2015 19:42:08 +0000
Subject: [PATCH 5/6] ARM: shmobile: kzm9g-reference dts: Add r2025sd rtc node
Message-Id: <1420573329-12762-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a DT node for the R2025D real-time clock, which is connected to
i2c0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 6f022c300f447afd..0b007ceae9e50cec 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -210,6 +210,11 @@
 			     <3 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	rtc@32 {
+		compatible = "ricoh,r2025sd";
+		reg = <0x32>;
+	};
+
 	as3711@40 {
 		compatible = "ams,as3711";
 		reg = <0x40>;
-- 
1.9.1

