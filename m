From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 May 2014 12:10:20 +0000
Subject: Re: [PATCH v2 6/9] ARM: shmobile: r8a7790: add audio dmac node
Message-Id: <CAMuHMdXEdsKT9JCFdnsdMcNsoAHB51UYmup1Q=UpU2Obi46zoQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-1-git-send-email-ben.dooks@codethink.co.uk>
	<1397511312-4845-7-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397511312-4845-7-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, magnus.damm@opensource.se, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Apr 14, 2014 at 11:35 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -158,6 +158,72 @@
>                 };
>         };
>
> +       dma1: dma-mux@1 {
> +               compatible = "renesas,shdma-mux";
> +               #dma-cells = <2>;
> +               dma-channels = <20>;

26, cfr. the sum of the subnodes?

> +               audiodma0: dma-contorller@ec700000 {
> +                       compatible = "renesas,shdma-r8a7790";
> +                       clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC0>;
> +                       dma-channels = <13>;

> +               audiodma1: dma-controller@ec720000 {
> +                       compatible = "renesas,shdma-r8a7790";
> +                       clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC1>;
> +                       dma-channels = <13>;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
