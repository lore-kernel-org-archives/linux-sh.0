From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Nov 2018 22:08:25 +0000
Subject: Re: [PATCH/RFC] dmaengine: sh: Remove R-Mobile APE6 support
Message-Id: <CAMuHMdXKRDpdXzr5kH+NEG+7PJ4QjMWa3h4z1Ne_q1x-RdiyPg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVV+NnwX+4o19wyF6GVF7Xk52nDyruJLfAfzvAMPhrcKQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVV+NnwX+4o19wyF6GVF7Xk52nDyruJLfAfzvAMPhrcKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Vinod <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Rob,

On Tue, Nov 13, 2018 at 8:32 PM Rob Landley <rob@landley.net> wrote:
> On 11/12/18 9:30 AM, Geert Uytterhoeven wrote:
> > CC SuperH
> >
> > On Mon, Nov 12, 2018 at 4:22 PM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> >> Renesas R-Mobile APE6 support is currently unused:
> >>   - DMA slaves were never enabled in r8a73a4.dtsi,
> >>   - The driver relies on legacy filter matching and describing all
> >>     slaves and MID/RIDs in a table, unlike modern DMA engine drivers for
> >>     similar hardware like rcar-dmac,
> >>   - The driver doesn't seem to work well.
> >>
> >> Remove the driver, it can be resurrected from git history when needed.
> >>
> >> As this was the last user of SH_DMAE_BASE on Renesas ARM SoCs, the
> >> sh-dma-engine driver core is now used on SuperH only.
>
> I'm trying to add dma support to smc91x on an sh7760 board:
>
> https://www.spinics.net/lists/linux-sh/msg53400.html
>
> I missed the ship window for the previous iteration so we had to use PIO, but
> DMA's a huge speedup and it's cycling back around on my todo list...
>
> Unfortunately due to a flash corruption bug we were stuck at 4.14 for that
> release. I'm trying to track that down now, then need to redo this work on top
> of 4.20 or 4.21.
>
> Kernel board support patches are at the lawyers being frowned at expensively
> before release, but it won't include DMA this time because I only got the first
> half of it working. (Board's hooked up and can do memory-to-memory, but the
> ethernet card couldn't use it because the smc91x claims of using dmaengine are
> lies, it's hardwired to a specific arm chip ("mainstone" I think?), and when I
> got QEMU to emulate that ARM board and tried to enable DMA: packet timeouts. I
> dunno if it's broken in the kernel or QEMU doesn't emulate the DMA...)
>
> >> Notes:
> >>   1. As Renesas ARM SoCs no longer use drivers/dma/sh/shdma-base.c, the
> >>      task to remove use of the deprecated dma_slave_config.direction
> >>      field gets thrown into the SuperH maintainers' basket ;-)
>
> At least in 4.14 there were two DMA apis, once of which is obsolete and unused,
> and the other is modern dmaengine support which at least passes its self-test.
>
> I left off boggling at the "slave API", I think...

Yes, there's SH_DMA_API and the "new" DMA_ENGINE API.

> >>   3. I tried to get SCIFA DMA to work by:
> >>        - Applying the DT and driver patches below,
> >>        - Reverting 219fb0c1436e4893 ("serial: sh-sci: Remove the
> >>          platform data dma slave rx/tx channel IDs").
>
> The board I'm using is platform data, never got converted to device tree. (If I
> can ever convince them to mail a board to Rich Felker I might try to hire him to
> convert it _myself_. Or I could just get him an old board on ebay, current
> cheapest one looks like
> https://www.ebay.com/p/Johnson-Controls-Ms-nae3511-2-Metasys-Controller-NAE-and-2x-Unt1108/567230953?iid(3254042308
> at the moment? Dead battery's fine for a dev/test system...)
>
> But it's not happening this month.
>
> >>      After that, serial console output using DMA seems to work, but the
> >>      system locks up when receiving any serial console input.
> >>      Probably it is easier to add r8a73a4 support to rcar-dmac.
>
> What _is_ the status of dmaengine? I thought it was the generic dma API the
> kernel was moving towards? (The youtube videos suggested such...)

Dmaengine is working on the Renesas R-Car Gen2 and Gen3 SoCs, using
rcar-dmac and usb-dmac.  But that's ARM (32/64-bit), not SuperH.

I'm afraid you're on your own on SuperH... Good luck!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
