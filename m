From: Paul Bolle <pebolle@tiscali.nl>
Date: Sun, 16 Feb 2014 21:16:49 +0000
Subject: Re: [PATCH RFC] MAINTAINERS: Mark SuperH orphan
Message-Id: <1392585409.28866.94.camel@x220>
List-Id: <linux-sh.vger.kernel.org>
References: <1392584137-24486-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1392584137-24486-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mundt <paul.mundt@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

On Sun, 2014-02-16 at 21:55 +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Paul Mundt's email address bounces regularly, and he hasn't taken any
> SuperH patches for about one year.
> 
> Suggested-by: Paul Bolle <pebolle@tiscali.nl>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
>  MAINTAINERS |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

I think Andrew prefers to add an entry in CREDITS when removing someone
from MAINTAINERS. As that is the courteous thing to do, I guess. 

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


Paul Bolle

