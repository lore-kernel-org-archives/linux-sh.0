From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 21 Apr 2013 19:16:37 +0000
Subject: Re: [PATCH v2 4/5] ARM: shmobile: BOCK-W: add VIN and ML86V7667 support
Message-Id: <51743B15.4000107@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304212242.39693.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304212242.39693.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 04/21/2013 10:42 PM, Sergei Shtylyov wrote:

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>
> Add ML86V7667 platform devices on BOCK-W board, configure VIN0/1 pins, and
> register VIN0/1 devices with the ML86V7667 specific platform data.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: some macro/comment cleanup; updated the copyrights.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>   arch/arm/mach-shmobile/board-bockw.c |   40 +++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
>
> Index: renesas/arch/arm/mach-shmobile/board-bockw.c
> =================================> --- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
> +++ renesas/arch/arm/mach-shmobile/board-bockw.c

[...]

> @@ -23,6 +24,8 @@
>   #include <linux/regulator/fixed.h>
>   #include <linux/regulator/machine.h>
>   #include <linux/smsc911x.h>
> +#include <linux/pinctrl/machine.h>

    Noticed just now: this #include is duplicate. It seems I was too 
fast in resending
the series...

WBR, Sergei

