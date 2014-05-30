From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 May 2014 10:13:06 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791 SYSC setup code
Message-Id: <87r43bpob3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5386DD74.3000202@renesas.com>
In-Reply-To: <5386DD74.3000202@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

Thank you for your feedback

> >> +#include <linux/kernel.h>
> >> +#include <asm/io.h>
> >> +#include <mach/pm-rcar.h>
> >> +#include <mach/r8a7791.h>
> >
> > alphabetical order if possible
> 
> To me the order looks OK:
>   - Linux-specific first (in alphabetical order),
>   - ARM-specific second (in alphabetical order),
>   - Machine-specific third (in alphabetical order),
> 
> I would separate the sections by a blank line, though, but for sections
> with a single item that's not really needed.

I see.
This is not a big deal.

