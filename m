From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 26 Jan 2014 16:49:05 +0000
Subject: [PATCH 8/8] ARM: shmobile: lager.dtb: add usbphy reference
Message-Id: <1390754945-28142-9-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390754945-28142-1-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Enable the usbphy node so that the phy driver is available.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
---
Cc: linux-sh@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 8dfcd25..83bf18d 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -125,3 +125,7 @@
 	pinctrl-0 = <&usb2_pins>;
 	pinctrl-names = "default";
 };
+
+&usbphy {
+	status = "okay";
+};
-- 
1.8.5.2

