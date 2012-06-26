From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 23:11:14 +0000
Subject: Re: [PATCH 02/10 v3] ARM: mach-shmobile: add fixed voltage regulators to ag5evm
Message-Id: <Pine.LNX.4.64.1206270109270.8660@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1340749952-8534-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340749952-8534-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 27 Jun 2012, Guennadi Liakhovetski wrote:

> On ag5evm provide 1.8V, 2.8V, and 3.3V supplies for its SD/MMC-card
> interfaces and a dummy regulator for the smsc911x driver.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v3: request the SD/MMC power-switching GPIO not in the board initialisation 
> routine, but in the .set_pwr() callback. This also lets the power switching 
> work if the fixed regulator driver is enabled and is not yet used by the 
> respective mmc driver(s), regardless whether the driver is loaded or not. 
> The previous version would fail if the fixed regulator driver was enabled 
> but not loaded.
> 
>  arch/arm/mach-shmobile/board-ag5evm.c |   83 +++++++++++++++++++++++++++++++-
>  1 files changed, 80 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
> index 5a6f22f..25d260a 100644
> --- a/arch/arm/mach-shmobile/board-ag5evm.c
> +++ b/arch/arm/mach-shmobile/board-ag5evm.c
> @@ -19,6 +19,7 @@
>   *
>   */
>  
> +#include <linux/kconfig.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>

This hunk is a left-over from v2, this header is not needed any more. If 
the rest is ok, I'll just resend this one patch without this hunk. Sorry 
for the inconvenience.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
