From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Jan 2015 17:42:54 +0000
Subject: Re: [PATCH 0/6] Renesas R-Car DMAC fixes
Message-Id: <CAMuHMdUxjoBuvEoMGi2gxSh4RqbgzAkCQ_GRAeFeSbvkY1H16w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422379516-1633-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422379516-1633-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, Jan 27, 2015 at 6:25 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Here are a couple of fixes for the rcar-dmac driver. They're based on the next
> branch of the dmaengine tree.
>
> The first four patches fix driver bugs, while the last two work around two
> hardware issues. Patch 5 works around a documented errata, while patch 6
> handles a data corruption issue that was noticed during test but not yet
> confirmed to be a hardware bug by Renesas. When more information about the
> issue will be available a better fix could possibly be developed.

Thanks for this series!

BTW, do you have a pointer to the IOMMU errata?

> Laurent Pinchart (6):
>   dmaengine: rcar-dmac: Fix uninitialized variable usage
>   dmaengine: rcar-dmac: Fix spinlock issues in interrupt
>   dmaengine: rcar-dmac: Fix oops due to unintialized list in error ISR
>   dmaengine: rcar-dmac: Allocate hardware descriptors with DMAC device
>   dmaengine: rcar-dmac: Work around descriptor mode IOMMU errata
>   dmaengine: rcar-dmac: Disable channel 0 when using IOMMU

Look all good to me, so
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
