From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 May 2014 12:00:20 +0000
Subject: Re: [PATCH v2 3/9] ARM: shmobile: r8a7790: add dmac0 dmac1 nodes
Message-Id: <CAMuHMdUNAFJEFWYe5cpKaZqoZFhRA1s0YBntT5ZVJaieSj8ovQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-1-git-send-email-ben.dooks@codethink.co.uk>
	<1397511312-4845-4-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397511312-4845-4-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, magnus.damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Ben,

On Mon, Apr 14, 2014 at 11:35 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -86,6 +88,76 @@
>                 };
>         };
>
> +       dma0: dma-mux@0 {
> +               compatible = "renesas,shdma-mux";
> +               #dma-cells = <2>;
> +               dma-channels = <20>;

Shouldn't this be 30, i.e. the sum of the properties in the child nodes?

> +               sysdma0: dma-controller@e6700000 {
> +                       compatible = "renesas,shdma-r8a7790";
> +                       clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC0>;
> +                       dma-channels = <15>;

> +               sysdma1: dma-controller@e6720000 {
> +                       compatible = "renesas,shdma-r8a7790";
> +                       clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC1>;
> +                       dma-channels = <15>;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
