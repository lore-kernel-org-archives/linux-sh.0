From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 23 Apr 2014 07:18:13 +0000
Subject: Re: [PATCH 22/33] ARM: shmobile: Use r8a7740 suffix for i2c, mmcif, fsi2 compat strings
Message-Id: <20140423071813.GA2777@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
 <5c53f50c50badff499568a703467c3c9f23f9bfd.1398216022.git.horms+renesas@verge.net.au>
 <CAMuHMdUA+wJmgn0P_q38ri7_TAq7zha-ekSUrvdpntG5gFv56Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUA+wJmgn0P_q38ri7_TAq7zha-ekSUrvdpntG5gFv56Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2014 at 09:09:49AM +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 23, 2014 at 3:25 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Ulrich Hecht <ulrich.hecht@gmail.com>
> >
> > Add "renesas,*-r8a7740" to the compatible strings for consistency with =
other
> > devices.
>=20
> > diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740=
=2Edtsi
> > index 8280884..9f65986 100644
> > --- a/arch/arm/boot/dts/r8a7740.dtsi
> > +++ b/arch/arm/boot/dts/r8a7740.dtsi
> > @@ -126,7 +126,7 @@
>=20
> > -               compatible =3D "renesas,rmobile-iic";
> > +               compatible =3D "renesas,iic-r8a7740", "renesas,rmobile-=
iic";
>=20
> I see an opportunity for improvement here: this driver doesn't seem to ha=
ve
> any bindings documented under Documentation/devicetree/bindings/?

I am brushing up this driver currently, so consider it done. Just
waiting for a minor email issue to be solved before I can send out
patches.


--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTV2k0AAoJEBQN5MwUoCm2s6kQAJhXmoPYYh34wLh7CmN2vE6k
TPlG89jeJLB07+t1TMFbLRac5h69WlH/APM74OuSNzIABy1OmBgTs5yesoT5dzF2
AcgCpA7IdQDglhA37URAFlWf6obzzkQkowOKeJ447Hn3XmXEAc8N0ON8dCKKvdVC
9uK7jlXX4PqZaTl3XhtgIuVbqo5OrdwRUkYXJfiAxSMWUx93FnxC9kDCVnpISA6T
oOha3LaUgBfKxXoAey9VF4gDBHqHtQuR5rf5lPtMRDc+jbguL4gTCFSlniGyhqwx
VCSmetVliGU928dnEKRor3RaJwpEeh2kOdTqIrvXk8Ubpg4rl2sU7LjoXpDDZMEY
ksxb9l3U/9fbn0xCzdNwhGBRfybsy8R+1F9nNmrYB3mxRGU9O/9T8uwuhZVRqhDT
ZD9vbEY8hVqV1ERc/f+ZV/zTpDhbfWlvD/5eEQ9dGPMgiJLrA+mXHqiauDKcIXs0
nY3Dk5Xj9luKokAOj+zQlmNesC1trHSp9heoI6mUPiePHZpP/kdm5Zag0v0nmYwi
ZFKNck/wPp1iwY6vMLZ/tURPvwiQ89Og3X//FL2667qVFB9fFe5MhhJjSLzriuvy
mhRIZXuyN99Z8CwFWadP1HLyX1Mp1pI4M1Ic4zoqxqW9SdFAhRLXAKvlOgq9FDvw
aHXinY7YAmkNAFMAM/x6
=DJzU
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
