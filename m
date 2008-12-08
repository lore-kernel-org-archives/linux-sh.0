From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Mon, 08 Dec 2008 16:39:51 +0000
Subject: Re: [PATCH 01/03] sh: move the hp6xx pm code
Message-Id: <20081208184107.d3689bb9.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__8_Dec_2008_18_41_07_+0100_//lpj/3qoJ8njxo5"
List-Id: <linux-sh.vger.kernel.org>
References: <20081204134503.21168.21185.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081204134503.21168.21185.sendpatchset@rx1.opensource.se>
To: linux-sh@vger.kernel.org

--Signature=_Mon__8_Dec_2008_18_41_07_+0100_//lpj/3qoJ8njxo5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Dec 2008 22:45:03 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@igel.co.jp>
>=20
> Move the not-so-generic pm code from arch/sh/kernel/pm.c to the
> platform directory together with the rest of the hp6xx pm code.
>=20
> This is done to let non-hp6xx platforms enable CONFIG_PM.
>=20
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---

The suspend has been broken on HP Jornada 600
since 2.6.17, so I can only ack on the=20
idea behind the patch to remove the so called
generic pm.c. I plan on getting round
to it in time.

Also, since they are almost identical
it's unlikely that your patch will break anything.
It essentially just removes an extra copy.

So feel free to add an ack.


