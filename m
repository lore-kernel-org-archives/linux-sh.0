From: Simon Horman <horms@verge.net.au>
Date: Mon, 22 Apr 2013 03:31:57 +0000
Subject: Re: [PATCH v2 0/3] sh-pfc: r8a7779: Improve readability with a new macro
Message-Id: <20130422033157.GA17026@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365415532-24544-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1365415532-24544-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Thu, Apr 11, 2013 at 05:07:53PM +0900, Simon Horman wrote:
> On 火,  4月 09, 2013 at 03:14:40午後 +0200, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > On Tuesday 09 April 2013 22:13:25 Simon Horman wrote:
> > > On 月,  4月 08, 2013 at 12:05:29午後 +0200, Laurent Pinchart wrote:
> > > > Hello,
> > > > 
> > > > This is the second version of the r8a7779 PFC readability improvement
> > > > patches that use a macro to convert from the documentation pin number
> > > > space to the linear pinctrl space.
> > > > 
> > > > Note that patch 1/3 has already been posted as part of the "r8a7790 PFC
> > > > pinctrl and GPIO improvements" patch series. Depending on the merge order
> > > > one of them should be dropped.
> > > > 
> > > > Simon, is there a chance you could queue this to your pinmux branch for
> > > > v3.10 ?
> > >
> > > If it is urgent, yes. Otherwise I'd prefer to wait for v3.11.
> > 
> > That's fine with me.
> > 
> > > In any case, Magnus, can I get a review?
> > > 
> > > > Changes from v1:
> > > > 
> > > > - Rename the macro to RCAR_GP_PIN
> > > > - Define the macro in a single header file
> > > > 
> > > > Laurent Pinchart (3):
> > > >   gpio-rcar: Add RCAR_GP_PIN macro
> 
> I have queued-up the above patch for v3.11 in the pinmux branch.
> 
> > > >   sh-pfc: r8a7779: Replace hardcoded pin numbers with RCAR_GP_PIN macro
> 
> I have merged the pinmux branch into the soc-r8a7779 branch and
> queued-up the above patch there.

I have moved the above patch to the pinmux branch as it seems to
be a more appropriate location for it. It is also a dependency of
"sh-pfc: r8a7779: add VIN pin groups" which I had applied to the pinmux
branch.

> > > >   ARM: shmobile: marzen: Use RCAR_GP_PIN macro
> 
> I have merged the pinmux branch into the boards-marzen branch and
> queued-up the above patch there.
