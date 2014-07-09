From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 09 Jul 2014 12:52:53 +0000
Subject: Re: [PATCH 06/13] sh-pfc: Add renesas,pfc-r8a7791 to binding documentation
Message-Id: <1464234.X5dXn6zpnc@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1404908623-909-1-git-send-email-geert+renesas@glider.be> <1404908623-909-7-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1404908623-909-7-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Hi Geert,

Thank you for the patch.

On Wednesday 09 July 2014 14:23:36 Geert Uytterhoeven wrote:
> The driver already supports the r8a7791 SoC, and "renesas,pfc-r8a7791"
> is already in use.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt index
> 35d2e1f186f0..daef6fad6a5f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> @@ -15,6 +15,7 @@ Required Properties:
>      - "renesas,pfc-r8a7778": for R8A7778 (R-Mobile M1) compatible
> pin-controller. - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible
> pin-controller. - "renesas,pfc-r8a7790": for R8A7790 (R-Car H2) compatible
> pin-controller. +    - "renesas,pfc-r8a7791": for R8A7791 (R-Car M2)
> compatible pin-controller. - "renesas,pfc-sh7372": for SH7372 (SH-Mobile
> AP4) compatible pin-controller. - "renesas,pfc-sh73a0": for SH73A0
> (SH-Mobile AG5) compatible pin-controller.

-- 
Regards,

Laurent Pinchart

