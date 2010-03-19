From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Mar 2010 08:16:46 +0000
Subject: Re: [PATCH 01/05] dmaengine: shdma: Remove sh_dmae_slave_chan_id
Message-Id: <Pine.LNX.4.64.1003190913130.4490@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20100319044638.17051.97049.sendpatchset@t400s>
In-Reply-To: <20100319044638.17051.97049.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, 19 Mar 2010, Magnus Damm wrote:

> Hey Guennadi,
>=20
> On Fri, Mar 19, 2010 at 4:30 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Fri, 19 Mar 2010, Magnus Damm wrote:
> >> --- 0001/arch/sh/include/asm/dmaengine.h
> >> +++ work/arch/sh/include/asm/dmaengine.h =A0 =A0 =A02010-03-18 23:30:4=
6.000000000 +0900
> >> @@ -17,7 +17,7 @@
> >>
> >> =A0#define SH_DMAC_MAX_CHANNELS 6
> >>
> >> -enum sh_dmae_slave_chan_id {
> >> +enum {
> >> =A0 =A0 =A0 SHDMA_SLAVE_SCIF0_TX,
> >> =A0 =A0 =A0 SHDMA_SLAVE_SCIF0_RX,
> >> =A0 =A0 =A0 SHDMA_SLAVE_SCIF1_TX,
> >> @@ -38,7 +38,7 @@ enum sh_dmae_slave_chan_id {
> >> =A0};
> >>
> >> =A0struct sh_dmae_slave_config {
> >> - =A0 =A0 enum sh_dmae_slave_chan_id =A0 =A0 =A0slave_id;
> >> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0slave_id;
> >
> > I think, INT_MAX DMA slave IDs will be enough;) So, you could just use =
an
> > int to save typing and to reserve -1 (or -EINVAL) as an invalid DMA ID.=
 As
> > I am currencly realising, it can be useful, e.g., if you want to enable
> > DMA only on Rx and not on Tx of some device. This, of course, throughout
> > this patch.
>=20
> Reserving some number sounds like a good plan, but exactly what is the
> best is a different question. If I'm allowed to nitpick then I think
> its wasteful to use one bit for the sign when only needing one value
> to mark unused. So I'd prefer to go with unsigned and 0 as unused mark
> and the rest as valid ids.

Well, personally I somewhat dislike using 0 as an invalid ID (or invalid=20
IRQ...). Then you have to remember to use an offset:

	if ((unsigned)slave_id >=3D SHDMA_SLAVE_NUMBER)

gets an oddition of "|| !slave_id", and you're wasting one bit in=20
sh_dmae_slave_used[];) And, as I said - extra typing:)

> >> --- 0001/drivers/dma/shdma.c
> >> +++ work/drivers/dma/shdma.c =A02010-03-18 23:30:46.000000000 +0900
> >> @@ -266,7 +266,7 @@ static struct sh_desc *sh_dmae_get_desc(
> >> =A0}
> >>
> >> =A0static struct sh_dmae_slave_config *sh_dmae_find_slave(
> >> - =A0 =A0 struct sh_dmae_chan *sh_chan, enum sh_dmae_slave_chan_id sla=
ve_id)
> >> + =A0 =A0 struct sh_dmae_chan *sh_chan, struct sh_dmae_slave *param)
> >
> > This doesn't seem to be needed, at least, not in this patch.
>=20
> Well, I have to change the function to something, no? =3D)

Yes, orry, I mean make it

	struct sh_dmae_chan *sh_chan, int slave_id)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
