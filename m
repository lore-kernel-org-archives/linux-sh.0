From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 10 Feb 2009 17:29:09 +0000
Subject: Re: [Qemu-devel] Status of SH4 support in repository
Message-Id: <20090210182909.b0dcab10.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__10_Feb_2009_18_29_09_+0100_oZESoScOSEGK5mIt"
List-Id: <linux-sh.vger.kernel.org>
References: <20090209172352.cae23097.kristoffer.ericson@gmail.com>
	<4991B119.9060500@juno.dti.ne.jp>
In-Reply-To: <4991B119.9060500@juno.dti.ne.jp>
To: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Cc: qemu-devel@nongnu.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

--Signature=_Tue__10_Feb_2009_18_29_09_+0100_oZESoScOSEGK5mIt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Feb 2009 01:53:45 +0900
Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp> wrote:

> Hi, Kristoffer.
>=20
> Kristoffer Ericson wrote:
> > Greetings,
> >=20
> > Just interested in an update of the current status. I built a fresh qem=
u from
> > the repository today and Im currently I get no output.=20
>=20
> I do not catch 'no output' mean.  Could you explain it more?
>=20
> FYI, here's the log how I built qemu-sh at Feb. 6th.
>   http://www.assembla.com/wiki/show/qemu-sh4/BuildingEnvironment

My mistake I did something wrong when I built it earlier, currently
it works somewhat. What doesnt work is keyboard,mouse and booting
from image file (seems like to bootstring isnt being aknowledged).

>=20
> # It would be better to put such kind of information on Linux-SH Wiki's
> # QEMU page.
>=20
> Regards,
> Shin-ichiro KAWASAKI
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Tue__10_Feb_2009_18_29_09_+0100_oZESoScOSEGK5mIt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmRuWUACgkQPQls10ERAGctuwCeLduoFEH0GSpwFRN10P2rboFX
LJwAni4JfTa6gsFka0czthCmSJzjFLtr
=cyz3
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Feb_2009_18_29_09_+0100_oZESoScOSEGK5mIt--
