From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 09 Apr 2013 13:28:16 +0000
Subject: Re: [PATCH v2] sh-pfc: Add entries for INTC external IRQs
Message-Id: <2649778.IYhvDiFtPl@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1365504530-32232-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1365504530-32232-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Bastian,

Thanks for the patch.

On Tuesday 09 April 2013 12:48:50 Bastian Hecht wrote:
> We add all necessary entries to support the external IRQs from the INTC.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2:
> - massive sorting
> - introduction of index instead of pointing by port number
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  174 +++++++++++++++++++++++++++++++
>  1 file changed, 174 insertions(+)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c index 21ff7f2..4753f54 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> @@ -1658,6 +1674,59 @@ static struct sh_pfc_pin pinmux_pins[] = {

[snip]

> +IRQC_PINS_MUX(9, 1, 210);

[snip]

> +IRQC_PINS_MUX(16, 1, 211);

My version of the datasheet doesn't include pins 210 and 211 in the list of 
multiplexed pins, so I'll trust you on these two. I've checked all the other 
pins.

-- 
Regards,

Laurent Pinchart

