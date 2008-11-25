From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 25 Nov 2008 17:40:16 +0000
Subject: Re: HP Jornada 600-series bisected
Message-Id: <20081125194039.a692a760.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__25_Nov_2008_19_40_39_+0100__Yojd.D7yQWsV4Gj"
List-Id: <linux-sh.vger.kernel.org>
References: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
In-Reply-To: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
To: linux-sh@vger.kernel.org

--Signature=_Tue__25_Nov_2008_19_40_39_+0100__Yojd.D7yQWsV4Gj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Nov 2008 16:49:52 +0000
Matt Fleming <mjf@gentoo.org> wrote:

> On Fri, Nov 21, 2008 at 04:34:45PM +0900, Paul Mundt wrote:
> >=20
> > So, pending a rewrite of hd64461, we should probably just leave the
> > __do_IRQ() dispatch as an option there, until someone gets around to
> > rewriting that mess. I will conditionalize it on !HD64461 for now.
>=20
> Kristoffer can you try the attached patch, please? It compiles OK but I
> haven't had chance to test it on actual hardware.

Sorry for the late reply, been having issues with my internet
connection. Anyhow, not sure if this solves anything since
I've already rewritten the IRQ part to be alot more
sensible. Basicly only wanting to get FB going
before I push it upstreams.

What you think Paul?

>=20
>=20


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Tue__25_Nov_2008_19_40_39_+0100__Yojd.D7yQWsV4Gj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkksRqcACgkQPQls10ERAGcFgACePa7e/+NQIWPp342JC9kts6ze
a1EAoLLi2uRsCc8VzBtmJuFHxQBFlODM
=R1hB
-----END PGP SIGNATURE-----

--Signature=_Tue__25_Nov_2008_19_40_39_+0100__Yojd.D7yQWsV4Gj--
