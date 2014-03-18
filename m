From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 18 Mar 2014 13:59:25 +0000
Subject: Re: [PATCH] ARM: shmobile: Add Lager clock workarounds for SDHI and MMCIF
Message-Id: <8613951.tOalqxZBdW@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20140318125247.21670.94176.sendpatchset@w520>
In-Reply-To: <20140318125247.21670.94176.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Tuesday 18 March 2014 14:48:36 Ben Dooks wrote:
> On 18/03/14 14:25, Laurent Pinchart wrote:
> > On Tuesday 18 March 2014 21:52:47 Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >> 
> >> Add MMCIF1, SDHI0 and SDHI2 to the clock workaround list for
> >> Lager multiplatform. Without these additional lines wakeup
> >> from Suspend-to-RAM never happens.
> > 
> > What about fixing the root cause instead of piling up hacks ?
> 
> See RFC to move the drivers/sh/pm_runtime.c out of drivers/sh.

I wasn't sure whether the problem that this patch tries to work around was 
related to runtime PM as it wasn't mentioned in the commit message.

> I need to address the issue that the code does not actually allow any
> devices to PM.

I've replied to your RFC and have studied the issue further since then.

First of all, I think we should get Rafael Wysocki and Felipe Balbi in the 
loop, as Rafael is probably the reference person for runtime PM, and Felipe 
has submitted an alternative proposal to manage device clocks automatically.

Then, just copying the drivers/sh/pm-runtime.c over to drivers/base/ doesn't 
seem to be a good idea to me. Core infrastructure code in drivers/base/ needs 
to be properly documented, and thus properly understood. I feel like we're 
rushing thing, taking code that seem to work but that isn't really understood, 
and turning it into core code.

I think we should take a step back here, understand exactly what we're doing, 
and write documentation.

-- 
Regards,

Laurent Pinchart