>=20
>  arch/sh/boards/mach-hp6xx/pm.c |   78 +++++++++++++++++++++++++++++++++++
>  arch/sh/include/asm/pm.h       |   17 -------
>  arch/sh/kernel/Makefile_32     |    1=20
>  arch/sh/kernel/Makefile_64     |    1=20
>  arch/sh/kernel/pm.c            |   88 ----------------------------------=
------
>  5 files changed, 77 insertions(+), 108 deletions(-)
>=20
> --- 0001/arch/sh/boards/mach-hp6xx/pm.c
> +++ work/arch/sh/boards/mach-hp6xx/pm.c	2008-12-04 20:43:36.000000000 +09=
00
> @@ -10,15 +10,91 @@
>  #include <linux/suspend.h>
>  #include <linux/errno.h>
>  #include <linux/time.h>
> +#include <linux/delay.h>
> +#include <linux/gfp.h>
>  #include <asm/io.h>
>  #include <asm/hd64461.h>
>  #include <mach/hp6xx.h>
>  #include <cpu/dac.h>
> -#include <asm/pm.h>
> +#include <asm/freq.h>
> +#include <asm/watchdog.h>
> +
> +#define INTR_OFFSET	0x600
> =20
>  #define STBCR		0xffffff82
>  #define STBCR2		0xffffff88
> =20
> +#define STBCR_STBY	0x80
> +#define STBCR_MSTP2	0x04
> +
> +#define MCR		0xffffff68
> +#define RTCNT		0xffffff70
> +
> +#define MCR_RMODE	2
> +#define MCR_RFSH	4
> +
> +extern u8 wakeup_start;
> +extern u8 wakeup_end;
> +
> +static void pm_enter(void)
> +{
> +	u8 stbcr, csr;
> +	u16 frqcr, mcr;
> +	u32 vbr_new, vbr_old;
> +
> +	set_bl_bit();
> +
> +	/* set wdt */
> +	csr =3D sh_wdt_read_csr();
> +	csr &=3D ~WTCSR_TME;
> +	csr |=3D WTCSR_CKS_4096;
> +	sh_wdt_write_csr(csr);
> +	csr =3D sh_wdt_read_csr();
> +	sh_wdt_write_cnt(0);
> +
> +	/* disable PLL1 */
> +	frqcr =3D ctrl_inw(FRQCR);
> +	frqcr &=3D ~(FRQCR_PLLEN | FRQCR_PSTBY);
> +	ctrl_outw(frqcr, FRQCR);
> +
> +	/* enable standby */
> +	stbcr =3D ctrl_inb(STBCR);
> +	ctrl_outb(stbcr | STBCR_STBY | STBCR_MSTP2, STBCR);
> +
> +	/* set self-refresh */
> +	mcr =3D ctrl_inw(MCR);
> +	ctrl_outw(mcr & ~MCR_RFSH, MCR);
> +
> +	/* set interrupt handler */
> +	asm volatile("stc vbr, %0" : "=3Dr" (vbr_old));
> +	vbr_new =3D get_zeroed_page(GFP_ATOMIC);
> +	udelay(50);
> +	memcpy((void*)(vbr_new + INTR_OFFSET),
> +	       &wakeup_start, &wakeup_end - &wakeup_start);
> +	asm volatile("ldc %0, vbr" : : "r" (vbr_new));
> +
> +	ctrl_outw(0, RTCNT);
> +	ctrl_outw(mcr | MCR_RFSH | MCR_RMODE, MCR);
> +
> +	cpu_sleep();
> +
> +	asm volatile("ldc %0, vbr" : : "r" (vbr_old));
> +
> +	free_page(vbr_new);
> +
> +	/* enable PLL1 */
> +	frqcr =3D ctrl_inw(FRQCR);
> +	frqcr |=3D FRQCR_PSTBY;
> +	ctrl_outw(frqcr, FRQCR);
> +	udelay(50);
> +	frqcr |=3D FRQCR_PLLEN;
> +	ctrl_outw(frqcr, FRQCR);
> +
> +	ctrl_outb(stbcr, STBCR);
> +
> +	clear_bl_bit();
> +}
> +
>  static int hp6x0_pm_enter(suspend_state_t state)
>  {
>  	u8 stbcr, stbcr2;
> --- 0001/arch/sh/include/asm/pm.h
> +++ /dev/null	2008-12-03 11:12:15.442019092 +0900
> @@ -1,17 +0,0 @@
> -/*
> - * This file is subject to the terms and conditions of the GNU General P=
ublic
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - *
> - * Copyright 2006 (c) Andriy Skulysh <askulysh@gmail.com>
> - *
> - */
> -#ifndef __ASM_SH_PM_H
> -#define __ASM_SH_PM_H
> -
> -extern u8 wakeup_start;
> -extern u8 wakeup_end;
> -
> -void pm_enter(void);
> -
> -#endif
> --- 0001/arch/sh/kernel/Makefile_32
> +++ work/arch/sh/kernel/Makefile_32	2008-12-04 20:41:49.000000000 +0900
> @@ -25,7 +25,6 @@ obj-$(CONFIG_MODULES)		+=3D sh_ksyms_32.o=20
>  obj-$(CONFIG_EARLY_PRINTK)	+=3D early_printk.o
>  obj-$(CONFIG_KEXEC)		+=3D machine_kexec.o relocate_kernel.o
>  obj-$(CONFIG_CRASH_DUMP)	+=3D crash_dump.o
> -obj-$(CONFIG_PM)		+=3D pm.o
>  obj-$(CONFIG_STACKTRACE)	+=3D stacktrace.o
>  obj-$(CONFIG_IO_TRAPPED)	+=3D io_trapped.o
>  obj-$(CONFIG_KPROBES)		+=3D kprobes.o
> --- 0001/arch/sh/kernel/Makefile_64
> +++ work/arch/sh/kernel/Makefile_64	2008-12-04 20:41:49.000000000 +0900
> @@ -15,7 +15,6 @@ obj-$(CONFIG_MODULES)		+=3D sh_ksyms_64.o=20
>  obj-$(CONFIG_EARLY_PRINTK)	+=3D early_printk.o
>  obj-$(CONFIG_KEXEC)		+=3D machine_kexec.o relocate_kernel.o
>  obj-$(CONFIG_CRASH_DUMP)	+=3D crash_dump.o
> -obj-$(CONFIG_PM)		+=3D pm.o
>  obj-$(CONFIG_STACKTRACE)	+=3D stacktrace.o
>  obj-$(CONFIG_IO_TRAPPED)	+=3D io_trapped.o
>  obj-$(CONFIG_GENERIC_GPIO)	+=3D gpio.o
> --- 0001/arch/sh/kernel/pm.c
> +++ /dev/null	2008-12-03 11:12:15.442019092 +0900
> @@ -1,88 +0,0 @@
> -/*
> - * Generic Power Management Routine
> - *
> - * Copyright (c) 2006 Andriy Skulysh <askulsyh@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License.
> - */
> -#include <linux/suspend.h>
> -#include <linux/delay.h>
> -#include <linux/gfp.h>
> -#include <asm/freq.h>
> -#include <asm/io.h>
> -#include <asm/watchdog.h>
> -#include <asm/pm.h>
> -
> -#define INTR_OFFSET	0x600
> -
> -#define STBCR		0xffffff82
> -#define STBCR2		0xffffff88
> -
> -#define STBCR_STBY	0x80
> -#define STBCR_MSTP2	0x04
> -
> -#define MCR		0xffffff68
> -#define RTCNT		0xffffff70
> -
> -#define MCR_RMODE	2
> -#define MCR_RFSH	4
> -
> -void pm_enter(void)
> -{
> -	u8 stbcr, csr;
> -	u16 frqcr, mcr;
> -	u32 vbr_new, vbr_old;
> -
> -	set_bl_bit();
> -
> -	/* set wdt */
> -	csr =3D sh_wdt_read_csr();
> -	csr &=3D ~WTCSR_TME;
> -	csr |=3D WTCSR_CKS_4096;
> -	sh_wdt_write_csr(csr);
> -	csr =3D sh_wdt_read_csr();
> -	sh_wdt_write_cnt(0);
> -
> -	/* disable PLL1 */
> -	frqcr =3D ctrl_inw(FRQCR);
> -	frqcr &=3D ~(FRQCR_PLLEN | FRQCR_PSTBY);
> -	ctrl_outw(frqcr, FRQCR);
> -
> -	/* enable standby */
> -	stbcr =3D ctrl_inb(STBCR);
> -	ctrl_outb(stbcr | STBCR_STBY | STBCR_MSTP2, STBCR);
> -
> -	/* set self-refresh */
> -	mcr =3D ctrl_inw(MCR);
> -	ctrl_outw(mcr & ~MCR_RFSH, MCR);
> -
> -	/* set interrupt handler */
> -	asm volatile("stc vbr, %0" : "=3Dr" (vbr_old));
> -	vbr_new =3D get_zeroed_page(GFP_ATOMIC);
> -	udelay(50);
> -	memcpy((void*)(vbr_new + INTR_OFFSET),
> -	       &wakeup_start, &wakeup_end - &wakeup_start);
> -	asm volatile("ldc %0, vbr" : : "r" (vbr_new));
> -
> -	ctrl_outw(0, RTCNT);
> -	ctrl_outw(mcr | MCR_RFSH | MCR_RMODE, MCR);
> -
> -	cpu_sleep();
> -
> -	asm volatile("ldc %0, vbr" : : "r" (vbr_old));
> -
> -	free_page(vbr_new);
> -
> -	/* enable PLL1 */
> -	frqcr =3D ctrl_inw(FRQCR);
> -	frqcr |=3D FRQCR_PSTBY;
> -	ctrl_outw(frqcr, FRQCR);
> -	udelay(50);
> -	frqcr |=3D FRQCR_PLLEN;
> -	ctrl_outw(frqcr, FRQCR);
> -
> -	ctrl_outb(stbcr, STBCR);
> -
> -	clear_bl_bit();
> -}


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Mon__8_Dec_2008_18_41_07_+0100_//lpj/3qoJ8njxo5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk9XDMACgkQPQls10ERAGcXAACgiAmafpJXT5S3oj2bcstQpKG4
2iUAnjfcjuIGJFUW2AkjhXq7vh8KB5nb
=OMxv
-----END PGP SIGNATURE-----

--Signature=_Mon__8_Dec_2008_18_41_07_+0100_//lpj/3qoJ8njxo5--
