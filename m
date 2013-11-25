From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 25 Nov 2013 14:19:23 +0000
Subject: Re: [PATCH v2 2/3] ARM: shmobile: r8a7779: Wait for status on selected MSTP clocks
Message-Id: <1397664.zthTyjlFEb@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1384357973-27365-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384357973-27365-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Monday 25 November 2013 12:36:31 Simon Horman wrote:
> On Sun, Nov 24, 2013 at 04:23:50PM -0800, Kuninori Morimoto wrote:
> > Hi Laurent, Simon
> > 
> > > > > I've removed them as they're unused. This could be split to a
> > > > > separate patch if preferred, I've just thought it would be overkill.
> > > > 
> > > > Yes, they are not used, but it doesn't have relationship to this
> > > > patch.
> > > 
> > > I've considered the change to be related, at this patch fixes the MSTP
> > > clock definitions. Of course if you disagree I'm fine with removing
> > > this change.
> > > >
> > > > (and, do we really need to remove these ?)
> > > 
> > > They're not used, so I thought it would be good to remove them.
> > > 
> > > > This is not super big deal,
> > > > but I was ordered many times not to do such things at other ML.
> > > > 
> > > > Let's follow the opinion of Simon.
> > > 
> > > Sounds good to me :-)
> > 
> > Thank you :)
> > Sorry for my picky comment :P
> > 
> > Simon, we need your opinion.
> 
> I would prefer separate patches.

OK, I'll resubmit this patch without the removal of the unused macros. As 
you've originally submitted a patch to remove the macros, would you like to 
rebase it on top of this, or should I include one in the repost ?

-- 
Regards,

Laurent Pinchart

