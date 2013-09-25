From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Sep 2013 05:23:37 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791 IRQC support
Message-Id: <20130925052336.GI24243@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130912003806.24022.63355.sendpatchset@w520>
In-Reply-To: <20130912003806.24022.63355.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 12, 2013 at 09:38:06AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add support for r8a7791 IRQ pins IRQ0 -> IRQ9 via
> the IRQC driver in drivers/irqchip/irq-renesas-irqc.c
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas-devel-20130906
> 
>  arch/arm/boot/dts/r8a7791.dtsi                |   18 ++++++++++++++
>  arch/arm/mach-shmobile/Kconfig                |    1 
>  arch/arm/mach-shmobile/board-koelsch.c        |    2 -
>  arch/arm/mach-shmobile/include/mach/r8a7791.h |    1 
>  arch/arm/mach-shmobile/setup-r8a7791.c        |   32 +++++++++++++++++++++++++
>  5 files changed, 53 insertions(+), 1 deletion(-)

Hi Magnus,

please split this into three patches.

1. An SoC patch: The r8a7791.[ch] and Kconfig changes
2. A board patch: The board-koelsh.c change
3. A dt patch: The .dtsi change
