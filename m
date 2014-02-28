From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 28 Feb 2014 21:09:26 +0000
Subject: [PATCH 2/4] ARM: r7s72100: genmai: populate extal clock node
Message-Id: <1393621768-12568-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index e664611..1d045eb 100644
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
@@ -30,6 +30,10 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <13330000>;
+};
+
 &i2c2 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
1.8.5.1

