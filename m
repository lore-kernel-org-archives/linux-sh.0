From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 02 Jan 2018 09:35:59 +0000
Subject: Re: [PATCH v2 4/9] ARM: dts: r7s72100: Add Capture Engine Unit (CEU)
Message-Id: <CAMuHMdXuApVjg4Sq3tY+p6SAfCqRaJ_GmaC2koiX1ZzDPiXXcQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1514469681-15602-1-git-send-email-jacopo+renesas@jmondi.org> <1514469681-15602-5-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1514469681-15602-5-git-send-email-jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Jacopo,

On Thu, Dec 28, 2017 at 3:01 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add Capture Engine Unit (CEU) node to device tree.

Thanks for your patch!

> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

With the issue below fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/boot/dts/r7s72100.dtsi
> +++ b/arch/arm/boot/dts/r7s72100.dtsi

> @@ -667,4 +667,13 @@
>                 power-domains = <&cpg_clocks>;
>                 status = "disabled";
>         };
> +
> +       ceu: ceu@e8210000 {
> +               reg = <0xe8210000 0x209c>;

Given the last documented register is at offset 0x209C, the region above is too
small (also in the example in the DT bindings).
But due to MMU granularity, it will be accessible anyway.

reg = <0xe8210000 0x3000>;

I assume the mandatory "remote-endpoint" property will come with the board
(GR-Peach) DTS patch?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
