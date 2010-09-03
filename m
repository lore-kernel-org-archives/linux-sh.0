From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Fri, 03 Sep 2010 18:53:32 +0000
Subject: Re: [PATCH 2/7] [RFC] ARM: shmobile: remove unneeded hack to
Message-Id: <20100903185332.GC17152@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTimV5MFqQ+r-uE2M3bVtEqtNfuxq+jkGdW-J8Bis@mail.gmail.com>
In-Reply-To: <AANLkTimV5MFqQ+r-uE2M3bVtEqtNfuxq+jkGdW-J8Bis@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Eric,

On Fri, Sep 03, 2010 at 09:39:45PM +0800, Eric Miao wrote:
> 2010/9/3 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > The calculated value in Makefile.boot isn't used anymore since
> >
> > =A0 =A0 =A0 =A0e69edc79 (ARM: Auto calculate ZRELADDR and provide optio=
n for exceptions)
> >
> > and physoffset can better be set in mach/memory.h depending on the
> > actual machine type.
> >
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: linux-sh@vger.kernel.org
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > =A0arch/arm/mach-shmobile/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 =
-----------
> > =A0arch/arm/mach-shmobile/Makefile.boot =A0 =A0 =A0 =A0 | =A0 =A09 ----=
-----
> > =A0arch/arm/mach-shmobile/include/mach/memory.h | =A0 15 ++++++++++++++-
> > =A03 files changed, 14 insertions(+), 21 deletions(-)
> > =A0delete mode 100644 arch/arm/mach-shmobile/Makefile.boot
> >
> > diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kc=
onfig
> > index 54b479c..45e134e 100644
> > --- a/arch/arm/mach-shmobile/Kconfig
> > +++ b/arch/arm/mach-shmobile/Kconfig
> > @@ -61,17 +61,6 @@ comment "SH-Mobile System Configuration"
> >
> > =A0menu "Memory configuration"
> >
> > -config MEMORY_START
> > - =A0 =A0 =A0 hex "Physical memory start address"
> > - =A0 =A0 =A0 default "0x50000000" if MACH_G3EVM
> > - =A0 =A0 =A0 default "0x40000000" if MACH_G4EVM
> > - =A0 =A0 =A0 default "0x40000000" if MACH_AP4EVB
> > - =A0 =A0 =A0 default "0x00000000"
> > - =A0 =A0 =A0 ---help---
> > - =A0 =A0 =A0 =A0 Tweak this only when porting to a new machine which d=
oes not
> > - =A0 =A0 =A0 =A0 already have a defconfig. Changing it from the known =
correct
> > - =A0 =A0 =A0 =A0 value on any of the known systems will only lead to d=
isaster.
> > -
> > =A0config MEMORY_SIZE
> > =A0 =A0 =A0 =A0hex "Physical memory size"
> > =A0 =A0 =A0 =A0default "0x08000000" if MACH_G3EVM
> > diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmob=
ile/Makefile.boot
> > deleted file mode 100644
> > index 1c08ee9..0000000
> > --- a/arch/arm/mach-shmobile/Makefile.boot
> > +++ /dev/null
> > @@ -1,9 +0,0 @@
> > -__ZRELADDR =A0 =A0 :=3D $(shell /bin/bash -c 'printf "0x%08x" \
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$$[$(CONFIG_MEMORY_START) + 0x=
8000]')
> > -
> > - =A0 zreladdr-y =A0 :=3D $(__ZRELADDR)
> > -
> > -# Unsupported legacy stuff
> > -#
> > -#params_phys-y (Instead: Pass atags pointer in r2)
> > -#initrd_phys-y (Instead: Use compiled-in initramfs)
> > diff --git a/arch/arm/mach-shmobile/include/mach/memory.h b/arch/arm/ma=
ch-shmobile/include/mach/memory.h
> > index 377584e..100f734 100644
> > --- a/arch/arm/mach-shmobile/include/mach/memory.h
> > +++ b/arch/arm/mach-shmobile/include/mach/memory.h
> > @@ -1,7 +1,20 @@
> > =A0#ifndef __ASM_MACH_MEMORY_H
> > =A0#define __ASM_MACH_MEMORY_H
> >
> > -#define PHYS_OFFSET =A0 =A0UL(CONFIG_MEMORY_START)
> > +#define SH7367_PHYS_OFFSET UL(0x50000000)
> > +#define SH7372_PHYS_OFFSET UL(0x40000000)
> > +#define SH7377_PHYS_OFFSET UL(0x40000000)
> > +
> > +#if !defined(CONFIG_RUNTIME_PHYS_OFFSET)
> > +# if defined(CONFIG_ARCH_SH7367)
> > +# =A0define PHYS_OFFSET =A0SH7367_PHYS_OFFSET
> > +# elif defined(CONFIG_ARCH_SH7372)
> > +# =A0define PHYS_OFFSET =A0SH7372_PHYS_OFFSET
> > +# elif defined(CONFIG_ARCH_SH7377)
> > +# =A0define PHYS_OFFSET =A0SH7377_PHYS_OFFSET
> > +# endif
> > +#endif /* if !defined(CONFIG_RUNTIME_PHYS_OFFSET) */
> > +
>=20
> Looks like the CONFIG_MEMORY_START was a configurable option, tho
> not sure if it can be configured to other values, but making it fixed here
> doesn't seem to be a consistent change. (meaning there is assumption
> here).
That is why I put RFC in the subject :-)  Anyhow, ZRELADDR is hard coded
since e69edc79 (without ZRELADDR_AUTO).  And the help text suggested to
only tweak it "when porting to a new machine which does not already have
a defconfig".  As a person making a new port should be able to add a new
default for ZRELADDR to arch/arm/Kconfig I think it's OK to remove the
possibility to create a broken kernel for the people that don't work on
a new port.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
