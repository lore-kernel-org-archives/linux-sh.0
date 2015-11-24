From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 24 Nov 2015 21:32:22 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7791: remove deprecated #gpio-range-cells from dtsi
Message-Id: <1448400743-18104-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <a8a8266229787241e1dfdb075a416e31da2fa1d7.1394082270.git.horms+renesas@verge.net.au>
In-Reply-To: <a8a8266229787241e1dfdb075a416e31da2fa1d7.1394082270.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Commit a1bc260bb5f5d9 ("gpio: clean up gpio-ranges documentation")
declares the above property deprecated. That was more than 2 years ago.
Remove it, so it doesn't get copied around needlessly.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d79102c0e7d346..17f6a76f7b2ab8 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -509,7 +509,6 @@
 	pfc: pfc@e6060000 {
 		compatible = "renesas,pfc-r8a7791";
 		reg = <0 0xe6060000 0 0x250>;
-		#gpio-range-cells = <3>;
 	};
 
 	mmcif0: mmc@ee200000 {
-- 
2.1.4

