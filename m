From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Nov 2013 02:11:52 +0000
Subject: Re: [PATCH v2 3/3] ARM: shmobile: r8a7790: Wait for status on all MSTP clocks
Message-Id: <87siuqy04a.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384357973-27365-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384357973-27365-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> 
> When enabling a module clock by clearing its bit in the MSTP control
> register, the CPG requires waiting for the status register to signal
> that the clock has started. Failure to do so will result in returning
> from the clk_enable() call with the clock potentially still disabled,
> leading to various race conditions and difficult to debug errors.
> 
> Enable status wait for all MSTP clocks on the r8a7790.
> 
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7790.c | 90 ++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> index 9fa39d1..6c65b70 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -43,16 +43,24 @@
>   *	see "p1 / 2" on R8A7790_CLOCK_ROOT() below
>   */
>  
> -#define CPG_BASE 0xe6150000
> -#define CPG_LEN 0x1000
> -
> -#define SMSTPCR1 0xe6150134
> -#define SMSTPCR2 0xe6150138
> -#define SMSTPCR3 0xe615013c
> -#define SMSTPCR5 0xe6150144
> -#define SMSTPCR7 0xe615014c
> -#define SMSTPCR8 0xe6150990
> -#define SMSTPCR9 0xe6150994
> +#define CPG_BASE	0xe6150000
> +#define CPG_LEN		0x1000
> +
> +#define SMSTPCR1	0xe6150134
> +#define SMSTPCR2	0xe6150138
> +#define SMSTPCR3	0xe615013c
> +#define SMSTPCR5	0xe6150144
> +#define SMSTPCR7	0xe615014c
> +#define SMSTPCR8	0xe6150990
> +#define SMSTPCR9	0xe6150994
> +
> +#define MSTPSR1		IOMEM(0xe6150038)
> +#define MSTPSR2		IOMEM(0xe6150040)
> +#define MSTPSR3		IOMEM(0xe6150048)
> +#define MSTPSR5		IOMEM(0xe615003c)
> +#define MSTPSR7		IOMEM(0xe61501c4)
> +#define MSTPSR8		IOMEM(0xe61509a0)
> +#define MSTPSR9		IOMEM(0xe61509a4)

Similar comment here.
cleanup (?) CPG_xxx / SMSTPCRx are out of this purpose ?

