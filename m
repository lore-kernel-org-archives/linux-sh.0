From: Mark Brown <broonie@kernel.org>
Date: Thu, 19 Feb 2015 10:33:46 +0000
Subject: Re: [PATCH/RFC 2/2] regulator: da9210: Add optional interrupt support
Message-Id: <20150219103346.GE3198@finisterre.sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="d8Lz2Tf5e5STOWUP"
List-Id: <linux-sh.vger.kernel.org>
References: <1424175072-14643-1-git-send-email-geert+renesas@glider.be>
 <1424175072-14643-2-git-send-email-geert+renesas@glider.be>
 <20150217140110.GV9110@finisterre.sirena.org.uk>
 <CAMuHMdXOFVZWn+u4wyz4Ro_kS_LaWc4Mwrq-XZU3dPpjmX2E3w@mail.gmail.com>
In-Reply-To: <CAMuHMdXOFVZWn+u4wyz4Ro_kS_LaWc4Mwrq-XZU3dPpjmX2E3w@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Steve Twiss <stwiss.opensource@diasemi.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2015 at 03:18:40PM +0100, Geert Uytterhoeven wrote:
> Hi Mark,
>=20
> On Tue, Feb 17, 2015 at 3:01 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Feb 17, 2015 at 01:11:12PM +0100, Geert Uytterhoeven wrote:

> >>   - Does there exist any regulator notifier event that corresponds to
> >>     DA9210_E_VMAX?

> > What does that mean, I might be able to tell you?  I guess it might be
> > an over voltage event...

> Possibly. There's no regulator notifier event for that yet, though.
> Shall I add one?

I'm wondering if it may be better to change the first notification to
just a general "out of regulation" one, though the consequences of over
voltage are usually different to under voltage if that is what's going
on here.

> Anyway, let's wait for confirmation from Dialog...

I guess - is there really no indication in the datasheet?

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU5bwKAAoJECTWi3JdVIfQ77IH/2/IzJD58yXSM+ZxcUoUne8m
VzkM74eWtVjKuEWsn3wRKxZRllzqMGssoljCPvswQy5iergLAFzVCOsBTjzDUz1s
u7iiLGx12anOwcLDvO6PUNNRi/ZQuuQ2bKgOcOJ4Cny3/Ltt2tpKrGvEwo+3BooF
pVgqY3y/z8UahCTFsXIEzNvOb0xv03aqpQsGCei/TtyzcrY+fdVivVM5POxYFcu9
Zm4nTYGWHdZX+GyX4IZXUWvi1u2BrHha+3d6rbxZULvaeqdw91iRrbAvZeaMZjPd
qb8d4qVxkrKm+CV41XgXwMlD5amEWCmHkORPsPN6sE2qraXSeazwCm/JrTANqT4=
=vcEG
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
