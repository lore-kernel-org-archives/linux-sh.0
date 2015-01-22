From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 Jan 2015 00:36:39 +0000
Subject: Re: [PATCH] [media] v4l: vsp1: bru: Fix minimum input pixel size
Message-Id: <1786801.5JPtxNYoMj@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1421885663-19565-1-git-send-email-taki@igel.co.jp>
In-Reply-To: <1421885663-19565-1-git-send-email-taki@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takanari Hayama <taki@igel.co.jp>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org

Hi Hayama-san,

Thank you for the patch.

On Thursday 22 January 2015 09:14:23 Takanari Hayama wrote:
> According to the spec, the minimum input pixel size for BRU is 1px,
> not 4px.
> 
> Signed-off-by: Takanari Hayama <taki@igel.co.jp>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/platform/vsp1/vsp1_bru.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_bru.c
> b/drivers/media/platform/vsp1/vsp1_bru.c index b21f381..401e2b7 100644
> --- a/drivers/media/platform/vsp1/vsp1_bru.c
> +++ b/drivers/media/platform/vsp1/vsp1_bru.c
> @@ -20,7 +20,7 @@
>  #include "vsp1_bru.h"
>  #include "vsp1_rwpf.h"
> 
> -#define BRU_MIN_SIZE				4U
> +#define BRU_MIN_SIZE				1U
>  #define BRU_MAX_SIZE				8190U
> 
>  /* ------------------------------------------------------------------------

-- 
Regards,

Laurent Pinchart

