From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Tue, 04 Oct 2016 21:14:51 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161004211451.GZ14933@linux.vnet.ibm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1474693319.git.dalias@libc.org>
 <22c1ee0f908fe3bf8b70f5e87d659ceb29af1434.1474693319.git.dalias@libc.org>
 <20160926210716.GA12855@brightrain.aerifal.cx>
 <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
 <20161003221039.GR19318@brightrain.aerifal.cx>
 <20161004070623.GM14933@linux.vnet.ibm.com>
 <20161004205837.GC19318@brightrain.aerifal.cx>
In-Reply-To: <20161004205837.GC19318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Oct 04, 2016 at 04:58:37PM -0400, Rich Felker wrote:
> On Tue, Oct 04, 2016 at 12:06:23AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 03, 2016 at 06:10:39PM -0400, Rich Felker wrote:
> > > On Mon, Sep 26, 2016 at 11:27:14PM +0200, Daniel Lezcano wrote:
> > > > On 26/09/2016 23:07, Rich Felker wrote:
> > > > > Ping. Is there anything that still needs to be changed for this driver
> > > > > to be acceptable?
> > > > 
> > > > It is on my radar. I'm reviewing it.
> > > > 
> > > > Can you elaborate the workaround mentioned in the changelog. I have been
> > > > digging into the lkml@ thread but it is not clear if the issue is
> > > > related to the time framework, the driver itself or whatever else. Can
> > > > you clarify that ?
> > > 
> > > Do you have comments on any remaining issues other than this
> > > workaround? If not I don't mind removing the workaround and trying to
> > > solve the issue separately later. Let me know and either way I'll
> > > submit a v8.
> > 
> > One question of interest to me is whether this patchset prevents the
> > RCU CPU stall warnings that you are seeing.
> 
> With the 5ms minimum delta, I didn't observe any rcu_sched stall
> warnings. At 2.5ms I thought it was gone but eventually saw one. With
> the previous mindelta = 1, i.e. 1 hardware bus period, I get the
> stalls regularly.

Sounds to me like your low-level clock drivers or your clock hardware is
having trouble dealing with short timeouts.  I suggest writing a focused
test.  It is of course quite possible that the failure could occur for
any time period, but simply becomes less probable with longer time
periods.

Or perhaps better, do the tracing that Thomas Gleixner suggested.  Or both,
in order to get the most information in the shortest period of time.

							Thanx, Paul

