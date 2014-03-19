From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 19 Mar 2014 10:17:37 +0000
Subject: Re: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <7231108.PjP7GBxrsJ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Wednesday 19 March 2014 09:19:44 Ben Dooks wrote:
> On 17/03/14 14:41, Laurent Pinchart wrote:
> > On Monday 17 March 2014 13:36:33 Ben Dooks wrote:
> > 
> > [snip]
> > 
> >>   From pm_runtime.h:
> >> static inline int pm_runtime_get_sync(struct device *dev)
> >> {
> >> 	return __pm_runtime_resume(dev, RPM_GET_PUT);
> >> }
> >> 
> >> static inline int pm_request_resume(struct device *dev)
> >> {
> >> 	return __pm_runtime_resume(dev, RPM_ASYNC);
> >> }
> >> 
> >> So it looks like pm_runtime_resume() does not protect against the
> >> possibility that something else may re-suspend the device.
> > 
> > Correct.
> > 
> >> I have yet to ascertain how this ends up happening with device probe, it
> >> seems to be very dependant on the code.
> > 
> > We might be doing something wrong in the driver from a runtime PM point of
> > view that leads to the device being suspended. I'd like to catch that
> > instead of hiding it by a pm_runtime_get_sync() call. If it turns out
> > that we're not doing anything wrong then replacing pm_runtime_resume()
> > with pm_runtime_get_sync() would of course be fine.
> 
> My view is the pm_runtime)_resume() is just nasty, as it makes no guarantees
> that the device cannot be re-suspended.

My point is that requiring such a guarantee at probe time might be a sign that 
something else is wrong (which was the case with the sh-eth driver). I'm not 
saying it should never be done of course.

-- 
Regards,

Laurent Pinchart

