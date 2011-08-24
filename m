From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 24 Aug 2011 20:52:24 +0000
Subject: Re: [PATCH 2/2 v2] sh-sci / PM: Use power.irq_safe
Message-Id: <201108242252.25098.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201108202131.19479.rjw@sisk.pl> <201108212111.45012.rjw@sisk.pl> <20110824053317.GC26391@linux-sh.org>
In-Reply-To: <20110824053317.GC26391@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>

On Wednesday, August 24, 2011, Paul Mundt wrote:
> On Sun, Aug 21, 2011 at 09:11:44PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Since sci_port_enable() and sci_port_disable() may be run with
> > interrupts off and they execute pm_runtime_get_sync() and
> > pm_runtime_put_sync(), respectively, the SCI device's
> > power.irq_safe flags has to be used to indicate that it is safe
> > to execute runtime PM callbacks for this device with interrupts off.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Not sure how you want this one handled. Did you simply want to roll this
> in with your other patch with my Acked-by, or should I be taking this
> through my tree already regardless of the 1/2 patch?

I'd prefer to push it through my tree, if you don't mind.  Magnus has
already acked it for me, hopefully that's OK?

Rafael
