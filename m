From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 Mar 2008 04:23:58 +0000
Subject: Re: [PATCH] sh: Add support for Solution Engine SH7721 board
Message-Id: <20080320042358.GA25681@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <47E12059.4020302@renesas.com>
In-Reply-To: <47E12059.4020302@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 19, 2008 at 11:16:57PM +0900, Yoshihiro Shimoda wrote:
> diff -uprN a/arch/sh/boards/se/7721/io.c b/arch/sh/boards/se/7721/io.c
> --- a/arch/sh/boards/se/7721/io.c	1970-01-01 09:00:00.000000000 +0900
> +++ b/arch/sh/boards/se/7721/io.c	2008-03-19 23:12:00.000000000 +0900
> @@ -0,0 +1,223 @@
> +/*
> + * I/O routine for SH7721 SolutionEngine.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <asm/se.h>
> +#include <asm/io.h>
> +
> +#define badio(fn, a) panic("bad i/o operation %s for %08lx.", #fn, a)
> +
This io.c is useless, kill it off and use the proper addresses when
registering the platform device.

> diff -uprN a/arch/sh/boards/se/7721/Makefile b/arch/sh/boards/se/7721/Makefile
> --- a/arch/sh/boards/se/7721/Makefile	1970-01-01 09:00:00.000000000 +0900
> +++ b/arch/sh/boards/se/7721/Makefile	2008-03-19 23:12:00.000000000 +0900
> @@ -0,0 +1,10 @@
> +#
> +# Makefile for the HITACHI UL SolutionEngine 7721 specific parts of the kernel
> +#
> +# This file is subject to the terms and conditions of the GNU General Public
> +# License.  See the file "COPYING" in the main directory of this archive
> +# for more details.
> +#
> +#
> +
> +obj-y	 := setup.o irq.o io.o

Please get rid of the Makefile comments.
