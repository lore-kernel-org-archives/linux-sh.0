From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 15 May 2013 00:30:28 +0000
Subject: Re: [PATCH 0/2] marzen-reference ethernet patches
Message-Id: <4925480.65O1CRSMG7@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1368567312-11640-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1368567312-11640-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 15 May 2013 09:26:24 Simon Horman wrote:
> On Tue, May 14, 2013 at 11:35:10PM +0200, Laurent Pinchart wrote:
> > Hello,
> > 
> > Here are two small patches that attemps to fix ethernet support for the
> > marzen-reference board. Unfortunately this doesn't seem to be enough, I
> > still can't get any meaningful interrupt from the smsc911x ethernet
> > controller.
> > 
> > I'm probably not going to spend more time on this, it would be appreciated
> > if anyone could take over.
> 
> Thanks for these. I have also previously unsuccessfully tried  to
> get ethernet working for marzen-reference. I'll try again basing
> my work on these new patches that you have provided.

Thanks. I've tried to solve the issue for a couple of hours tonight, and ran 
into irqpin-related interrupt storms. Guennadi has posted a patch to fix the 
problem a while ago ("[PATCH 1/3] ARM: shmobile: irqpin: fix handling of 
spurious interrupts in DT case") but it got rejected. Fixing that might be a 
prerequisite to get ethernet working correctly.

-- 
Regards,

Laurent Pinchart

