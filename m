From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 13 Mar 2012 01:44:09 +0000
Subject: Re: [PATCH 0/6] PM / Domains: System suspend fixes and "always on" flag
Message-Id: <20120313014408.GA9916@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201203130123.16268.rjw@sisk.pl>
In-Reply-To: <201203130123.16268.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Cao Minh Hiep <hiepcm@gmail.com>

On Tue, Mar 13, 2012 at 01:23:15AM +0100, Rafael J. Wysocki wrote:
> The following patches fix system suspend/resume and hibernation device
> callback routines in the generic PM domains code and add an "always on" flag
> for devices allowing their drivers to protect them from surprise power
> removals.
> 
> [1/6] - Fix system resume of devices involved in system wakeup.
> [2/6] - Fix hibernation restore of devices.
> [3/6] - Introduce "always on" flag for "special" devices in PM domains.
> [4/6] - Make TMU clocksource driver use the "always on" flag.
> [5/6] - Make CMT clocksource driver use the "always on" flag.
> [6/6] - Make MTU2 clocksource driver use the "always on" flag.
> 
> All of them are v3.4 material if there are no objections.
> 
Looks good to me.

Acked-by: Paul Mundt <lethal@linux-sh.org>
