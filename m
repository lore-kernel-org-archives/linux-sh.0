From: Simon Horman <horms@verge.net.au>
Date: Thu, 09 Aug 2018 12:36:32 +0000
Subject: Re: [PATCH 13/13] sh: lib: convert to SPDX identifiers
Message-Id: <20180809123631.q7rxqaqaipakfdvh@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <874lg8p7d2.wl-kuninori.morimoto.gx@renesas.com>
 <87lg9knslt.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lg9knslt.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Morimoto-san,

On Mon, Aug 06, 2018 at 02:26:30AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/sh/lib/ashiftrt.S       | 29 ++++-------------------------
>  arch/sh/lib/ashlsi3.S        | 29 ++++-------------------------
>  arch/sh/lib/ashrsi3.S        | 29 ++++-------------------------
>  arch/sh/lib/checksum.S       |  9 +++------
>  arch/sh/lib/io.c             |  5 +----
>  arch/sh/lib/libgcc.h         |  2 ++
>  arch/sh/lib/lshrsi3.S        | 29 ++++-------------------------
>  arch/sh/lib/mcount.S         |  7 ++-----
>  arch/sh/lib/movmem.S         | 29 ++++-------------------------
>  arch/sh/lib/udiv_qrnnd.S     | 29 ++++-------------------------
>  arch/sh/lib/udivsi3.S        | 29 ++++-------------------------
>  arch/sh/lib/udivsi3_i4i-Os.S | 29 ++++-------------------------
>  arch/sh/lib/udivsi3_i4i.S    | 29 ++++-------------------------
>  13 files changed, 44 insertions(+), 240 deletions(-)
> 
> diff --git a/arch/sh/lib/ashiftrt.S b/arch/sh/lib/ashiftrt.S
> index 45ce865..d680b30 100644
> --- a/arch/sh/lib/ashiftrt.S
> +++ b/arch/sh/lib/ashiftrt.S
> @@ -1,30 +1,9 @@
> -/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
> +/* SPDX-License-Identifier: GPL-2.0+
> +
> +   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
>     2004, 2005, 2006
>     Free Software Foundation, Inc.
> -
> -This file is free software; you can redistribute it and/or modify it
> -under the terms of the GNU General Public License as published by the
> -Free Software Foundation; either version 2, or (at your option) any
> -later version.
> -
> -In addition to the permissions in the GNU General Public License, the
> -Free Software Foundation gives you unlimited permission to link the
> -compiled version of this file into combinations with other programs,
> -and to distribute those combinations without any restriction coming
> -from the use of this file.  (The General Public License restrictions
> -do apply in other respects; for example, they cover modification of
> -the file, and distribution when not linked into a combine
> -executable.)

Given the above clause I wonder if the SPDX identifier should be:

SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0

...
