From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 10 Aug 2010 19:55:29 +0000
Subject: Re: [regression] in linux-next: sh_mobile_ceu_camera broken by "ARM:
Message-Id: <Pine.LNX.4.64.1008102117000.18934@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4C5ED116.5000002@arndnet.de>
	<201008101045.03547.philippe.retornaz@epfl.ch>
	<20100810092759.GB31759@n2100.arm.linux.org.uk>
In-Reply-To: <20100810092759.GB31759@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Russell

On Tue, 10 Aug 2010, Russell King - ARM Linux wrote:

> On Tue, Aug 10, 2010 at 10:45:03AM +0200, Philippe R=E9tornaz wrote:
> > Le dimanche, 8 ao=FBt 2010 17.45:26, Arnd Hannemann a =E9crit :
> > > Hi Russell,
> > >=20
> > > your commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8
> > > ARM: Prohibit ioremap() on kernel managed RAM
> > >=20
> > > lets drivers/base/dma-coherent.c::dma_declare_coherent_memory()
> > > fail for the sh_mobile_ceu_camera driver (see backtrace below).
> > > I think, other configurations (i.MX31 users of the mx3_camera driver:
> > > pcm037 and mx31moboard) will have the same problem.
> > >=20
> > > Since I have no idea how to fix this, I post this regression report h=
ere...
> >=20
> > Have you found a solution to this problem ? As you said, the mx3_camera=
 driver=20
> > doesn't work anymore on mx31moboard.
>=20
> MX3 is ARMv6 which has the architectural restriction as well I'm afraid.

So, if I understand this right, you cannot call=20
dma_declare_coherent_memory() on already mapped RAM on ARM. So, to use=20
this on physical RAM we have to remove it from the kernel mapping? Would=20
using the "memmap=3D" kernel parameter suffice? Or is there a better=20
solution for this?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
