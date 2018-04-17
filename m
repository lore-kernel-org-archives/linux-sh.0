From: jacopo mondi <jacopo@jmondi.org>
Date: Tue, 17 Apr 2018 14:39:10 +0000
Subject: Re: [PATCH] sh: migor: Set DMA and DMA coherent mask
Message-Id: <20180417143910.GC3519@w540>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="96YOpH+ONegL0A3E"
List-Id: <linux-sh.vger.kernel.org>
References: <1523974393-10870-1-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUqGgovaorxXDSCPK3dg2PLQwYoxm1mQdj=Dqi1-sDE7g@mail.gmail.com>
In-Reply-To: <CAMuHMdUqGgovaorxXDSCPK3dg2PLQwYoxm1mQdj=Dqi1-sDE7g@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Geert,

On Tue, Apr 17, 2018 at 04:30:03PM +0200, Geert Uytterhoeven wrote:
> Hi Jacopo,
>
> CC Christoph
>
> On Tue, Apr 17, 2018 at 4:13 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > As of commit 205e1b7f51e4 ("dma-mapping: warn when there is no
> > coherent_dma_mask") the Migo-R platform devices registered without a DMA
> > mask and coherent DMA mask issue the following warning
> >
> > WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 0x40159e20
> >
> > Set dma mask and coherent DMA mask for Migo-R platforms devices to 32
> > bits as all other SH4a platforms do.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I guess usbf_device.dev.dma_mask should be fixed as well?

I don't get any warning for that. The only platform devices on which
platform_resource_setup_memory() is called on before registering them
are the ones this patch modifies, if I'm not wrong.

>
> BTW, there are plenty of other SH platforms that need similar fixes.

Oh, why am I not surprised? :/

Thanks
   j

>
> > ---
> >  arch/sh/kernel/cpu/sh4a/setup-sh7722.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
> > index 6b3a26e..3fe1ea7 100644
> > --- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
> > +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
> > @@ -7,6 +7,7 @@
> >   * License.  See the file "COPYING" in the main directory of this archive
> >   * for more details.
> >   */
> > +#include <linux/dma-mapping.h>
> >  #include <linux/init.h>
> >  #include <linux/mm.h>
> >  #include <linux/platform_device.h>
> > @@ -347,6 +348,8 @@ static struct platform_device vpu_device = {
> >         .name           = "uio_pdrv_genirq",
> >         .id             = 0,
> >         .dev = {
> > +               .dma_mask               = &vpu_device.dev.coherent_dma_mask,
> > +               .coherent_dma_mask      = DMA_BIT_MASK(32),
> >                 .platform_data  = &vpu_platform_data,
> >         },
> >         .resource       = vpu_resources,
> > @@ -375,6 +378,8 @@ static struct platform_device veu_device = {
> >         .name           = "uio_pdrv_genirq",
> >         .id             = 1,
> >         .dev = {
> > +               .dma_mask               = &veu_device.dev.coherent_dma_mask,
> > +               .coherent_dma_mask      = DMA_BIT_MASK(32),
> >                 .platform_data  = &veu_platform_data,
> >         },
> >         .resource       = veu_resources,
> > @@ -403,6 +408,8 @@ static struct platform_device jpu_device = {
> >         .name           = "uio_pdrv_genirq",
> >         .id             = 2,
> >         .dev = {
> > +               .dma_mask               = &jpu_device.dev.coherent_dma_mask,
> > +               .coherent_dma_mask      = DMA_BIT_MASK(32),
> >                 .platform_data  = &jpu_platform_data,
> >         },
> >         .resource       = jpu_resources,
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

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa1gcOAAoJEHI0Bo8WoVY8nmYP/jkMsvdFjnqbrfEqBSi1l914
rnXw654LqET2WryDLB/VgctQGzv4NBpZ6gWSMsos5WB1S+Vp6VSyS7BOll+PIkYN
+GOz0FcHb193vxKOgpqF3aO0j576C90bDyE1RUqWlLWc/vWSbN3j2OpkXBasBh9f
Ov0L8v6vq6KZJKxGqsX6ED4bHUUPAdAL3HKWvgJF6dtxYwC99kZxMcxIKe/3VHvO
84I7qKlMaivBSDXBUEDZFvPPhtKXlVZT2u37BPpOBLV0h8QFjVPtWWPs87Cp18tP
Ho9NNImM+SK/7lCzHgFCeSVE/RCvquFQ5NYQC4/EtUXnoq/jRIpR4ljm/Nd66391
OifPTvo7mUWcsZMKUb6VaT9SyRRZQXg6Mg3Qgi5pts5iZ7WY7zP+93IjEV05arD9
i57HwlUS4uhllGPHtLdSqkMu4F4E6Q0Q+XIZ3TAkV2tiz2YMgO5bU5w/Yy47JT1e
yrqU5EC9nt0xAS7u0UaFzuoxeCHOiUGnn+LQCeRbhzaxd7+jZG1+QSal7UNjI+15
8S4ht/TBEL+ykPob2cQT4fRtzzGtrTzE2BLEYEXzwBPE14R4RslxhyRqkqvp0X21
lCoY2KFnPWJEedGrO6eVmi0r1AmNnaDPC5ce1Ey93yVxgS4VmcO954t6IXrxnMR+
NlgDgNeIoICCZ+oG1jQA
=+l8n
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
