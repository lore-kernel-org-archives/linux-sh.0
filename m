From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Dec 2015 09:33:36 +0000
Subject: Re: [PATCH v2 2/2] usb: renesas_usbhs: add device tree support for r8a779[23]
Message-Id: <CAMuHMdVNi9OKmJBq5-H83WVN_N+wK4b1TSSg2hwTosWi0mMSew@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449726033-17117-1-git-send-email-horms+renesas@verge.net.au>
	<1449726033-17117-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449726033-17117-3-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Simon,

On Thu, Dec 10, 2015 at 6:40 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Simply document new compatibility string.
> As a previous patch adds a generic R-Car Gen2 compatibility string
> there appears to be no need for a driver updates.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> index b959059826cd..efb3199a2a80 100644
> --- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> +++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> @@ -5,6 +5,8 @@ Required properties:
>
>         - "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
>         - "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
> +       - "renesas,usbhs-r8a7792" for r8a7792 (R-Car V2H) compatible device
> +       - "renesas,usbhs-r8a7793" for r8a7793 (R-Car M2-N) compatible device
>         - "renesas,usbhs-r8a7794" for r8a7794 (R-Car E2) compatible device
>         - "renesas,usbhs-r8a7795" for r8a7795 (R-Car H3) compatible device
>         - "renesas,rcar-gen2-usbhs" for R-Car Gen2 compatibile device

I see a possible issue here:

Old r8a7791 dtsi just has "renesas,usbhs-r8a7791", so it works with the current
driver, as the driver matches against "renesas,usbhs-r8a7791".

Existing (out-of-tree) r8a7792 dtsi may have followed existing practices,
and just have "renesas,usbhs-r8a7792".
This won't work with the new driver, as the driver doesn't match again
"renesas,usbhs-r8a7792". The same applies to r8a7793.

Do we care about this
  - in upstream? Probably not.
  - in the BSP? It seems to have r8a7790/r8a7791 usbhs only, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
