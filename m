From: Philippe =?iso-8859-1?q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Date: Tue, 10 Aug 2010 08:45:03 +0000
Subject: Re: [regression] in linux-next: sh_mobile_ceu_camera broken by "ARM: Prohibit ioremap() on kernel ma
Message-Id: <201008101045.03547.philippe.retornaz@epfl.ch>
List-Id: <linux-sh.vger.kernel.org>
References: <4C5ED116.5000002@arndnet.de>
In-Reply-To: <4C5ED116.5000002@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Le dimanche, 8 ao=FBt 2010 17.45:26, Arnd Hannemann a =E9crit :
> Hi Russell,
>=20
> your commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8
> ARM: Prohibit ioremap() on kernel managed RAM
>=20
> lets drivers/base/dma-coherent.c::dma_declare_coherent_memory()
> fail for the sh_mobile_ceu_camera driver (see backtrace below).
> I think, other configurations (i.MX31 users of the mx3_camera driver:
> pcm037 and mx31moboard) will have the same problem.
>=20
> Since I have no idea how to fix this, I post this regression report here.=
..

Have you found a solution to this problem ? As you said, the mx3_camera dri=
ver=20
doesn't work anymore on mx31moboard.

Thanks !=20

Philippe
