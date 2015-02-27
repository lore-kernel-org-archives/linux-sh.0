From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Feb 2015 01:49:30 +0000
Subject: Re: [PATCH v4 9/9] ARM: shmobile: bockw dts: Remove leftover Ethernet node
Message-Id: <20150227014930.GH31738@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424968934-30577-10-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424968934-30577-10-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 26, 2015 at 05:42:14PM +0100, Ulrich Hecht wrote:
> The previous commit "ARM: shmobile: bockw dts: Move Ethernet node to BSC"
> neglected to remove the old entry.

Thanks, I have squashed this change into that one.

The result was as as follows:


--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -45,9 +45,11 @@
                regulator-boot-on;
                regulator-always-on;
        };
+};
 
+&bsc {
        ethernet@18300000 {
-               compatible = "smsc,lan9220", "smsc,lan9115";
+               compatible = "smsc,lan89218", "smsc,lan9115";
                reg = <0x18300000 0x1000>;
 
                phy-mode = "mii";


However, the change of compatible string seems outside the changelog
description, so I dropped that portion. Leaving the following. If you do
want to update the compat strings please send a follow-up patch.


From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

[PATCH] ARM: shmobile: bockw dts: Move Ethernet node to BSC

Move the Ethernet node to the new BSC node, as its connected to the
Bus State Controller.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
[horms: dropped compat string changes as they seem out of scope]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 96cfcdc..274a1b6f 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -45,7 +45,9 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+};
 
+&bsc {
 	ethernet@18300000 {
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x18300000 0x1000>;
-- 
2.1.4

