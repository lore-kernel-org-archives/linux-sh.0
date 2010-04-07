From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 07 Apr 2010 07:33:46 +0000
Subject: Re: [PATCH 0/3] AP4: I2C patches
Message-Id: <20100407073346.GB17971@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 11, 2010 at 07:42:11PM +0900, Kuninori Morimoto wrote:
> Kuninori Morimoto (3):
>       ARM: mach-shmobile: sh7372: Add I2C0, I2C1 support
>       ARM: mach-shmobile: ap4evb: Add TouchScreen support
>       ARM: mach-shmobile: ap4evb: Add R2025S RTC support
> 
> These 3 patches add I2C support to AP4-EVB board.
> 
> It are based on Magnus's
>   - SDHI patche series
>   - INTCS patche series

On Fri, Mar 12, 2010 at 07:07:55PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> depend on
> [PATCH 2/3] ARM: mach-shmobile: ap4evb: Add TouchScreen support
> 
>  arch/arm/mach-shmobile/board-ap4evb.c |   16 ++++++++++------
>  1 files changed, 10 insertions(+), 6 deletions(-)

On Mon, Mar 29, 2010 at 03:31:36PM +0900, Kuninori Morimoto wrote:
> This patch add SDHI support for G4 board.
> Current gpio frame work doesn't have
> the method to control only pull-up/down/free.
> So, it have special gpio_pull_up function for SDHI.
> It is quick hack, so this function should be replaced
> by correct gpio frame work in future.

On Mon, Mar 29, 2010 at 03:31:46PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/arm/mach-shmobile/intc-sh7367.c |    6 +++---
>  arch/arm/mach-shmobile/intc-sh7377.c |    6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

On Mon, Mar 29, 2010 at 04:58:13PM +0900, Kuninori Morimoto wrote:
> Add support for the sh7377 INTCS interrupt controller.
> 
> INTCS is the interrupt controller for the sh7377 SuperH
> processor core. It is tied into the INTCA interrupt
> controller which interfaces to the ARM processor.
> 
> INTCS support is implemented using a new INTC table
> together with a chained interrupt handler that ties
> into the already supported INTCA controller.

All applied, thanks.
