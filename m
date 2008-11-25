From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 25 Nov 2008 20:26:32 +0000
Subject: Re: HP Jornada 600-series bisected
Message-Id: <20081125222726.b5b24b9f.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__25_Nov_2008_22_27_26_+0100_0RA6EekiWHVbJB/L"
List-Id: <linux-sh.vger.kernel.org>
References: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
In-Reply-To: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
To: linux-sh@vger.kernel.org

--Signature=_Tue__25_Nov_2008_22_27_26_+0100_0RA6EekiWHVbJB/L
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Nov 2008 20:11:06 +0000
Matt Fleming <mjf@gentoo.org> wrote:

> On Tue, Nov 25, 2008 at 08:48:21PM +0100, Kristoffer Ericson wrote:
> >=20
> > unsigned int hd64461_irq_demask(u16 mask)
> > {
> >     unsigned int i;
> >=20
> > 	for (i =3D 1; i < 16; i++)
> > 		if ((1 << i) & mask)
> > 		break;
> >=20
>=20
> Is there a reason that this starts from i =3D 1 and not i =3D 0?

Only 14,12,13,11,10,9,6,5 are actually reporting anything so
it could simply run from 5->14. But this 1->16 has been
used previously, most likely to just point out that
the register is 16bit. The reason I haven't changed it
is the fact that hd64465 got more sources, so locking it
down isn't a good idea.

>=20
> >=20
> > void hd64461_irq_request(u16 mask, void (*fn)(int, void *), u16 trigger=
_mask)
> > {
> >     hd64461_irq_set_hand(mask, fn);
> >     hd64461_irq_trigger(mask, trigger_mask);
> >     hd64461_irq_enable(mask);
> > }
>=20
> I can't find any code in the kernel that registers with the current demux
> code. Is this interface still necessary?
>=20
The idea is to use it in the coming hd64461 relevant code (pcmcia/fb/...) so
currently nothing is using it. The above code hasn't been applied anywhere.



--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Tue__25_Nov_2008_22_27_26_+0100_0RA6EekiWHVbJB/L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkksbb4ACgkQPQls10ERAGfQ/wCgqsRF9/depjOk8tvjrZ+n/M33
1WUAoMw7AVACg9Ml3yyZzwUURRNEL4rq
=4Urc
-----END PGP SIGNATURE-----

--Signature=_Tue__25_Nov_2008_22_27_26_+0100_0RA6EekiWHVbJB/L--
