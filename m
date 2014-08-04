From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Aug 2014 08:05:49 +0000
Subject: Re: [PATCH 4/6] dmaengine: rcar-dmac: Add device tree bindings documentation
Message-Id: <CAMuHMdVtU_uujbJarBSdqR2hs5+=KTAxhnOU2tEM4MXaaTTG_A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1406766014.git.horms+renesas@verge.net.au>
	<3dc5d31428846326bf122a2a9b402a2a80e97681.1406766014.git.horms+renesas@verge.net.au>
In-Reply-To: <3dc5d31428846326bf122a2a9b402a2a80e97681.1406766014.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Jul 31, 2014 at 2:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> @@ -0,0 +1,98 @@
> +* Renesas R-Car DMA Controller Device Tree bindings
> +
> +Renesas R-Car Generation 2 SoCs have have multiple multi-channel DMA
> +controller instances named DMAC capable of serving multiple clients. Channels
> +can be dedicated to specific clients or shared between a large number of
> +clients.
> +
> +DMA clients are connected to the DMAC ports referenced by an 8-bit identifier
> +called MID/RID.

I think the above sentence can be removed, as it's superseded by the first
sentence of the successive paragraph:

> +
> +Each DMA client is connected to one dedicated port of the DMAC, identified by
> +an 8-bit port number called the MID/RID. A DMA controller can thus serve up to
> +256 clients in total. When the number of hardware channels is lower than the
> +number of clients to be served, channels must be shared between multiple DMA
> +clients. The association of DMA clients to DMAC channels is fully dynamic and
> +not described in these device tree bindings.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
