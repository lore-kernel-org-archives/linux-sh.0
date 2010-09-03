From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 03 Sep 2010 10:18:43 +0000
Subject: Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c
Message-Id: <AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Sep 2, 2010 at 10:39 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> factorise some generic infrastructure to assist looking up struct clks
> for the ARM & SH architecture.
>
> as the code is identical at 99%
>
> put the arch specific code for allocation as example in asm/clkdev.h
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
> v3:
> =A0 =A0 =A0 =A0wrong comment removed
> =A0 =A0 =A0 =A0headers fixed

[snip]

I can't apply this patch using GNU patch. I've tested 2.5.9 and 2.6.1
from Gentoo.

Using --dry-run is fine, but omitting dry-run gives me:

...
patching file arch/arm/common/clkdev.c
patching file arch/sh/include/asm/clkdev.h
Hunk #1 FAILED at 1.
Hunk #2 FAILED at 11.
2 out of 2 hunks FAILED -- saving rejects to file
arch/sh/include/asm/clkdev.h.rej

I guess this is caused by the last "renaming" hunk, see below.

I thought these things were supposed to work out of the box...

/ magnus

> diff --git a/arch/sh/include/asm/clkdev.h b/include/linux/clkdev.h
> similarity index 85%
> rename from arch/sh/include/asm/clkdev.h
> rename to include/linux/clkdev.h
> index 5645f35..457bcb0 100644
> --- a/arch/sh/include/asm/clkdev.h
> +++ b/include/linux/clkdev.h
> @@ -1,7 +1,5 @@
> =A0/*
> - * =A0arch/sh/include/asm/clkdev.h
> - *
> - * Cloned from arch/arm/include/asm/clkdev.h:
> + * =A0include/linux/clkdev.h
> =A0*
> =A0* =A0Copyright (C) 2008 Russell King.
> =A0*
> @@ -11,10 +9,13 @@
> =A0*
> =A0* Helper for the clk API to assist looking up a struct clk.
> =A0*/
> -#ifndef __ASM_CLKDEV_H
> -#define __ASM_CLKDEV_H
> +#ifndef __CLKDEV_H
> +#define __CLKDEV_H
> +
> +#include <asm/clkdev.h>
>
> =A0struct clk;
> +struct device;
>
> =A0struct clk_lookup {
> =A0 =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0node;
> --
> 1.7.1
