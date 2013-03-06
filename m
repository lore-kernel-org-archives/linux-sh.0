From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 06 Mar 2013 16:40:33 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Add CPU Core Standby Mode
Message-Id: <20130306164032.GN17833@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1362419645-3116-1-git-send-email-hechtb+renesas@gmail.com>
 <1362419645-3116-2-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1362419645-3116-2-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Mar 04, 2013 at 06:54:05PM +0100, Bastian Hecht wrote:
> diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
> index 40b87aa..ee3d713 100644
> --- a/arch/arm/mach-shmobile/pm-r8a7740.c
> +++ b/arch/arm/mach-shmobile/pm-r8a7740.c
> @@ -10,9 +10,29 @@
>   */
>  #include <linux/console.h>
>  #include <linux/suspend.h>
> +#include <asm/io.h>

It's spelled linux/io.h, not asm/io.h
