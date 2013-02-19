From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Feb 2013 10:15:37 +0000
Subject: Re: [RFC][PATCH v2] ARM: shmobile: R-Car: add gic_iid macro for ICCIAR / interrupt ID
Message-Id: <CANqRtoSC62JUSSibH3o722vdDnv+VsP424hPdsO9qMRk7Qyr4Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wqu4el91.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wqu4el91.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Feb 19, 2013 at 5:55 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> R-Car H1 datasheet GIC number is indicating
> GIC ICCIAR / interrupt ID number, not SPI number,
> but current marzen board code is using gic_spi() with
> un-understandable calculation.
>
> This patch adds new gic_iid() macro which means
> ICCIAR / interrupt ID, and used the number
> currently written on datasheet.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
>
>  - gic_iic() -> gic_iid()
>  - update git log comments
>
>  arch/arm/mach-shmobile/board-marzen.c      |   12 ++++++------
>  arch/arm/mach-shmobile/include/mach/irqs.h |    1 +
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> index cdcb799..2338d4b 100644
> --- a/arch/arm/mach-shmobile/board-marzen.c
> +++ b/arch/arm/mach-shmobile/board-marzen.c
> @@ -66,7 +66,7 @@ static struct resource smsc911x_resources[] = {
>                 .flags          = IORESOURCE_MEM,
>         },
>         [1] = {
> -               .start          = gic_spi(28), /* IRQ 1 */
> +               .start          = gic_iid(0x3c), /* IRQ 1 */
>                 .flags          = IORESOURCE_IRQ,
>         },
>  };

In general we're moving over to DT so for this case I can't say that I
care very much. However, if you want to change things around why don't
you just do the following?

> +               .start          = 0x3c, /* IRQ 1 */

Thanks,

/ magnus
