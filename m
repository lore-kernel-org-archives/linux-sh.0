From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 08 Jan 2016 21:12:32 +0000
Subject: [RFC v4 3/4] arm64: dts: salvator-x: Enable watchdog timer
Message-Id: <1452287553-18895-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch enables watchdog timer for Salvator-X board.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 594a4f6b8d3f49..164bde49c19a54 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -291,6 +291,10 @@
 	shared-pin;
 };
 
+&wdt0 {
+	status = "okay";
+};
+
 &audio_clk_a {
 	clock-frequency = <22579200>;
 };
-- 
2.1.4

