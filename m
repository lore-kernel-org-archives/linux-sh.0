From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 23 Feb 2012 15:30:58 +0000
Subject: Re: [PATCH] mackerel: Do not enable TMU timer in default config
Message-Id: <20120223153058.GA9994@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1329111377-15676-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1329111377-15676-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 23, 2012 at 07:06:41PM +0900, Simon Horman wrote:
> I would appreciate it if you could consider this change for 3.3.
> 
> It is a band-aid solution, however, it resolves a regression -
> the boot or lack thereof of a mackerel board using the default config -
> since 3.2.
> 
> I have discussed this a little with Magnus Damm and he is of
> the opinion that this problem likely relates to an interaction
> between TMU and power domains and that a full fix would be difficult
> within the 3.3 time-frame.
> 
If there is a problem with the TMU driver then it needs to be fixed,
especially if this is a regression. We aren't going to paper over real
bugs by just disabling the offending driver in the defconfig, all it does
is encourage people to not fix the problem later, and the same workaround
can be done locally if there's no desire to actually hunt down and fix
the regression.
