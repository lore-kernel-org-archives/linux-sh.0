From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 14:45:29 +0000
Subject: Re: [PATCH 0/2] Legacy SH_INTC cleanup
Message-Id: <CANqRtoSKs+fb=JuMMyOW=m5mET8araTjmNyVyF4kodqv5GA-9A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1408541963-20736-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1408541963-20736-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, SH-Linux <linux-sh@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi Geert,

On Wed, Aug 20, 2014 at 10:39 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>         Hi Simon, Magnus,
>
> This series cleans up some of the legacy SH_INTC support, which is only used
> on 32-bit SuperH and early ARM SH-Mobile (sh7372/sh73a).
>
> There are no dependencies between the two patches.
> The first one is destined for your sh-drivers-for-v3.18 branch, while the
> second one is meant for your cleanup-for-v3.18 branch.
>
> Geert Uytterhoeven (2):
>   sh: intc: Confine SH_INTC to platforms that need it
>   ARM: shmobile: Move legacy INTC definitions from irqs.h to intc.h

Thanks, looking great!

Acked-by: Magnus Damm <damm+renesas@opensource.se>

Cheers,

/ magnus
