From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 13 Jul 2011 12:34:32 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 generic suspend/resume
Message-Id: <20110713123432.GJ23270@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20110707134813.22370.25948.sendpatchset@t400s>
In-Reply-To: <20110707134813.22370.25948.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Jul 13, 2011 at 08:05:04PM +0900, Magnus Damm wrote:
> On Thu, Jul 7, 2011 at 10:50 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jul 07, 2011 at 10:48:13PM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Convert the sh7372 Core Standby code to make use
> >> of the new generic ARM cpu suspend/resume code.
> >
> > Thanks. =A0Only thing which stands out is:
> >
> >> + =A0 =A0 .global sh7372_resume_core_standby
> >> +sh7372_resume_core_standby:
> >> + =A0 =A0 ldr =A0 =A0 pc, 1f
> >> +1: =A0 .long =A0 cpu_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET
> >
> > Is this because sh7372_resume_core_standby must be ARM stuff, but
> > cpu_resume may be Thumb?
>=20
> That may have something to do with it, but I suspect not. Perhaps you
> wonder why I'm not pointing the reset vector directly to cpu_resume()
> - that's because we need the reset vector to be aligned to 4k.

Wouldn't a simple branch instruction do here?  Branches are relative
(within 24-bit) so you wouldn't need any games with v:p stuff.  You
may have to put that in .data so that it can reach cpu_resume if
you're using a large initramfs image.

> I simply nicked the PA->VA conversion code from the SMP entry code in hea=
dsmp.S:
>=20
> 	.align  12
> ENTRY(shmobile_secondary_vector)
> 	ldr     pc, 1f
> 1:	.long   secondary_startup - PAGE_OFFSET + PLAT_PHYS_OFFSET
>=20
> Any suggestions?

Again, a simple branch instruction should avoid the need to reference
PLAT_PHYS_OFFSET or virtual addresses.
