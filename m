From: Rob Herring <robh@kernel.org>
Date: Sat, 19 Dec 2015 04:17:06 +0000
Subject: Re: [PATCH 5/8 v6] thermal: rcar: enable to use thermal-zone on DT
Message-Id: <20151219041706.GA14936@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1u8qzsy.wl%kuninori.morimoto.gx@renesas.com>
 <876100qzp6.wl%kuninori.morimoto.gx@renesas.com>
 <20151217203707.GD7999@localhost.localdomain>
 <87wpsctxjv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wpsctxjv.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Dec 18, 2015 at 12:25:51AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch enables to use thermal-zone on DT if it was calles as
> "renesas,rcar-thermal-gen2".
> Previous style (= non thermal-zone) is still supported by
> "renesas,rcar-thermal" to keep compatibility for "git bisect".
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v5 -> v6
> 
>  - "was call" -> "was called"

Except there is a typo...

>  - add reason why it keeps previous style
> 
>  .../devicetree/bindings/thermal/rcar-thermal.txt   | 37 +++++++++++++++++-
>  drivers/thermal/rcar_thermal.c                     | 45 +++++++++++++++++++---
>  2 files changed, 75 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> index 332e625..e5ee3f1 100644
> --- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> @@ -1,8 +1,9 @@
>  * Renesas R-Car Thermal
>  
>  Required properties:
> -- compatible		: "renesas,thermal-<soctype>", "renesas,rcar-thermal"
> -			  as fallback.
> +- compatible		: "renesas,thermal-<soctype>",
> +			   "renesas,rcar-gen2-thermal" (with thermal-zone) or
> +			   "renesas,rcar-thermal" (without thermal-zone) as fallback.
>  			  Examples with soctypes are:
>  			    - "renesas,thermal-r8a73a4" (R-Mobile APE6)
>  			    - "renesas,thermal-r8a7779" (R-Car H1)

> +thermal: thermal@e61f0000 {
> +	compatible =	"renesas,thermal-r8a7790",
> +			"renesas,rcar-gen2-thermal",
> +			"renesas,rcar-thermal";

Isn't having both mutually exclusive?

Rob
