From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 07 Apr 2014 21:05:03 +0000
Subject: Re: [PATCH 3/9] ARM: shmobile: r8a7790: add dmac0 dmac1 nodes
Message-Id: <CAMuHMdVO0O29fr_GZjaKhWC775aSw2cT6wcsu5s66eRvjV57tA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk>
	<1396901229-29117-4-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396901229-29117-4-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, magnus.damm@opensource.se, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Ben,

On Mon, Apr 7, 2014 at 10:07 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Add nodes for the SYS-DMA controllers, SYS-DMAC0 and SYS-DMAC1. These
> both share the same device sources, so are wrapped in the shdma-mux

Do you mean device REsources?

> node to allow both to be used.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
