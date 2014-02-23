From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 23 Feb 2014 22:13:42 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: r8a7791: add IIC0/1 clock macros
Message-Id: <1994424.zdgq2k4xTD@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1389121036-3555-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1389121036-3555-2-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

On Sunday 23 February 2014 13:40:21 Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
>  include/dt-bindings/clock/r8a7791-clock.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/r8a7791-clock.h
> b/include/dt-bindings/clock/r8a7791-clock.h index 30f82f2..9aa60f4 100644
> --- a/include/dt-bindings/clock/r8a7791-clock.h
> +++ b/include/dt-bindings/clock/r8a7791-clock.h
> @@ -55,6 +55,8 @@
>  #define R8A7791_CLK_CMT1		29
>  #define R8A7791_CLK_USBDMAC0		30
>  #define R8A7791_CLK_USBDMAC1		31
> +#define R8A7791_CLK_IIC0		18
> +#define R8A7791_CLK_IIC1		23

Could you please keep the entries sorted by value ?

>  /* MSTP5 */
>  #define R8A7791_CLK_THERMAL		22

-- 
Regards,

Laurent Pinchart

