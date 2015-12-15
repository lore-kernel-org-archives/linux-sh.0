From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 15 Dec 2015 17:38:49 +0000
Subject: Re: [PATCH] dmaengine: use phys_addr_t for slave configuration
Message-Id: <20151215172649.GK1854@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1366967214-20776-1-git-send-email-linus.walleij@linaro.org>
 <CAMuHMdUTzTBT8DyRb5WN048U5DbVsFnhJB0c5tjHBnA4rfetJg@mail.gmail.com>
 <20150710081411.GF836@localhost>
 <CAMuHMdV8a1W1MyJPanUNBzaiNsL96JYzetBVSiZoC3=eKXzo1Q@mail.gmail.com>
In-Reply-To: <CAMuHMdV8a1W1MyJPanUNBzaiNsL96JYzetBVSiZoC3=eKXzo1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Dec 15, 2015 at 11:48:24AM +0100, Geert Uytterhoeven wrote:
> Hi Vinod,
> 
> On Fri, Jul 10, 2015 at 10:14 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Wed, Jul 08, 2015 at 12:12:52PM +0200, Geert Uytterhoeven wrote:
> >> On Fri, Apr 26, 2013 at 11:06 AM, Linus Walleij
> >> <linus.walleij@linaro.org> wrote:
> >> > The documentation already says these are physical addresses, and
> >> > we have concluded that any translation into the DMA address space
> >> > needs to reside in the dmaengine driver, so change the type of
> >> > the passed arguments.
> >> >
> >> > Cc: Arnd Bergmann <arnd@arndb.de>
> >> > Cc: Lee Jones <lee.jones@linaro.org>
> >> > Cc: Vinod Koul <vinod.koul@intel.com>
> >> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >>
> >> What's the status of this one, which has been acked by Lee and Arnd?
> > Looks to have slipped thru. I will redo it
> 
> Ping?

I should be able to do this in next few days...

> 
> > --
> > ~Vinod
> >
> >>
> >> Thanks!
> >>
> >> > ---
> >> >  include/linux/dmaengine.h | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> >> > index 91ac8da..681df5f9 100644
> >> > --- a/include/linux/dmaengine.h
> >> > +++ b/include/linux/dmaengine.h
> >> > @@ -361,8 +361,8 @@ enum dma_slave_buswidth {
> >> >   */
> >> >  struct dma_slave_config {
> >> >         enum dma_transfer_direction direction;
> >> > -       dma_addr_t src_addr;
> >> > -       dma_addr_t dst_addr;
> >> > +       phys_addr_t src_addr;
> >> > +       phys_addr_t dst_addr;
> >> >         enum dma_slave_buswidth src_addr_width;
> >> >         enum dma_slave_buswidth dst_addr_width;
> >> >         u32 src_maxburst;
> >> > --
> >> > 1.8.1.4
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
~Vinod
