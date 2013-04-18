From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Apr 2013 13:34:08 +0000
Subject: Re: [PATCH 1/4] SH: cpuidle: remove pointless initialization
Message-Id: <20130418133408.GF20929@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org>
 <20130418011816.GD4511@verge.net.au>
 <516FBA4C.6020100@linaro.org>
In-Reply-To: <516FBA4C.6020100@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lethal@linux-sh.org, rjw@sisk.pl, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org

On Thu, Apr 18, 2013 at 11:18:04AM +0200, Daniel Lezcano wrote:
> On 04/18/2013 03:18 AM, Simon Horman wrote:
> > On Wed, Apr 17, 2013 at 03:32:54PM +0200, Daniel Lezcano wrote:
> >> The driver is a global static variable automatically initialized to zero.
> >>
> >> Removing the useless initialization in the init function.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > 
> > Hi Daniel,
> > 
> > All four patches in this series seem reasonable to me.
> > 
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Please let me know if I should take them through my renesas tree.
> 
> If you are ok with that, is it possible to take them through the
> linux-pm tree ? So the cpuidle drivers are synced and I can continue the
> code consolidation ?

Yes, I am ok with them going through the linux-pm tree.
