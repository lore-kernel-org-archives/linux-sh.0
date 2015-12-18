From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 18 Dec 2015 10:16:11 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: r8a7794: use fallback usbhs compatibility string
Message-Id: <CAMuHMdVAPYj5X4uF4vgfufnVToywBEAj9mwAgz0VQauUCB6m=Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
 <1450404705-5449-4-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1450404705-5449-4-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 18, 2015 at 3:11 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> @@ -724,7 +724,7 @@
>         };
>
>         hsusb: usb@e6590000 {
> -               compatible = "renesas,usbhs-r8a7794";
> +               compatible = "renesas,usbhs-r8a7794", "renesas,usbhs";

"renesas,rcar-gen2-usbhs", not "renesas,usbhs".

(no complaints from checkpatch.pl?)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
