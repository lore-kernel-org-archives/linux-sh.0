From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 26 May 2010 07:54:48 +0000
Subject: Re: LCDC of 7203
Message-Id: <201005260954.48760.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201005241912.44976.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201005241912.44976.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

There are some low cost LCD having a parallel interface with the synch sign=
als=20
and 16 / 18 bit of data.
The sh2a LCDC can manage such LCD panels

Am I right or not?


In data mercoled=EC 26 maggio 2010 09:34:36, Magnus Damm ha scritto:
: > On Wed, May 26, 2010 at 3:14 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Wed, May 26, 2010 at 02:20:05AM -0400, Magnus Damm wrote:
> >> On Mon, May 24, 2010 at 1:12 PM, Fabio Giovagnini
> >>
> >> <fabio.giovagnini@aurion-tech.com> wrote:
> >> > Hi all,
> >> > I have a little problem with LCDC of sh2a 7203.
> >> > I seem not to see the driver into the last kernel.
> >> > Where could I find a good reference?
> >>
> >> I don't think there is any upstream 7203 LCDC driver. It's a shame, I
> >> really wish people would submit their code upstream.
> >
> > I don't remember the details specifically, I thought the issue was panel
> > control via MSIOF and so on, which isn't too different from G3EVM?
>=20
> Some LCD panels come with a dedicated control channel over SPI/I2C,
> and some have their control channel muxed with pixel data like SYS or
> MIPI.
>=20
> I think rsk7203 dealt with the LCD panel setup over SPI, and most
> likely that SPI channel was hooked up to an SIOF or SIO. The MSIOF
> only exists on newer SH-Mobiles, so we would need a new SPI driver for
> SIOF or whatever is there to begin with. Perhaps the easiest is just
> to use an GPIO bitbang driver, but that requires pinmux support which
> probably is in place on some sh2a processor at least.
>=20
> > The existing "drivers" are much like the early G3EVM LCD support, so
> > while references are readily available, there's little that is directly
> > usable without some serious work on the infrastructure side. Perhaps we
> > can reuse parts of the SH-Mobile LCD support?
> >
> >From my POV, the biggest showstopper is that the SPI code is lacking
>=20
> support for using the bus without the driver model. I2C allows this,
> good or bad. It's sort of a hack, but there is nothing better
> available either. With I2C we can have some board specific support
> code for the LCD panel like the hack on Migo-R. This is not possible
> with SPI AFAIK.
>=20
> Perhaps the proper way is to add the LCD panel to the driver model and
> then write a normal SPI driver for the LCD, but that brings up init
> order issues.
>=20
> The G3EVM code is setting up the LCD panel using the MSIOF in SPI
> mode. The original code just accessed the MSIOF directly, but we
> should be able to use the SPI driver instead. The MSIOF hardware block
> on SH-Mobile ARM is unfortunately not working well with the MSIOF
> driver, so it's a bit of a mess. SPI bitbang could be useful in this
> case too though if the SPI-without-driver-model could be sorted out.
>=20
> I think the MIPI work by Guennadi is one step in the right direction.
>=20
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
