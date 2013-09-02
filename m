From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 02 Sep 2013 13:41:55 +0000
Subject: Re: [RFC 10/10] ARM: shmobile: r8a7790: lager: HDMI output via DU and ADV7511
Message-Id: <1535400.aGgoBfJC9M@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1377866264-21110-11-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1377866264-21110-11-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday 30 August 2013 21:38:53 Sergei Shtylyov wrote:
> On 08/30/2013 04:37 PM, Ulrich Hecht wrote:
> > This builds and runs but is unlikely to provide useful output as I do not
> > have physical access to a Lager board yet.
> > 
> > Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> > ---
> > 
> >   arch/arm/mach-shmobile/board-lager.c | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-lager.c
> > b/arch/arm/mach-shmobile/board-lager.c index c6b5f21..edd0f3e 100644
> > --- a/arch/arm/mach-shmobile/board-lager.c
> > +++ b/arch/arm/mach-shmobile/board-lager.c
> > @@ -40,12 +40,20 @@
> > 
> >   #include <asm/mach-types.h>
> >   #include <asm/mach/arch.h>
> > 
> > +#include "../../../drivers/gpu/drm/i2c/adv7511.h"
> 
> Shouldn't this header moved into include/linux/platform_data/ first?

Agreed. The header should even be split into platform data (to be moved to 
include/linux/platform_data/adv7511.h) and driver-private data that can be 
kept in drivers/gpu/drm/i2c/adv7511.h (or possibly be moved to 
drivers/gpu/drm/i2c/adv7511.c, I have no strong preference there).

-- 
Regards,

Laurent Pinchart

