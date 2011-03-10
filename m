From: Simon Horman <horms@verge.net.au>
Date: Thu, 10 Mar 2011 08:42:02 +0000
Subject: Re: [PATCH] [rfc] mmc, ARM: Add zboot from eSD support for SuperH
Message-Id: <20110310084158.GB6508@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1299743892-3668-1-git-send-email-horms@verge.net.au>
 <AANLkTimiaTpz+Cjq_s0U=whNvwSAaZdk8UVKAS6mVkNC@mail.gmail.com>
In-Reply-To: <AANLkTimiaTpz+Cjq_s0U=whNvwSAaZdk8UVKAS6mVkNC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Thu, Mar 10, 2011 at 05:07:17PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Thu, Mar 10, 2011 at 4:58 PM, Simon Horman <horms@verge.net.au> wrote:
> > This allows a ROM-able zImage to be written to eSD and for SuperH Mobile
> > ARM to boot directly from the SDHI hardware block.
> >
> > This is achieved by the MaskROM loading the first portion of the image into
> > MERAM and then jumping to it.  This portion contains loader code which
> > copies the entire image to SDRAM and jumps to it. From there the zImage
> > boot code proceeds as normal, uncompressing the image into its final
> > location and then jumping to it.
> >
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> Nice to see some SDHI loader code!
> 
> > --- /dev/null
> > +++ b/arch/arm/boot/compressed/sdhi-shmobile.c
> 
> > +#define PORT179CR      0xe60520b3
> > +#define PORT180CR      0xe60520b4
> > +#define PORT181CR      0xe60520b5
> > +#define PORT182CR      0xe60520b6
> > +#define PORT183CR      0xe60520b7
> > +#define PORT184CR      0xe60520b8
> > +
> > +#define SMSTPCR3       0xe615013c
> > +#define SDGENCNTA      0xfe40009c
> 
> These...
> 
> > +       /* Initialise SDHI1 */
> > +       /* PORT184CR: GPIO_FN_SDHICMD1 Control */
> > +       __raw_writeb(CR_FUNCTION1, PORT184CR);
> > +       /* PORT179CR: GPIO_FN_SDHICLK1 Control */
> > +       __raw_writeb(CR_INPUT_ENABLE|CR_FUNCTION1, PORT179CR);
> > +       /* PORT181CR: GPIO_FN_SDHID1_3 Control */
> > +       __raw_writeb(CR_FUNCTION1, PORT183CR);
> > +       /* PORT182CR: GPIO_FN_SDHID1_2 Control */
> > +       __raw_writeb(CR_FUNCTION1, PORT182CR);
> > +       /* PORT183CR: GPIO_FN_SDHID1_1 Control */
> > +       __raw_writeb(CR_FUNCTION1, PORT181CR);
> > +       /* PORT180CR: GPIO_FN_SDHID1_0 Control */
> > +       __raw_writeb(CR_FUNCTION1, PORT180CR);
> > +
> > +       /* Enable clock to SDHI1 hardware block */
> > +       __raw_writel(__raw_readl(SMSTPCR3) & ~(1 << 13), SMSTPCR3);
> 
> ...and these are sh7372 specific.
> 
> If possible I'd like to reuse your SDHI code on sh73a0, so please
> consider splitting up the code in a SDHI specific portion and in a
> processor specific portion.

Sure.
