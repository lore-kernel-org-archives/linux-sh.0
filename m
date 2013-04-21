From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 21 Apr 2013 23:28:59 +0000
Subject: Re: [PATCH 1/4] SH: cpuidle: remove pointless initialization
Message-Id: <170826456.rDBb7Co9qj@vostro.rjw.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org> <20130418133408.GF20929@verge.net.au> <516FF6B5.4070508@linaro.org>
In-Reply-To: <516FF6B5.4070508@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Simon Horman <horms@verge.net.au>, lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org

On Thursday, April 18, 2013 03:35:49 PM Daniel Lezcano wrote:
> On 04/18/2013 03:34 PM, Simon Horman wrote:
> > On Thu, Apr 18, 2013 at 11:18:04AM +0200, Daniel Lezcano wrote:
> >> On 04/18/2013 03:18 AM, Simon Horman wrote:
> >>> On Wed, Apr 17, 2013 at 03:32:54PM +0200, Daniel Lezcano wrote:
> >>>> The driver is a global static variable automatically initialized to zero.
> >>>>
> >>>> Removing the useless initialization in the init function.
> >>>>
> >>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>
> >>> Hi Daniel,
> >>>
> >>> All four patches in this series seem reasonable to me.
> >>>
> >>> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> >>>
> >>> Please let me know if I should take them through my renesas tree.
> >>
> >> If you are ok with that, is it possible to take them through the
> >> linux-pm tree ? So the cpuidle drivers are synced and I can continue the
> >> code consolidation ?
> > 
> > Yes, I am ok with them going through the linux-pm tree.
> 
> Thanks !

OK, applied.

Patch [3/4] had a merge conflict against the current Linus' tree, so I've fixed
it up manually.  Please check the linux-next branch for the result (will
probably conflict with the shmobile tree in linux-next, but that's not a big
deal).

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
