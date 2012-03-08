From: Thomas Schwinge <thomas@codesourcery.com>
Date: Thu, 08 Mar 2012 07:07:36 +0000
Subject: Re: Migo-R (SH7722) vs. NUMA
Message-Id: <87ipifo9jb.fsf@schwinge.name>
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

On Wed, 7 Mar 2012 17:24:30 -0800, Kuninori Morimoto <kuninori.morimoto.gx@=
renesas.com> wrote:
> > I've been working on upgrading the kernel for our Migo-R (SH7722) board
> > From ancient 2.6.30.6 to something more modern, 3.2.  But, based on
> > migor_defconfig, it wouldn't boot, and instead just hang after the boot
> > loader.  I bisected this to commit
> > 19d8f84f86af867abee174be8bf1e4941a59143d (2010-05-10).  (To build this
> > tree, you need to cherry-pick 06225c08ec2ad0f0dec063df7f08773a8358db12
> > and apply the equivalent of c77b29db74a0ea4fdce0564a63b8876798625d64 to
> > arch/sh/kernel/setup.c.)
> >=20
> > By chance I figured out that disabling NUMA support (which is enabled f=
or
> > migor_defconfig) would make it work again for this tree, as well as lat=
er
> > versions, such as the 3.2 release.  I guess this should be fixed
> > properly?
>=20
> I forgot detail of MIGO-R.
> But in my quick check,
> my MIGO-R .config doesn't have CONFIG_NUMA since around v2.6.32-rc5

Hmm, where do you see/check that?

    $ git blame -L /^CONFIG_NUMA/,+1 v3.2 -- arch/sh/configs/migor_defconfi=
g=20
    70f784ec (Magnus Damm 2008-02-07 00:38:24 +0900 16) CONFIG_NUMA=3Dy


Gr=C3=BC=C3=9Fe,
 Thomas

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPWFq4AAoJENuKOtuXzphJv1UH/2sO4pqGgazS9oWd36TqpPRR
uG6k+K/clAjPFQbJ+82ooFvIaAbTYTQ4hpKZ1zCztevAqkib8FBWfWTbyzxqs3kd
CTLAB2Yg8q9q0MsVmGg3loKhe1cSOnrUGixvNNsetPrnQVInTVT6AQbwUNDDAewk
PNtqsed7d3hXbUm9hyD7M1V71Orx1QaA0Y+HZTAj5l73+EAnhPObP8rSkCMkVd/3
uk09XWcVa9d8wYtkrVpJUUHG7QP8C7tU2g34eI3qolDo0NmfXQCo81ceWPGHGKmG
6Nx8Vc6lS37HKDs8YpjuPc4Kmy0RhXQD0Uwhw6uGJJj40lvVEqeMN8vTMe6wDvo=
=wbBO
-----END PGP SIGNATURE-----
--=-=-=--
