From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Tue, 27 Nov 2012 03:47:25 +0000
Subject: Re: [PATCH 1/1] ARM: shmobile: Remove duplicate inclusion of dma-mapping.h in setup-r8a7740.c
Message-Id: <CAK9yfHyH-24X0rHvsaXXUFk14fbZtzoqh9LicjEw8F2+Oh2UHw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1353393549-1532-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1353393549-1532-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ping

On 20 November 2012 12:09, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> linux/dma-mapping.h was included twice.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  arch/arm/mach-shmobile/setup-r8a7740.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
> index 0952224..878a07a 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -27,7 +27,6 @@
>  #include <linux/serial_sci.h>
>  #include <linux/sh_dma.h>
>  #include <linux/sh_timer.h>
> -#include <linux/dma-mapping.h>
>  #include <mach/dma-register.h>
>  #include <mach/r8a7740.h>
>  #include <mach/pm-rmobile.h>
> --
> 1.7.4.1
>



-- 
With warm regards,
Sachin
