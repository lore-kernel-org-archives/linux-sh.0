From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 18 Jan 2008 02:19:22 +0000
Subject: Re: [PATCH] Add support for SDK7780 board
Message-Id: <aec7e5c30801171819jed849cct1b4f18603fec59d3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <478F7921.4090203@mpc-data.co.uk>
In-Reply-To: <478F7921.4090203@mpc-data.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Jan 18, 2008 12:49 AM, Nicholas Beck <nbeck@mpc-data.co.uk> wrote:
> Add support for Renesas Technology Europe SDK7780 board.

Great, thank you for your patch!

> Signed-off-by: Nicholas Beck <nbeck@mpc-data.co.uk>
> ---
> diff -urN -x '.git*' a/arch/sh/boards/renesas/sdk7780/irq.c
> b/arch/sh/boards/renesas/sdk7780/irq.c
> --- a/arch/sh/boards/renesas/sdk7780/irq.c    1970-01-01
> 01:00:00.000000000 +0100
> +++ b/arch/sh/boards/renesas/sdk7780/irq.c    2008-01-17
> 15:11:09.000000000 +0000
> @@ -0,0 +1,102 @@
> +/*
> + * linux/arch/sh/boards/renesas/sdk7780/irq.c
> + *
> + * Renesas Technology Europe SDK7780 Support.
> + *
> + * Copyright (C) 2008  Nicholas Beck <nbeck@mpc-data.co.uk>
> + *
> + * Based on linux/arch/sh/boards/renesas/r7780rp/irq.c

This must be based on a not-so-recent kernel version. Newer kernels
use intc tables for both cpu specific and board specific irq setup.
Please consider updating the interrupt code - have a look at r7780mp
or r2d for good examples.

Thanks!

/ magnus
