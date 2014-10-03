From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 03 Oct 2014 15:11:40 +0000
Subject: [PATCH v2 09/13] ARM: shmobile: lager dts: Add chosen/stdout-path
Message-Id: <1412349104-18724-10-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1412349104-18724-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1412349104-18724-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a stdout-path property so that automatic console selection works
in the absence of a "console=" parameter on the kernel command line.

Note that we have to keep the "console=" parameter in chosen/bootargs,
as this DTS is shared between legacy and multi-platform.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Keep "console=",
  - Update for 3a8912c2f983dbb2 ("ARM: shmobile: r8a7790: switch from
    scif to scifa")
---
 arch/arm/boot/dts/r8a7790-lager.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 1698591d530a14df..719979e29bf8d47c 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -25,6 +25,7 @@
 
 	chosen {
 		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		stdout-path = &scifa0;
 	};
 
 	memory@40000000 {
-- 
1.9.1

