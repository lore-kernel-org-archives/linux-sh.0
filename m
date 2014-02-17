From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Feb 2014 11:55:41 +0000
Subject: Re: [PATCH v2] MAINTAINERS: Mark SuperH orphan
Message-Id: <20140217115540.GA23509@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1392586619-27018-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1392586619-27018-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mundt <paul.mundt@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Andrew Morton <akpm@linux-foundation.org>, Paul Bolle <pebolle@tiscali.nl>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Hi Geert,

I have a minor objection to this patch.

The change includes the maintenance of drivers/sh/ and I believe that 
the CPG driver in drivers/sh/clk, the INTC driver in drivers/sh/intc and
the code in pm_runtime.c is used by Renesas ARM based SoCs.
It seems somewhat unsatisfactory to orphan that code.

What I propose is adding entries for them, either stand-alone or part of
the SHMOBILE (a.k.a. Renesas ARM based SoCs) entry so that are maintained
by someone.  I am happy for my name to go against that.

On Sun, Feb 16, 2014 at 10:36:59PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Paul Mundt's email address bounces regularly, and he hasn't taken any
> SuperH patches for about one year.
> 
> Suggested-by: Paul Bolle <pebolle@tiscali.nl>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
> v2: Add a CREDITS entry
> 
>  CREDITS     |    4 ++++
>  MAINTAINERS |    4 +---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/CREDITS b/CREDITS
> index e371c5504a50..acab035edcfc 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -2564,6 +2564,10 @@ N. Wolfgang Muees
>  E: wolfgang@iksw-muees.de
>  D: Auerswald USB driver
>  
> +N: Paul Mundt
> +E: paul.mundt@gmail.com
> +D: SuperH maintainer
> +
>  N: Ian A. Murdock
>  E: imurdock@gnu.ai.mit.edu
>  D: Creator of Debian distribution
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2cf5cfb4d29..2d294561ebdc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8372,12 +8372,10 @@ S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
>  SUPERH
> -M:	Paul Mundt <lethal@linux-sh.org>
>  L:	linux-sh@vger.kernel.org
>  W:	http://www.linux-sh.org
>  Q:	http://patchwork.kernel.org/project/linux-sh/list/
> -T:	git git://github.com/pmundt/linux-sh.git sh-latest
> -S:	Supported
> +S:	Orphan
>  F:	Documentation/sh/
>  F:	arch/sh/
>  F:	drivers/sh/
> -- 
> 1.7.9.5
> 
