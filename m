From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 10 Aug 2010 21:26:38 +0000
Subject: Re: [regression] in linux-next: sh_mobile_ceu_camera broken by
Message-Id: <20100810212638.GC7702@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <4C5ED116.5000002@arndnet.de>
	<201008101045.03547.philippe.retornaz@epfl.ch>
	<20100810092759.GB31759@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1008102117000.18934@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1008102117000.18934@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, Aug 10, 2010 at 09:55:29PM +0200, Guennadi Liakhovetski wrote:
> Hi Russell
>=20
> On Tue, 10 Aug 2010, Russell King - ARM Linux wrote:
>=20
> > On Tue, Aug 10, 2010 at 10:45:03AM +0200, Philippe R=E9tornaz wrote:
> > > Le dimanche, 8 ao=FBt 2010 17.45:26, Arnd Hannemann a =E9crit :
> > > > Hi Russell,
> > > >=20
> > > > your commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8
> > > > ARM: Prohibit ioremap() on kernel managed RAM
> > > >=20
> > > > lets drivers/base/dma-coherent.c::dma_declare_coherent_memory()
> > > > fail for the sh_mobile_ceu_camera driver (see backtrace below).
> > > > I think, other configurations (i.MX31 users of the mx3_camera drive=
r:
> > > > pcm037 and mx31moboard) will have the same problem.
> > > >=20
> > > > Since I have no idea how to fix this, I post this regression report=
 here...
> > >=20
> > > Have you found a solution to this problem ? As you said, the mx3_came=
ra driver=20
> > > doesn't work anymore on mx31moboard.
> >=20
> > MX3 is ARMv6 which has the architectural restriction as well I'm afraid.
>=20
> So, if I understand this right, you cannot call=20
> dma_declare_coherent_memory() on already mapped RAM on ARM.

It would appear so - unfortunately this API was designed by ARM folk back
in the VIVT cached days when this kind of restriction wasn't present.

> So, to use this on physical RAM we have to remove it from the kernel
> mapping? Would using the "memmap=3D" kernel parameter suffice? Or is
> there a better solution for this?

I don't know what "memmap=3D" is, which suggests that as we don't process
it, it'll do nothing.  (This is one of the problems of
kernel-parameters.txt - it doesn't tell you what are architecture
specific parameters.)

You could instead use mem=3D or omit a chunk of memory from the ATAGs.
However, as I've already covered, because of the brokenness of
sparsemem not being able to handle sparse memory, its implementation
of pfn_valid() will be over-happy to return 'true' even for memory
you've omitted.  Flatmem doesn't suffer this problem.

Or just make the DMA coherent region larger and use that instead (and
the DMA coherent region I hope will be fixed to omit the dual-mapping
for the next merge window.)

But as I've said, the whole "ioremap system RAM" idea has to die.  It's
something that just isn't workable with later ARMs, and it's something
that historically hasn't been supported on x86 either for very similar
reasons (except for very exceptional corner cases.)
