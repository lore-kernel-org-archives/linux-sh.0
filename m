From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 01 Nov 2015 19:19:37 +0000
Subject: [RFC v3 3/5] ARM: shmobile: r8a7790: lager: enable rwdt
Message-Id: <1446405579-5367-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Just for testing, not for upstream!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index e2174d816e78c1..42cdced9a80f6f 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -698,3 +698,7 @@
 &ssi1 {
 	shared-pin;
 };
+
+&wdt0 {
+	status = "okay";
+};
-- 
2.1.4

