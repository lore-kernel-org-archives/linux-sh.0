From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Tue, 04 Oct 2016 07:06:23 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161004070623.GM14933@linux.vnet.ibm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1474693319.git.dalias@libc.org>
 <22c1ee0f908fe3bf8b70f5e87d659ceb29af1434.1474693319.git.dalias@libc.org>
 <20160926210716.GA12855@brightrain.aerifal.cx>
 <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
 <20161003221039.GR19318@brightrain.aerifal.cx>
In-Reply-To: <20161003221039.GR19318-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

On Mon, Oct 03, 2016 at 06:10:39PM -0400, Rich Felker wrote:
> On Mon, Sep 26, 2016 at 11:27:14PM +0200, Daniel Lezcano wrote:
> > On 26/09/2016 23:07, Rich Felker wrote:
> > > Ping. Is there anything that still needs to be changed for this driver
> > > to be acceptable?
> > 
> > It is on my radar. I'm reviewing it.
> > 
> > Can you elaborate the workaround mentioned in the changelog. I have been
> > digging into the lkml@ thread but it is not clear if the issue is
> > related to the time framework, the driver itself or whatever else. Can
> > you clarify that ?
> 
> Do you have comments on any remaining issues other than this
> workaround? If not I don't mind removing the workaround and trying to
> solve the issue separately later. Let me know and either way I'll
> submit a v8.

One question of interest to me is whether this patchset prevents the
RCU CPU stall warnings that you are seeing.

							Thanx, Paul

