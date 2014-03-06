From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 06 Mar 2014 11:32:24 +0000
Subject: [PATCH V2 04/12] ARM: shmobile: r7s72100: genmai: populate nodes for external clocks
Message-Id: <1394105552-9744-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---

Changes since V1:

* activate usb_x1, too

 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index e664611a47c8..941e72ce7c82 100644
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
@@ -30,6 +30,14 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <13330000>;
+};
+
+&usb_x1_clk {
+	clock-frequency = <48000000>;
+};
+
 &i2c2 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
1.9.0

