From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 20 Nov 2013 10:58:32 +0000
Subject: Re: [PATCH 00/05] gpio: R-Car and EM GPIO update V2
Message-Id: <18469590.Iog5Xntpc3@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120002259.27342.35575.sendpatchset@w520>
In-Reply-To: <20131120002259.27342.35575.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linus.walleij@linaro.org, grant.likely@secretlab.ca, horms@verge.net.au

Hi Magnus,

Thank you for the patch.

On Wednesday 20 November 2013 09:22:59 Magnus Damm wrote:
> gpio: R-Car and EM GPIO update V2
> 
> [PATCH 01/05 v2] gpio: rcar: Use lazy disable
> [PATCH 02/05 v2] gpio: rcar: Enable mask on suspend
> [PATCH 03/05] gpio: em: Setup gpiochip->dev
> [PATCH 04/05 v2] gpio: em: Use lazy disable
> [PATCH 05/05 v2] gpio: em: Enable mask on suspend
> 
> Update the R-Car GPIO driver and the GPIO driver used on EMEV2 to use lazy
> disable and mask on suspend. This fixes the Suspend-to-RAM behavior to make
> sure wakeup sources are left enabled while suspending. Also include a small
> fix for gpio-em that fixes the DT use case.
> 
> Thanks to Laurent and Linus for feedback.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

For the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  Written against renesas.git tag renesas-devel-v3.12-20131119
> 
>  Changes since V1:
>  - Split lazy disable and mask on suspend patches
>  - Improved commit messages
> 
>  drivers/gpio/gpio-em.c   |    5 ++---
>  drivers/gpio/gpio-rcar.c |    5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
-- 
Regards,

Laurent Pinchart

