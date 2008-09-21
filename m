From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 21 Sep 2008 21:18:00 +0000
Subject: Re: Kernel configurations for R2D PLUS with Compact Flush support
Message-Id: <20080921211759.GA10271@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48D60BEA.2040806@juno.dti.ne.jp>
In-Reply-To: <48D60BEA.2040806@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Sun, Sep 21, 2008 at 10:24:21PM +0900, Shin-ichiro KAWASAKI wrote:
> Thanks for your quick answers!
> I've started to investigate pata_platform.c and libata-sff.c.
> It will takes some time for me to understand them.
>=20
> >Note that you can optionally just hand in 0 for the IRQ in order to
> >disable IRQ mode and simply default to polling (which the following patch
> >does).
>=20
> Do you mean that polling by kernel will let us skip the implementation of
> IRQ part of the CF support?  It sounds good to make progress step by step.
>=20
Correct. On R2D boards the CF IRQ is routed through an FPGA, where some
earlier versions of the board have buggy FPGA logic, and we just don't
bother hooking up the IRQ at all. pata_platform takes an optional
IORESOURCE_IRQ, so if one is not provided, polling is used instead.

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=ABac3f784f11cf8ccca0fc37ae4f5ff04cc245c4

Given that, the easiest solution is probably for the qemu defconfig to
set V1 of the board to automatically enable the polling logic, then
switch that back to enabling R2D+ support at a later point when the
system emulator handles the IRQ correctly.

> >>Any help or comments will be welcome.  Thanks.
> >>
> >I had the same idea on the flight back from kernel summit :-)
> >
> >So, how about something like this for a start?
>=20
> Good!  It will be the first part of the patches for CF support.
>=20
> >+
> >+    isa_ide_init(ide_iobase[0], ide_iobase[1], 0, hd[0], NULL);
> >+
>=20
> This part seems to cause a segmentation fault, perhaps you know.
> I guess that the reason is that isa_ide_init() handles the iobase
> as I/O port number, not a memory mapped I/O address.
>=20
Indeed. It was intended more as a proof of concept than anything else.
MMIO is certainly the way it wants to go.

> hw/ide.c:pmac_init_ide() handles the memory mapped I/O.
> So, instead of invoking isa_ide_init(), following (dirty) lines
> will work to avoid the fault.
>=20
> {
>    int ide_memory =3D pmac_ide_init(&hd[0], 0 /* no irq */);
>    cpu_register_physical_memory(ide_iobase[0], 0x1000, ide_memory);
> }
>=20
That looks like a better approach, yes. It's probably worth generalizing
the pmac_ide code so it's something more like mmio_ide, as it's fairly
generic. One of the things to watch out for is the I/O port shifting (see
ioport_shift in the pata_platform info).
