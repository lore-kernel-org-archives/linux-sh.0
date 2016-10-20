From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 20 Oct 2016 18:07:12 +0000
Subject: Re: [PATCH v9 0/2] J-Core timer support
Message-Id: <alpine.DEB.2.20.1610202005150.4938@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1476393790.git.dalias@libc.org> <20161017093013.GA1703@mai> <20161020012225.GK19318@brightrain.aerifal.cx> <20161020073240.GF1703@mai> <20161020151552.GQ19318@brightrain.aerifal.cx> <alpine.DEB.2.20.1610201955230.4938@nanos>
In-Reply-To: <alpine.DEB.2.20.1610201955230.4938@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

On Thu, 20 Oct 2016, Thomas Gleixner wrote:
> Daniel,
> 
> On Thu, 20 Oct 2016, Rich Felker wrote:
> > On Thu, Oct 20, 2016 at 09:32:40AM +0200, Daniel Lezcano wrote:
> > > Unfortunately it won't happen. v4.9-rc1 is already out. The driver will be
> > > in v4.10.
> > > 
> > > If you wanted patches merged for v4.9, they should have been merged in the
> > > downstream tree before v4.8-rc5, so they hit the upstream tree for v4.9's merge
> > > window.
> > 
> > I've been trying to get what's essentially the same patch merged since
> > before the 4.8 merge window. I would be more understanding if this
> > were something new that's not upstream, but broken support for the
> > hardware (that, from a user perspective, is a bug, since they can
> > select the target but then it doesn't boot) has already been in one
> > release due to missing core drivers, and the irq patches have already
> > been merged in this release (post-rc1 even).
> 
> It's hardware enablement and not a new feature, so it's fine to merge it
> now. I'll pick it up later tonight.

Daniel, it's the top two commits in your 4.10 branch. So it's not a big
deal to zap them.

Thanks,

	tglx
