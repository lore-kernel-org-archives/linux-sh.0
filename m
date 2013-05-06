From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 06 May 2013 22:43:56 +0000
Subject: Re: [PATCH v3 13/64] sh-pfc: r8a7779: Add USB0 and USB1 PENC pinmux support
Message-Id: <5188322C.1090600@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362740544-19164-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362740544-19164-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 03/08/2013 02:01 PM, Laurent Pinchart wrote:

> The USB0 and USB1 PENC functions were missing. Add them.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> index 492832c..4ab7b11 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> @@ -429,7 +429,8 @@ enum {
>   	A0_MARK, SD1_DAT3_MARK, MMC0_D3_MARK, FD3_MARK,
>   	BS_MARK, SD1_DAT2_MARK, MMC0_D2_MARK, FD2_MARK,
>   	ATADIR0_MARK, SDSELF_MARK, HCTS1_MARK, TX4_C_MARK,
> -	USB_PENC2_MARK, SCK0_MARK, PWM1_MARK, PWMFSW0_MARK,
> +	USB_PENC0_MARK, USB_PENC1_MARK, USB_PENC2_MARK,

    PENCn pins don't have USB_ prefix in the manual, so somebody 
deliberately added
it before to FN_USB_PENC. That probably contributed to further confusion 
where PENCn
were grouped together with USB_OVCn  -- which are usually unused and are 
3.3V
alternatives of OVCn 5V pins (which are not multiplexed at all).

WBR, Sergei

