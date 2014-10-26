From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 26 Oct 2014 13:14:19 +0000
Subject: Re: [PATCH v2] clocksource: sh_mtu2: Drop incorrect SoC family name
Message-Id: <2748392.6fMSe2cx9z@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414150178-4986-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414150178-4986-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday 24 October 2014 13:29:38 Geert Uytterhoeven wrote:
> The TPU2 hardware block is found in many Renesas SH and ARM SoCs, but

s/TPU2/MTU2/

With this fixed,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> not in R-Car.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Drop family name instead of changing it to RZ.
> ---
>  Documentation/devicetree/bindings/timer/renesas,mtu2.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt index
> d9a8d5af1a21270f..ba0a34d97eb80261 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> +++ b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> @@ -1,4 +1,4 @@
> -* Renesas R-Car Multi-Function Timer Pulse Unit 2 (MTU2)
> +* Renesas Multi-Function Timer Pulse Unit 2 (MTU2)
> 
>  The MTU2 is a multi-purpose, multi-channel timer/counter with configurable
>  clock inputs and programmable compare match.

-- 
Regards,

Laurent Pinchart

