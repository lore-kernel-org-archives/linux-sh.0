From: Rob Landley <rob@landley.net>
Date: Thu, 08 Nov 2018 18:25:14 +0000
Subject: Re: [PATCH resend 09/13] sh: sh5: convert to SPDX identifiers
Message-Id: <ba4b87f9-b12b-fe47-8179-369430d8feb7@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <877eho147n.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877eho147n.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/8/18 12:28 AM, Kuninori Morimoto wrote:> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/sh/kernel/cpu/sh5/clock-sh5.c | 5 +----
>  arch/sh/kernel/cpu/sh5/entry.S     | 7 ++-----
>  arch/sh/kernel/cpu/sh5/fpu.c       | 5 +----
>  arch/sh/kernel/cpu/sh5/probe.c     | 5 +----
>  arch/sh/kernel/cpu/sh5/setup-sh5.c | 5 +----
>  arch/sh/kernel/cpu/sh5/switchto.S  | 7 ++-----
>  arch/sh/kernel/cpu/sh5/unwind.c    | 5 +----
>  7 files changed, 9 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/sh/kernel/cpu/sh5/clock-sh5.c b/arch/sh/kernel/cpu/sh5/clock-sh5.c
> index c48b93d..43763c2 100644
> --- a/arch/sh/kernel/cpu/sh5/clock-sh5.c
> +++ b/arch/sh/kernel/cpu/sh5/clock-sh5.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*

Why are some of these using //

> --- a/arch/sh/kernel/cpu/sh5/entry.S
> +++ b/arch/sh/kernel/cpu/sh5/entry.S
> @@ -1,13 +1,10 @@
> -/*
> +/* SPDX-License-Identifier: GPL-2.0
> + *
>   * arch/sh/kernel/cpu/sh5/entry.S

When others are extending the exiting /* block?

Rob

P.S. sh5 was a prototype architecture that never actually shipped, and
should probably be removed. The j-core guys have a different 64-bit strategy
(an x86-64 style extension of the existing instruction set rather an an
itanium-style unrelated whole new second instruction set.)

Not objecting to the patch, just... for Rich's todo list. :)
