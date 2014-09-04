From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 04 Sep 2014 06:48:38 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: Remove legacy C board code
Message-Id: <2408146.P4fRldaTJQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904023440.26241.39089.sendpatchset@w520>
In-Reply-To: <20140904023440.26241.39089.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Thursday 04 September 2014 11:34:40 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> The Multiplatform r8a7790 Lager board code is at this point
> in equally or better state compared to the legacy code.

Don't we miss support for USBHS and sound with multiplatform Lager ? Did you 
maybe mean to remove the Koelsch legacy board code ?

> Because of that it is now a good time to get rid of the old
> code and force all users move over to Multiplatform.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Built on top of renesas-devel-20140904-v3.17-rc3 and
>  "[PATCH 00/03] ARM: shmobile: sh73a0 and kzm9g Multiplatform support"
> 
>  arch/arm/mach-shmobile/Kconfig       |    7
>  arch/arm/mach-shmobile/Makefile      |    1
>  arch/arm/mach-shmobile/Makefile.boot |    1
>  arch/arm/mach-shmobile/board-lager.c |  892 -------------------------------
>  4 files changed, 901 deletions(-)

-- 
Regards,

Laurent Pinchart

