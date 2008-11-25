From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 25 Nov 2008 20:19:45 +0000
Subject: Re: HP Jornada 600-series bisected
Message-Id: <20081125221953.c6725dad.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__25_Nov_2008_22_19_53_+0100_UXuPedENVtRiHN7a"
List-Id: <linux-sh.vger.kernel.org>
References: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
In-Reply-To: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
To: linux-sh@vger.kernel.org

--Signature=_Tue__25_Nov_2008_22_19_53_+0100_UXuPedENVtRiHN7a
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2008 04:50:11 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Tue, Nov 25, 2008 at 08:48:21PM +0100, Kristoffer Ericson wrote:
> > On Wed, 26 Nov 2008 02:54:26 +0900
> > Paul Mundt <lethal@linux-sh.org> wrote:
> > > Matt's patch should allow us to fix the __do_IRQ() problem, if you wa=
nt
> > > to build on top of that, that is fine, but it is still helpful to know
> > > whether it works for you with CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ enab=
led.
> > >=20
> > > The only problematic thing I see is the lack of the base IRQ factorin=
g,
> > > only the chained handlers for the multiplexed sources are defined. Th=
is
> > > is the way it should be, but it is possible that there will have to be
> > > another handler set up to at least get the hd64461 IRQ firing. This is
> > > the basis for that silly i =3D=3D 16 thing in the old demux code. Any=
 user
> > > that depends on that behaviour deserves to be broken, though.
> >=20
> > I've attached the code I got so far. You can atleast see my=20
> > approach to the issue.
> >=20
> The approach you use has all of the same problems as the old code in
> terms of how the demux is handled and how it completely sidesteps the
> generic hardirq code.=20

I must be missing something. Last time you said that there wasn't
much point in adding a virtual IRQ range, and thats what
I've been avoiding to do. Everything goes into the HD64461_IRQ
which simply sends "notifier"/runs interrupt of the
mask requesting it. Perhaps I misunderstod in what
way you wanted the mfd to notify the driver.

> Additionally, this is new code, rather than
> refactoring existing code.=20

I can understand that changing existing code is better
than removing->adding new code. But I'm doing this
to get the pcmcia driver inside, which you said wouldn't
happen until the hd64461 was transformed into an MFD driver.
So on one side the hd64461 should be transformed into
an mfd driver and on the other existing approach should
be preserved.

> If Matt's patch doesn't work for you, then we
> just leave CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ disabled for hd64461. If it
> does work however, then you are much better off adopting that code and
> including it in your MFD driver. The main thing is to fix what we have
> in-tree first.

I will test Matt's patch later today and see if it solves it,
It probably will. I mean no disrespect with my comments,
just that its frustrating missing your points all the time.
I don't do this for a living and medical studies doesn't
provide much of a + in these areas.

--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Tue__25_Nov_2008_22_19_53_+0100_UXuPedENVtRiHN7a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkksa/kACgkQPQls10ERAGf8IQCeMxLSUJPLguo7Plif2n28Uc6v
fmwAoNYpzQ9eismSn2M5xzonVPy7JWnh
=vwaJ
-----END PGP SIGNATURE-----

--Signature=_Tue__25_Nov_2008_22_19_53_+0100_UXuPedENVtRiHN7a--
