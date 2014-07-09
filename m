From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 09 Jul 2014 21:52:22 +0000
Subject: Re: [PATCH] spi: sh-msiof: Use correct device for DMA mapping with IOMMU
Message-Id: <CAMuHMdWaYhSHU1toAM83V6Ee3dWdarz+Z3Q4De_idouEce_hhw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1404901277-31107-1-git-send-email-geert+renesas@glider.be>
	<70265909.OPtNRHeAkP@avalon>
In-Reply-To: <70265909.OPtNRHeAkP@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Laurent,

On Wed, Jul 9, 2014 at 11:38 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 09 July 2014 12:21:17 Geert Uytterhoeven wrote:
>> To function correctly in the presence of an IOMMU, the DMA buffers must be
>> mapped using the DMA channel's device instead of the MSIOF platform
>> device's device.
>
> Shouldn't you also update the dma_unmap_single() calls ?

I guess I should ;-)

Thanks, will fix...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
