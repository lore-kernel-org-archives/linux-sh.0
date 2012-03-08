From: Thomas Schwinge <thomas@codesourcery.com>
Date: Thu, 08 Mar 2012 14:22:08 +0000
Subject: Re: Migo-R (SH7722) vs. NUMA
Message-Id: <87vcmfmaun.fsf@schwinge.name>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-sh.vger.kernel.org>
References: <8762egpvhn.fsf@schwinge.name>
In-Reply-To: <8762egpvhn.fsf@schwinge.name>
To: linux-sh@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

On Thu, 8 Mar 2012 00:04:28 -0800, Kuninori Morimoto <kuninori.morimoto.gx@=
renesas.com> wrote:
> > > I forgot detail of MIGO-R.
> > > But in my quick check,
> > > my MIGO-R .config doesn't have CONFIG_NUMA since around v2.6.32-rc5
> >=20
> > Hmm, where do you see/check that?
> >=20
> >     $ git blame -L /^CONFIG_NUMA/,+1 v3.2 -- arch/sh/configs/migor_defc=
onfig=20
> >     70f784ec (Magnus Damm 2008-02-07 00:38:24 +0900 16) CONFIG_NUMA=3Dy
>=20
> Ahh.. sorry for my confusion.
> It was not migor_defconfig.
> It is my local .config series which worked correctly on migo-r each linux=
 version :)
> unfortunately (?) defconfig sometimes doesn't work...

I'm not an expert on this, but here is what I think should be done: a)
fix CONFIG_NUMA (apparently it used to work before the commit I
referenced in my original email), or b) tag it as broken/unsupported and
make sure it can't be enabled (and obviously don't enable it in the
default configuration).  Which of the two is it?


Gr=C3=BC=C3=9Fe,
 Thomas

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPWMCQAAoJENuKOtuXzphJBI0H/1hUDS644pQUaFaComC/QsxD
kF7nRaIMUQc3dI+g6s8uJJqfFGZ46u9f1bX5jC1qI+VWdpRzcTocjQStokkFjGjX
8TewCFD83NceHaWLhskUxbuykzcgIUNSjq6sqtxnNZFiozvn2iUM5EP2X9n8BvvM
mFeKV6cokSmL4oJhkYg5mwt6hJTciln81epIwlIxUpCXO48QHP8ch1crcN6Auq11
uoelBsqrJ0UKsKhnxrBXQ4AxdJuD5suxf/AaH1E+EY+S8NURIESfq4nElGU77VIX
fQjXxaETP/vewqmxAW4QM3p6x8L/Km3UVbj6JCzMHkrITRAagu91uV3hD2XVyv4=
=KnHV
-----END PGP SIGNATURE-----
--=-=-=--
