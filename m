From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 09 Aug 2019 07:21:28 +0000
Subject: Re: [PATCH 8/8] dma-mapping: remove CONFIG_ARCH_NO_COHERENT_DMA_MMAP
Message-Id: <CAMuHMdV0JfZ_K2V7W0FQkobE_zLwe4Uez-EWzMMdTfVffpAWtA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190808160005.10325-1-hch@lst.de>
 <20190808160005.10325-9-hch@lst.de>
In-Reply-To: <20190808160005.10325-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vladimir Murzin <vladimir.murzin@arm.com>, Parisc List <linux-parisc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>

Hi Christoph,

On Thu, Aug 8, 2019 at 6:01 PM Christoph Hellwig <hch@lst.de> wrote:
> CONFIG_ARCH_NO_COHERENT_DMA_MMAP is now functionally identical to
> !CONFIG_MMU, so remove the separate symbol.  The only difference is that
> arm did not set it for !CONFIG_MMU, but arm uses a separate dma mapping
> implementation including its own mmap method, which is handled by moving
> the CONFIG_MMU check in dma_can_mmap so that is only applies to the
> dma-direct case, just as the other ifdefs for it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/Kconfig       |  1 -

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
