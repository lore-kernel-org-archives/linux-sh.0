From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 25 Apr 2008 06:22:08 +0000
Subject: Re: [PATCH] i2c: Renesas Highlander FPGA SMBus support.
Message-Id: <20080425062208.GA29452@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080325063236.GA29012@linux-sh.org> <20080423134156.1b368163@hyperion.delvare> <20080423181101.GA2931@roarinelk.homelinux.net> <20080423203104.0ca0f301@hyperion.delvare> <20080425013011.GA27359@linux-sh.org> <20080424231207.11a03f3d.akpm@linux-foundation.org>
In-Reply-To: <20080424231207.11a03f3d.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: khali@linux-fr.org, mano@roarinelk.homelinux.net, i2c@lm-sensors.org, linux-sh@vger.kernel.org, damm@igel.co.jp

On Thu, Apr 24, 2008 at 11:12:07PM -0700, Andrew Morton wrote:
> > On Fri, 25 Apr 2008 10:30:11 +0900 Paul Mundt <lethal@linux-sh.org> wrote:
> > On Wed, Apr 23, 2008 at 08:31:04PM +0200, Jean Delvare wrote:
> > > On Wed, 23 Apr 2008 20:11:01 +0200, Manuel Lauss wrote:
> > > > I don't think I'm qualified to review other peoples' code (it looks
> > > > fine to me).
> 
> I looked through it when I merged it - believe it or not, I always do
> (well, except for some dopey mechanical code transformation patches where
> I'll just believe the changelog).  I saw nothing worth commenting on.  As
> is always the case when I don't comment ;)
> 
> So here's a
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Although that is of course of limited use, coming from a person
> who isn't terribly sure what an i2c is.

This is the root of the issue, none of the people asked to review the
code are i2c people either. This is a pretty sad state for the subsystem
if the subsystem maintainer needs to defer to people with little to no
knowledge of the subsystem to "review" a driver before it can be merged.

While Manuel, Magnus, and I can easily review and ack our patches, none
of this changes the fact that outside of the platform and architecture
specific bits in the driver, there's very little we can generally comment
on. The reason for soliciting feedback from the i2c list in the first
place was to get review and comments on the subsystem-specific bits from
the people who are obviously far more familiar with these things. I
understand that Jean isn't an embedded person and therefore isn't
comfortable reviewing those sorts of drivers, but in these cases it's the
bus-specific stuff where the review really matters, which obviously the
rest of us aren't in the best position to self-review.

If it's not possible to get a subsystem maintainer to review a patch,
what's the point of having a centralized subsystem in the first place?
