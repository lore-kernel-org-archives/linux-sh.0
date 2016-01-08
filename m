From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 08 Jan 2016 18:03:21 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <568FF9E9.7030807@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108044054.GA7130@brightrain.aerifal.cx>
In-Reply-To: <20160108044054.GA7130@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uClinux.org>, Rob Landley <rob@landley.net>

Hello.

On 01/08/2016 07:40 AM, Rich Felker wrote:

> From: Rich Felker <dalias@libc.org>
>
> Recently the bulk of traffic on the linux-sh list has been unrelated
> to arch/sh but instead focused on Renesas hardware for their ARM-based
> SoCs. As part of resuming maintenance of arch/sh, remove the linux-sh
> list from the MAINTAINERS file sections for these other components so
> that new arch/sh development is not drowned out by unrelated
> cross-postings.
>
> Signed-off-by: Rich Felker <dalias@libc.org>
> Acked-by: D. Jeff Dionne <jeff@uClinux.org>
> Acked-by: Rob Landley <rob@landley.net>
>
> ---
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9bff63c..8f5f953 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS

[...]
> @@ -8369,7 +8364,6 @@ F:	drivers/pinctrl/intel/
>
>   PIN CONTROLLER - RENESAS
>   M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> -L:	linux-sh@vger.kernel.org
>   S:	Maintained
>   F:	drivers/pinctrl/sh-pfc/

    Wait, this directory also contains the SuperH PFC drivers.

MBR, Sergei

