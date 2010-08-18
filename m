From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Aug 2010 19:23:25 +0000
Subject: Re: [regression] in linux-next: sh_mobile_ceu_camera broken by "ARM:
Message-Id: <Pine.LNX.4.64.1008182107210.17895@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4C5ED116.5000002@arndnet.de>
	<201008101045.03547.philippe.retornaz@epfl.ch>
	<20100810092759.GB31759@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1008102117000.18934@axis700.grange>
	<20100810212638.GC7702@n2100.arm.linux.org.uk>
In-Reply-To: <20100810212638.GC7702@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Resuming the week-old thread, to try to get a solution for this problem=20
for 2.6.36.

On Tue, 10 Aug 2010, Russell King - ARM Linux wrote:

> On Tue, Aug 10, 2010 at 09:55:29PM +0200, Guennadi Liakhovetski wrote:
> > Hi Russell
> >=20
> > On Tue, 10 Aug 2010, Russell King - ARM Linux wrote:
> >=20
> > > On Tue, Aug 10, 2010 at 10:45:03AM +0200, Philippe R=E9tornaz wrote:
> > > > Le dimanche, 8 ao=FBt 2010 17.45:26, Arnd Hannemann a =E9crit :
> > > > > Hi Russell,
> > > > >=20
> > > > > your commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8
> > > > > ARM: Prohibit ioremap() on kernel managed RAM
> > > > >=20
> > > > > lets drivers/base/dma-coherent.c::dma_declare_coherent_memory()
> > > > > fail for the sh_mobile_ceu_camera driver (see backtrace below).
> > > > > I think, other configurations (i.MX31 users of the mx3_camera dri=
ver:
> > > > > pcm037 and mx31moboard) will have the same problem.
> > > > >=20
> > > > > Since I have no idea how to fix this, I post this regression repo=
rt here...
> > > >=20
> > > > Have you found a solution to this problem ? As you said, the mx3_ca=
mera driver=20
> > > > doesn't work anymore on mx31moboard.
> > >=20
> > > MX3 is ARMv6 which has the architectural restriction as well I'm afra=
id.
> >=20
> > So, if I understand this right, you cannot call=20
> > dma_declare_coherent_memory() on already mapped RAM on ARM.
>=20
> It would appear so - unfortunately this API was designed by ARM folk back
> in the VIVT cached days when this kind of restriction wasn't present.
>=20
> > So, to use this on physical RAM we have to remove it from the kernel
> > mapping? Would using the "memmap=3D" kernel parameter suffice? Or is
> > there a better solution for this?
>=20
> I don't know what "memmap=3D" is, which suggests that as we don't process
> it, it'll do nothing.  (This is one of the problems of
> kernel-parameters.txt - it doesn't tell you what are architecture
> specific parameters.)
>=20
> You could instead use mem=3D or omit a chunk of memory from the ATAGs.
> However, as I've already covered, because of the brokenness of
> sparsemem not being able to handle sparse memory, its implementation
> of pfn_valid() will be over-happy to return 'true' even for memory
> you've omitted.  Flatmem doesn't suffer this problem.

Ok, so, this would work on flatmem (which is what platforms, that I know=20
use this API for video buffer allocation), but is not very elegant.

> Or just make the DMA coherent region larger and use that instead (and
> the DMA coherent region I hope will be fixed to omit the dual-mapping
> for the next merge window.)

Sorry, don't quite understand. Currently what those platforms do is they=20
allocate at platform init time a sufficient DMA doherent region per

	buf =3D dma_alloc_coherent(NULL, buf_size, &dma_handle, GFP_KERNEL);

and then "assign" it to the video platform device per

	dma =3D dma_declare_coherent_memory(&mx3_camera.dev,
					dma_handle, dma_handle, buf_size,
					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);

Now the driver will be able to use the videobuf-dma-contig video-buffer=20
allocation, which does

	mem->vaddr =3D dma_alloc_coherent(q->dev, mem->size,
					&mem->dma_handle, GFP_KERNEL);

The sole purpose of the preallocation in the platform code is to avoid=20
memory fragmentation. Sorry, if I'm repeating obvious things. So, we are=20
already allocating DMA coherent memory. The ioremap() problem in this case =

is actually bogus - we do not need that ioremap(). The problem would be=20
solved, if ioremap() would just not be called in these cases. This is what =

the drivers/staging/dt3155v4l/dt3155vfl.c driver is open-coding in its=20
dt3155_alloc_coherent() function, as pointed out by Marin Mitov (CCed) in=20
another thread. So, would it be acceptable to provide a second function,=20
doing exactly the same as dma_declare_coherent_memory() but without an=20
ioremap(), or add a new DMA_MEMORY_... flag to skip ioremap() in=20
dma_declare_coherent_memory(), as suggested by Uwe (CCed too)?

> But as I've said, the whole "ioremap system RAM" idea has to die.  It's
> something that just isn't workable with later ARMs, and it's something
> that historically hasn't been supported on x86 either for very similar
> reasons (except for very exceptional corner cases.)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
