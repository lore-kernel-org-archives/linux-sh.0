From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Sun, 20 Jan 2008 19:54:06 +0000
Subject: Re: [PATCH] SG - fix SH Kconfig
Message-Id: <20080120115406.c092be4e.randy.dunlap@oracle.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1200853109.6331.2.camel@localhost.localdomain>
In-Reply-To: <1200853109.6331.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Paul Mundt <lethal@users.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Sun, 20 Jan 2008 18:18:29 +0000 Adrian McMenamin wrote:

> From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> 
> 
> Remove reference to board deleted in commit 758e06ded4c48024835ef0a14627afcde2e25929
> 
> Submitted-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

s/Submitted/Signed-off/

What is "SG" in $subject for?


> ---
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 85bd9ac..e94430b 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -518,7 +518,6 @@ config SH_CAYMAN
>  
>  endmenu
>  
> -source "arch/sh/boards/renesas/hs7751rvoip/Kconfig"
>  source "arch/sh/boards/renesas/rts7751r2d/Kconfig"
>  source "arch/sh/boards/renesas/r7780rp/Kconfig"
>  source "arch/sh/boards/magicpanelr2/Kconfig"

---
~Randy
