From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Oct 2014 00:26:40 +0000
Subject: Re: [PATCH v2] clocksource: sh_mtu2: Drop incorrect SoC family name
Message-Id: <20141027002639.GJ25692@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414150178-4986-1-git-send-email-geert+renesas@glider.be>
 <2748392.6fMSe2cx9z@avalon>
In-Reply-To: <2748392.6fMSe2cx9z@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Lezcano <daniel.lezcano@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Oct 26, 2014 at 03:14:19PM +0200, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Friday 24 October 2014 13:29:38 Geert Uytterhoeven wrote:
> > The TPU2 hardware block is found in many Renesas SH and ARM SoCs, but
> 
> s/TPU2/MTU2/
> 
> With this fixed,
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I have fixed that and queued up the following:


From: Geert Uytterhoeven <geert+renesas@glider.be>

[PATCH] clocksource: sh_mtu2: Drop incorrect SoC family name

The MTU2 hardware block is found in many Renesas SH and ARM SoCs, but
not in R-Car.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/timer/renesas,mtu2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
index d9a8d5a..ba0a34d 100644
--- a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
@@ -1,4 +1,4 @@
-* Renesas R-Car Multi-Function Timer Pulse Unit 2 (MTU2)
+* Renesas Multi-Function Timer Pulse Unit 2 (MTU2)
 
 The MTU2 is a multi-purpose, multi-channel timer/counter with configurable
 clock inputs and programmable compare match.
-- 
2.1.1

