From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 08 Jan 2009 18:09:28 +0000
Subject: Re: Fw: SH7709 BUG on boot (partially bisected)
Message-Id: <20090108190928.30b8a44e.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__8_Jan_2009_19_09_28_+0100_e+zU.6OLYTqfUvR7"
List-Id: <linux-sh.vger.kernel.org>
References: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
In-Reply-To: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
To: linux-sh@vger.kernel.org

--Signature=_Thu__8_Jan_2009_19_09_28_+0100_e+zU.6OLYTqfUvR7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Jan 2009 07:15:54 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Mon, Jan 05, 2009 at 12:48:26PM +0000, Steve.Glendinning@smsc.com wrot=
e:
> > Thanks Paul,
> >=20
> > With your gcc 4.2.1 toolchain and today's linus git tree my platform's=
=20
> > physmap flash works again.  I also tested the "bad" revision from my=20
> > bisection and this also works fine with gcc 4.2.1.
> >=20
> Good to hear!
>=20
> > I'll use 4.2.1 from now onwards, so I'm happy, but if this is still=20
> > something you still want to fix I'm happy to test patches with 3.4.4.
> >=20

Sorry for the late reply (change of hardware), just
wanted to throw my 2-cents in there. The main problem
for SH3 hardware in the past has been glibc,
any version below glibc 2.3.4 for instance couldnt create
dynamic linked binaries.
My reference toolchain (=3D know it works) is based
on gcc 3.4.5 and glibc 2.3.5.

> I did test these patches with a gcc 3.4.5 version that was fairly close
> to standard, so I expect that the version of 3.4.4 you are using has
> quite a few patches. In any event, gcc 3.x is old enough now that there
> are not many people still building on it, so I wouldn't worry about it.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Thu__8_Jan_2009_19_09_28_+0100_e+zU.6OLYTqfUvR7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklmQVgACgkQPQls10ERAGenoQCguUhSuNpgh3LeO1EKKoYuwT4P
uJ8An0s1hj87qPbiOmyyw2RzFc0vLovO
=4V5D
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Jan_2009_19_09_28_+0100_e+zU.6OLYTqfUvR7--
