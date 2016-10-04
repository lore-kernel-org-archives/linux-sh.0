From: Rich Felker <dalias@libc.org>
Date: Tue, 04 Oct 2016 20:58:37 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161004205837.GC19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1474693319.git.dalias@libc.org>
 <22c1ee0f908fe3bf8b70f5e87d659ceb29af1434.1474693319.git.dalias@libc.org>
 <20160926210716.GA12855@brightrain.aerifal.cx>
 <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
 <20161003221039.GR19318@brightrain.aerifal.cx>
 <20161004070623.GM14933@linux.vnet.ibm.com>
In-Reply-To: <20161004070623.GM14933-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

On Tue, Oct 04, 2016 at 12:06:23AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 03, 2016 at 06:10:39PM -0400, Rich Felker wrote:
> > On Mon, Sep 26, 2016 at 11:27:14PM +0200, Daniel Lezcano wrote:
> > > On 26/09/2016 23:07, Rich Felker wrote:
> > > > Ping. Is there anything that still needs to be changed for this driver
> > > > to be acceptable?
> > > 
> > > It is on my radar. I'm reviewing it.
> > > 
> > > Can you elaborate the workaround mentioned in the changelog. I have been
> > > digging into the lkml@ thread but it is not clear if the issue is
> > > related to the time framework, the driver itself or whatever else. Can
> > > you clarify that ?
> > 
> > Do you have comments on any remaining issues other than this
> > workaround? If not I don't mind removing the workaround and trying to
> > solve the issue separately later. Let me know and either way I'll
> > submit a v8.
> 
> One question of interest to me is whether this patchset prevents the
> RCU CPU stall warnings that you are seeing.

With the 5ms minimum delta, I didn't observe any rcu_sched stall
warnings. At 2.5ms I thought it was gone but eventually saw one. With
the previous mindelta = 1, i.e. 1 hardware bus period, I get the
stalls regularly.

Rich
