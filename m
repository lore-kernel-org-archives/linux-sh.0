From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 12 May 2014 19:48:59 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: Correct SYS-DMAC clock defines
Message-Id: <1879564.Q0Zk545mJH@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1399920573-30947-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1399920573-30947-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Monday 12 May 2014 20:49:33 Geert Uytterhoeven wrote:
> R-Car M2 has two MSTP bits for SYS-DMAC, not one.
> Also bring the naming in sync with the documentation.
> 
> This issue was introduced in v3.14, in commit
> 4d8864c9e94ec727f1c675b9f6921525c360334b ("ARM: shmobile: r8a7791: Add
> clock index macros for DT sources").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> I believe there are no users of the incorrect definition.
> ---
>  include/dt-bindings/clock/r8a7791-clock.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/r8a7791-clock.h
> b/include/dt-bindings/clock/r8a7791-clock.h index
> 29b0f3355ffb..b050d18437ce 100644
> --- a/include/dt-bindings/clock/r8a7791-clock.h
> +++ b/include/dt-bindings/clock/r8a7791-clock.h
> @@ -43,7 +43,8 @@
>  #define R8A7791_CLK_SCIFB1		7
>  #define R8A7791_CLK_MSIOF1		8
>  #define R8A7791_CLK_SCIFB2		16
> -#define R8A7791_CLK_DMAC		18
> +#define R8A7791_CLK_SYS_DMAC1		18
> +#define R8A7791_CLK_SYS_DMAC0		19
> 
>  /* MSTP3 */
>  #define R8A7791_CLK_TPU0		4

-- 
Regards,

Laurent Pinchart

