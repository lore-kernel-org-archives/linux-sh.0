From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 22 Apr 2010 06:28:18 +0000
Subject: Re: [PATCH 2/8] SH: add DMA slave IDs for two SDHI controllers, add
Message-Id: <Pine.LNX.4.64.1004220824200.4655@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
 <Pine.LNX.4.64.1004211732340.5292@axis700.grange>
 <j2xaec7e5c31004211702v9ba71743jedd24562f8dea0a5@mail.gmail.com>
In-Reply-To: <j2xaec7e5c31004211702v9ba71743jedd24562f8dea0a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

On Wed, 21 Apr 2010, Magnus Damm wrote:

> Hi Guennadi,
>=20
> On Wed, Apr 21, 2010 at 11:36 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > SuperH SDHI controllers can use DMA, add slave IDs to the header and sl=
ave
> > definitions to sh7722.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > =A0arch/sh/include/asm/dmaengine.h =A0 =A0 =A0 =A0| =A0 =A04 ++++
> > =A0arch/sh/kernel/cpu/sh4a/setup-sh7722.c | =A0 10 ++++++++++
> > =A02 files changed, 14 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/sh/include/asm/dmaengine.h b/arch/sh/include/asm/dmae=
ngine.h
> > index 2a02b61..876e601 100644
> > --- a/arch/sh/include/asm/dmaengine.h
> > +++ b/arch/sh/include/asm/dmaengine.h
> > @@ -29,6 +29,10 @@ enum {
> > =A0 =A0 =A0 =A0SHDMA_SLAVE_SIUA_RX,
> > =A0 =A0 =A0 =A0SHDMA_SLAVE_SIUB_TX,
> > =A0 =A0 =A0 =A0SHDMA_SLAVE_SIUB_RX,
> > + =A0 =A0 =A0 SHDMA_SLAVE_SDHI0_RX,
> > + =A0 =A0 =A0 SHDMA_SLAVE_SDHI0_TX,
> > + =A0 =A0 =A0 SHDMA_SLAVE_SDHI1_RX,
> > + =A0 =A0 =A0 SHDMA_SLAVE_SDHI1_TX,
> > =A0};
> >
> > =A0#endif
>=20
> Thanks for your work on this. Two SDHIs may be enough for most
> processor types, but I think the G3 processor actually has three. With
> that in mind, I think it makes more sense to keep the slave ids
> together with the processor specific bits in for instance
> arch/sh/include/cpu-sh4/cpu/sh7722.h.
>=20
> If you have time, can you please make a patch that moves the slave ids
> into the processor specific header files? This on top of the other
> code in the sh/dmaengine topic branch.

Ok, yes, first, I forgot to mention - this patch series is based on your=20
earlier SH dmaengine patches. Secondly - sure, we can move these defines=20
in cpu-specific headers, otoh - why? This is just an enum, it doesn't take =

space in binaries, and having them all together helps uniformity and=20
avoids duplication, I think. So, I would just add those SDHI2 macros to=20
this list. The important thing is, the actual slave definition array are=20
per-CPU. Which is now the case after your patch series.

> With that in place it will be easy to extend each processor type by
> itself without having to tie in dependencies on a single asm file.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
