From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 12 May 2014 12:44:36 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: genmai-reference: Switch to new style MTU device
Message-Id: <1751770.qQ4mhXj5fn@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1399898169-22067-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1399898169-22067-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Monday 12 May 2014 14:36:09 Geert Uytterhoeven wrote:
> The MTU2 (Multi-Function Timer Pulse Unit 2) driver implements a new
> style of platform data that handles the timer as a single device with
> multiple channels. Switch from the old-style platform data to the
> new-style platform data.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> To be folded into Wolfram's "ARM: shmobile: r7s72100: use workaround for
> non DT-clocks".
> 
>  arch/arm/mach-shmobile/board-genmai-reference.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c
> b/arch/arm/mach-shmobile/board-genmai-reference.c index
> fde558b66d4e..33015e5ed52a 100644
> --- a/arch/arm/mach-shmobile/board-genmai-reference.c
> +++ b/arch/arm/mach-shmobile/board-genmai-reference.c
> @@ -32,7 +32,7 @@
>   * devices until they get moved to DT.
>   */
>  static const struct clk_name clk_names[] = {
> -	{ "mtu2", NULL, "sh_mtu2.0" },
> +	{ "mtu2", "fck", "sh-mtu2" },
>  };
>  #endif

-- 
Regards,

Laurent Pinchart

