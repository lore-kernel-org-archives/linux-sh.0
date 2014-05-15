From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 May 2014 13:11:17 +0000
Subject: Re: [PATCH v2 3/9] ARM: shmobile: r8a7790: add dmac0 dmac1 nodes
Message-Id: <CAMuHMdX4+XPcUGfF0mrzeXuL3T5Tn7RTBW-T-mvLOM0VV_BURg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-1-git-send-email-ben.dooks@codethink.co.uk>
	<1397511312-4845-4-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397511312-4845-4-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, magnus.damm@opensource.se, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Apr 14, 2014 at 11:35 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -8,6 +8,8 @@
> +               sysdma0: dma-controller@e6700000 {

> +                       reg = <0 0xe6700020 0 0xffc0>;

> +               sysdma1: dma-controller@e6720000 {

> +                       reg = <0 0xe6720020 0 0xffc0>;

ePAPR: "The unit-address must match the first address specified in the reg
property of the node."

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
