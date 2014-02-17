From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Feb 2014 03:09:32 +0000
Subject: Re: [PATCH v3 2/4] ARM: shmobile: lager-reference: Add DU device
Message-Id: <20140217030932.GB7772@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1392586321-12187-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1392586321-12187-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Feb 16, 2014 at 10:31:59PM +0100, Laurent Pinchart wrote:
> The DU device has no DT bindings yet, instantiate it as a platform
> device for now.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Magnus Damm <damm@opensource.se>

Hi Laurent,

thanks for this.

It seems to me that it would be best to split this patch into two,
a board portion and a dt portion, so that each patche can
be applied to their respective branch.

In order to save you the bother of resending the series yet another time
I have taken the liberty of splitting the patch into two. The following
is the DTS patch. The remainder of your patch was taken (otherwise unchanged)
as the boards patch,


From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

ARM: shmobile: lager: Add DU device to DTS

The DU device has no DT bindings yet, instantiate it as a platform
device for now.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
[horms+renesas@verge.net.au: broken out of larger patch that
                             included board changes]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 5466fe4..26a9010 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -111,9 +111,14 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif0_pins &scif1_pins>;
+	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
 
+	du_pins: du {
+		renesas,groups = "du_rgb666", "du_sync_1", "du_clk_out_0";
+		renesas,function = "du";
+	};
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data";
 		renesas,function = "scif0";
-- 
1.8.5.2

