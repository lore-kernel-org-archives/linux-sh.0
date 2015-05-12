From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 12 May 2015 07:31:13 +0000
Subject: Re: [PATCH 0/4] r8a7793 pin control support
Message-Id: <4634674.uqpogLZnTA@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1431015037-25254-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1431015037-25254-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patches.

On Thursday 07 May 2015 18:10:33 Ulrich Hecht wrote:
> Hi!
> 
> This is the PFC portion broken out of the previously posted r8a7793 series.
> Sharing the code of the r8a7791 implementation, it is now about 6000 lines
> smaller. *cough*
> 
> The one feature that was missing in the existing r8a7791 PFC implementation
> is the SSP pin group, which has been moved to a separate patch in this
> series.

For patches 1 to 3,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

For patch 4, I have the same comment as Geert.

> Ulrich Hecht (4):
>   pinctrl: sh-pfc: Add r8a7793 support
>   pinctrl: sh-pfc: Enable building of r8a7793 PFC support
>   pinctrl: sh-pfc: Add renesas,pfc-r8a7793 to binding documentation
>   pinctrl: sh-pfc: r8a7791/3: Add SSP pin group
> 
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |  3 +-
>  drivers/pinctrl/sh-pfc/Kconfig                     |  5 +++
>  drivers/pinctrl/sh-pfc/Makefile                    |  1 +
>  drivers/pinctrl/sh-pfc/core.c                      |  6 ++++
>  drivers/pinctrl/sh-pfc/core.h                      |  1 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c               | 41 +++++++++++++++++++
>  6 files changed, 56 insertions(+), 1 deletion(-)

-- 
Regards,

Laurent Pinchart

