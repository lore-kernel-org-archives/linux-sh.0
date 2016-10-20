From: Rich Felker <dalias@libc.org>
Date: Thu, 20 Oct 2016 18:29:13 +0000
Subject: Re: [PATCH v9 0/2] J-Core timer support
Message-Id: <20161020182913.GS19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1476393790.git.dalias@libc.org>
 <20161017093013.GA1703@mai>
 <20161020012225.GK19318@brightrain.aerifal.cx>
 <20161020073240.GF1703@mai>
 <20161020151552.GQ19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610201955230.4938@nanos>
In-Reply-To: <alpine.DEB.2.20.1610201955230.4938@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Thu, Oct 20, 2016 at 07:56:09PM +0200, Thomas Gleixner wrote:
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

Thanks Thomas. Daniel, sorry if my above reply was harsh and thanks
again for all your help reviewing and getting this upstream.

Rich
