From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 10 Dec 2015 11:59:38 +0000
Subject: Re: [PATCH v2 1/2] usb: renesas_usbhs: add fallback compatibility strings
Message-Id: <5669692A.8070206@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449726033-17117-1-git-send-email-horms+renesas@verge.net.au>
 <1449726033-17117-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449726033-17117-2-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

On 12/10/2015 8:40 AM, Simon Horman wrote:

> Add fallback compatibility strings for R-Car Gen2 and Gen3.
> This is in keeping with the fallback scheme being adopted wherever
> appropriate for drivers for Renesas SoCs.
>
> Also add SoC names.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> v2
> * Add R-Car Gen2 and Gen3 fallback compatibility strings rather than
>    a single compatibility string for all of R-Car.
> ---
>   .../devicetree/bindings/usb/renesas_usbhs.txt          | 18 +++++++++++++-----
>   drivers/usb/renesas_usbhs/common.c                     |  9 +++++++++
>   2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> index 7d48f63db44e..b959059826cd 100644
> --- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> +++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
[...]
> @@ -22,7 +30,7 @@ Optional properties:
>
>   Example:
>   	usbhs: usb@e6590000 {
> -		compatible = "renesas,usbhs-r8a7790";
> +		compatible = "renesas,usbhs-r8a7790", "renesas,rcar-usbhs";

    You forgot "gen2-" here.

[...]

MBR, Sergei

