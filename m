From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 25 Jan 2016 19:03:51 +0000
Subject: Re: [PATCH 1/2] v4l: vsp1: Add missing #include <linux/sched.h>
Message-Id: <11540092.dX60pYHxh5@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1452536727-19538-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1452536727-19538-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Monday 25 January 2016 08:50:04 Geert Uytterhoeven wrote:
> On Mon, Jan 25, 2016 at 1:37 AM, Laurent Pinchart wrote:
> > I wonder, though, whether the right solution wouldn't be to fix wait.h and
> > sched.h. They seem to depend on each other.
> 
> Include shuffling involving sched.h usually breaks something else, due to
> include hell.

Hence why I think that's where the real fix should go :-)

> >> ---
> >> Against renesas-drivers-2016-01-05-v4.4-rc8
> >> 
> >>  drivers/media/platform/vsp1/vsp1_pipe.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c
> >> b/drivers/media/platform/vsp1/vsp1_pipe.c index
> >> 96f0e7d4c400172e..2283e64f12faadd1 100644
> >> --- a/drivers/media/platform/vsp1/vsp1_pipe.c
> >> +++ b/drivers/media/platform/vsp1/vsp1_pipe.c
> >> @@ -13,6 +13,7 @@
> >> 
> >>  #include <linux/delay.h>
> >>  #include <linux/list.h>
> >> 
> >> +#include <linux/sched.h>

-- 
Regards,

Laurent Pinchart

