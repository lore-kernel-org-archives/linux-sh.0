From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 25 Jan 2016 00:37:29 +0000
Subject: Re: [PATCH 1/2] v4l: vsp1: Add missing #include <linux/sched.h>
Message-Id: <3784599.FUrD4bMggB@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1452536727-19538-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1452536727-19538-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Monday 11 January 2016 19:25:26 Geert Uytterhoeven wrote:
> If CONFIG_SPI=n:
> 
> drivers/media/platform/vsp1/vsp1_pipe.c: In function 'vsp1_pipeline_stop':
> drivers/media/platform/vsp1/vsp1_pipe.c:226:429: error:
> 'TASK_UNINTERRUPTIBLE' undeclared (first use in this function) ret > wait_event_timeout(pipe->wq, vsp1_pipeline_stopped(pipe), ^
> drivers/media/platform/vsp1/vsp1_pipe.c:226:429: note: each undeclared
> identifier is reported only once for each function it appears in
> drivers/media/platform/vsp1/vsp1_pipe.c:226:642: error:
> 'TASK_INTERRUPTIBLE' undeclared (first use in this function) ret > wait_event_timeout(pipe->wq, vsp1_pipeline_stopped(pipe), ^
> drivers/media/platform/vsp1/vsp1_pipe.c:226:688: error: 'TASK_KILLABLE'
> undeclared (first use in this function) ret = wait_event_timeout(pipe->wq,
> vsp1_pipeline_stopped(pipe), ^
> drivers/media/platform/vsp1/vsp1_pipe.c:226:3: error: implicit declaration
> of function 'schedule_timeout' [-Werror=implicit-function-declaration] ret
> = wait_event_timeout(pipe->wq, vsp1_pipeline_stopped(pipe), ^
> drivers/media/platform/vsp1/vsp1_pipe.c: In function
> 'vsp1_pipeline_frame_end': drivers/media/platform/vsp1/vsp1_pipe.c:287:24:
> error: 'TASK_NORMAL' undeclared (first use in this function)
> wake_up(&pipe->wq);
>                         ^
> drivers/media/platform/vsp1/vsp1_pipe.c: In function
> 'vsp1_pipelines_suspend': drivers/media/platform/vsp1/vsp1_pipe.c:378:429:
> error: 'TASK_UNINTERRUPTIBLE' undeclared (first use in this function) ret > wait_event_timeout(pipe->wq, vsp1_pipeline_stopped(pipe), ^
> drivers/media/platform/vsp1/vsp1_pipe.c:378:642: error: 'TASK_INTERRUPTIBLE'
> undeclared (first use in this function) ret = wait_event_timeout(pipe->wq,
> vsp1_pipeline_stopped(pipe), ^
> drivers/media/platform/vsp1/vsp1_pipe.c:378:688: error: 'TASK_KILLABLE'
> undeclared (first use in this function) ret = wait_event_timeout(pipe->wq,
> vsp1_pipeline_stopped(pipe), ^
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I've squashed the fix with the patch that introduced the issue, as it's not 
upstream yet.

I wonder, though, whether the right solution wouldn't be to fix wait.h and 
sched.h. They seem to depend on each other.

> ---
> Against renesas-drivers-2016-01-05-v4.4-rc8
> 
>  drivers/media/platform/vsp1/vsp1_pipe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c
> b/drivers/media/platform/vsp1/vsp1_pipe.c index
> 96f0e7d4c400172e..2283e64f12faadd1 100644
> --- a/drivers/media/platform/vsp1/vsp1_pipe.c
> +++ b/drivers/media/platform/vsp1/vsp1_pipe.c
> @@ -13,6 +13,7 @@
> 
>  #include <linux/delay.h>
>  #include <linux/list.h>
> +#include <linux/sched.h>
>  #include <linux/wait.h>
> 
>  #include <media/media-entity.h>

-- 
Regards,

Laurent Pinchart

