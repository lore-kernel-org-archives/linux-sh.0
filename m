From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 25 Sep 2014 16:13:28 +0000
Subject: [PATCH 12/13] ARM: shmobile: alt dts: Add chosen/stdout-path
Message-Id: <1411661609-4280-13-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1411661609-4280-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1411661609-4280-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Add a stdout-path property so that automatic console selection works
in the absence of a "console=" parameter on the kernel command line.

Note that we have to keep the "console=ttySC0,38400" parameter in
chosen/bootargs, else the console will use the default setting of 115200
baud.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 79d06ef017a05b77..8aec51268b7d8177 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -21,6 +21,7 @@
 
 	chosen {
 		bootargs = "console=ttySC0,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		stdout-path = &scif2;
 	};
 
 	memory@40000000 {
-- 
1.9.1

