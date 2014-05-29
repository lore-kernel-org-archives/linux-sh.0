From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 29 May 2014 07:15:40 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791 SYSC setup code
Message-Id: <874n09dpid.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5386DD74.3000202@renesas.com>
In-Reply-To: <5386DD74.3000202@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> Add r8a7791 SYSC power management support.
> 
> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> ---
(snip)
> +/*
> + * r8a7791 Power management support
> + *
> + * Copyright (C) 2013  Renesas Electronics Corporation
> + * Copyright (C) 2011  Renesas Solutions Corp.
> + * Copyright (C) 2011  Magnus Damm

2014 ?

> +#include <linux/kernel.h>
> +#include <asm/io.h>
> +#include <mach/pm-rcar.h>
> +#include <mach/r8a7791.h>

alphabetical order if possible

Best regards
---
Kuninori Morimoto
