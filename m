From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 22 Oct 2014 14:59:25 +0000
Subject: Re: [PATCH 1/3] clocksource: sh_tmu: Document R-Mobile r8a7740 binding
Message-Id: <6890235.hnMLlLN6KA@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1413970709-26607-1-git-send-email-geert+renesas@glider.be> <1413970709-26607-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1413970709-26607-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday 22 October 2014 11:38:27 Geert Uytterhoeven wrote:
> Compared to the r8a7779, the r8a7740 lacks the input capture register,
> which is not used by the driver (the current driver already handles the
> r8a7740 in the non-DT case).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/timer/renesas,tmu.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> b/Documentation/devicetree/bindings/timer/renesas,tmu.txt index
> 7db89fb2544411b5..4ae7910af09ffcb4 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> +++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> @@ -1,4 +1,4 @@
> -* Renesas R-Car Timer Unit (TMU)
> +* Renesas R-Mobile/R-Car Timer Unit (TMU)
> 
>  The TMU is a 32-bit timer/counter with configurable clock inputs and
>  programmable compare match.
> @@ -9,6 +9,7 @@ are independent. The TMU hardware supports up to three
> channels. Required Properties:
> 
>    - compatible: must contain one or more of the following:
> +    - "renesas,tmu-r8a7740" for the r8a7740 TMU
>      - "renesas,tmu-r8a7779" for the r8a7779 TMU
>      - "renesas,tmu" for any TMU.
>        This is a fallback for the above renesas,tmu-* entries

-- 
Regards,

Laurent Pinchart

