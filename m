From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 12 Mar 2011 22:57:13 +0000
Subject: Re: [PATCH 1/4 v2] mmc: mn57xx: only access registers above 0xff,
Message-Id: <Pine.LNX.4.64.1103122349080.28741@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103110854050.23675@axis700.grange>
 <Pine.LNX.4.64.1103110900080.23675@axis700.grange>
 <AANLkTi=CwkzwvDy+CTzJBni-OtZUMEtmceNr+-xpuVOK@mail.gmail.com>
In-Reply-To: <AANLkTi=CwkzwvDy+CTzJBni-OtZUMEtmceNr+-xpuVOK@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On Sun, 13 Mar 2011, Magnus Damm wrote:

> On Fri, Mar 11, 2011 at 5:09 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Not all mn57xx / tmio implementations have registers above oxff.
> > Accessing them on thise platforms is dangerous. In some cases it leads
> > to address wrapping to addresses below 0x100, which corrupts random
> > unrelated registers.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >
> > v2:
>=20
> > --- a/drivers/mmc/host/tmio_mmc_pio.c
> > +++ b/drivers/mmc/host/tmio_mmc_pio.c
>=20
> Nice, it looks like this patch should apply on your earlier broken out
> patch set...
>=20
> > + =A0 =A0 =A0 if (resource_size(res) > 0x100) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CT=
L, 0x0000);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(10);
> > + =A0 =A0 =A0 }
>=20
> ... but now since you've separated the tmio specific code from the
> SDHI implementation, why don't you just make all the offsets above
> 0x100 stay in the tmio code, and let the SDHI only access below 0xff?

The current split is:

tmio_mmc_pio.c: _all_ driver functionality in PIO mode, including MMC API
tmio_mmc_dma.c: DMA

tmio_mmc.c: _only_ MFD glue - no IO at all

sh_mobile_sdhi.c: _only_ platform glue for SDHI - no IO at all

This split seems logical to me - every file performs one function. But I=20
do agree, that special-casing addresses > 0xff in the generic core is not=20
very nice... We could otherwise modify the actual read / write accessors=20
to check, whether _each_ register address is within the resource, but that =

would be too much of a performance hit. But pulling those couple of > 0xff =

accesses out of the driver proper and into the MFD glue didn't look like a =

very logical thing to me. I thought this version provided both - no=20
performance hit and preserved clean function separation - at the cost of=20
"slight ugliness." Opinions?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
