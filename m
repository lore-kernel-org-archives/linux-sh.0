From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 17 Dec 2014 00:39:36 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a73a4: Remove legacy code
Message-Id: <3320870.xogZ3DX5z0@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1418771008-5676-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418771008-5676-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 17 December 2014 09:30:36 Simon Horman wrote:
> On Wed, Dec 17, 2014 at 01:03:28AM +0200, Laurent Pinchart wrote:
> > All r8a73a4 boards are now used with multiplatform kernels only. We can
> > remove all the unused r8a73a4 legacy device and clock registration code.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  arch/arm/mach-shmobile/Makefile        |   1 -
> >  arch/arm/mach-shmobile/clock-r8a73a4.c | 659 ----------------------------
> >  arch/arm/mach-shmobile/r8a73a4.h       |  17 -
> >  arch/arm/mach-shmobile/setup-r8a73a4.c | 273 +-------------
> >  4 files changed, 2 insertions(+), 948 deletions(-)
> >  delete mode 100644 arch/arm/mach-shmobile/clock-r8a73a4.c
> >  delete mode 100644 arch/arm/mach-shmobile/r8a73a4.h
> > 
> > Hi Ulrich,
> > 
> > You might want to consider adding this patch to the end of your series.
> 
> Many lines removed. Wonderful!

You should thank Ulrich for that, he's responsible for the work that made this 
possible (not to mention that his latest ape6evm patch series removes quite a 
lot of code too).

That being said, mach-shmobile is slowly getting leaner and cleaner, it's nice 
to see. Thank you to everybody who made this possible, the work might not be 
sexy, but it's definitely appreciated.

-- 
Regards,

Laurent Pinchart

