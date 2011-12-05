From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 05 Dec 2011 00:17:05 +0000
Subject: Re: [PATCH] PM / sh7372: Make domain stay_on bit only affect system suspend
Message-Id: <201112050117.05214.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201112042308.14255.rjw@sisk.pl>
In-Reply-To: <201112042308.14255.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Sunday, December 04, 2011, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> SH7372 uses two independent mechanisms for ensuring that power
> domains will never be turned off: the stay_on flag and the "always
> on" domain governor.  However, the "always on" governor is only taken
> into accout by runtime PM code paths, while the stay_on flag affects
> all attempts to turn the given domain off.  This is a problem for
> domains that only need to stay in the "power on" state during system
> sleep, but may be turned off by runtime PM if specific conditions are
> satisfied.  For this reason, make SH7372 register a PM notifier that
> will enable the checking of the domain stay_on flag on during system
> suspend and disable it during system resume.  This way, the stay_on
> flag will only affect system sleep states, while the "always on"
> governor will only affect runtime PM.

Well, it's not that simple, because we need to make the domains that
should stay "on" during system suspend be powered on beforehand.

I'll send an updated patch in a while.

Thanks,
Rafael
