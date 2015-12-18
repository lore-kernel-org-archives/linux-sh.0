From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 18 Dec 2015 10:15:34 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: r8a7791: use fallback usbhs compatibility string
Message-Id: <CAMuHMdVzcvJvOKp6y2faU-5KevRFfOAmPYSBYL9pm9S-bod-gA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
 <1450404705-5449-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1450404705-5449-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 18, 2015 at 3:11 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use recently added fallback compatibility string in r8a7791 device tree.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7791.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 2a369ddcb6fd..e2ffbfae6c5c 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -822,7 +822,7 @@
>         };
>
>         hsusb: usb@e6590000 {
> -               compatible = "renesas,usbhs-r8a7791";
> +               compatible = "renesas,usbhs-r8a7791", "renesas,usbhs";

"renesas,rcar-gen2-usbhs", not "renesas,usbhs".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
