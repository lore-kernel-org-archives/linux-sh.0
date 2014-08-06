From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 06 Aug 2014 07:17:57 +0000
Subject: Re: DMA engine API issue (was: [PATCH/RFC 0/5] R-Car Gen2 DMAC hardware descriptor list support)
Message-Id: <CAMuHMdVz8hNus5x1hn0feqb1SYsUuhA4QHHfPGyebiKLZJwfEQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<2568292.I2Yo4lJlu6@avalon>
	<20140804175458.GH30282@n2100.arm.linux.org.uk>
	<1877927.dGcJCfKbeH@avalon>
In-Reply-To: <1877927.dGcJCfKbeH@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>

Hi Laurent,

On Wed, Aug 6, 2014 at 1:19 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> I actually have the opposite problem, in my case channels of physically
> separate DMA engines can be used interchangeably to serve the system's slaves.
> Using the DMA engine DT bindings, DT nodes of the slaves currently reference a
> specific DMA engine, even if they can be served by both. This leads to limited
> dynamic channel allocation capabilities (especially when taking into account
> lazy channel allocation as mentioned in another mail in this thread).

What about adding a property to the first one, referencing the second
(or the other way around, don't know what's the easiest to implement)?

        dmac0: dma-controller@e6700000 {
                ...
                renesas,alternative = <&dmac1>;
                ...
        };

        dmac1: dma-controller@e6720000 {
                ...
        };

That would avoid having to bind a slave device explicitly to a single
dmac, or having to bind all slave devices to all dmacs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
