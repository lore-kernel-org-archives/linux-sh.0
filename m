From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 11 Feb 2008 16:25:20 +0000
Subject: Re: [PATCH 1/2] SH/Dreamcast - joystick (Control pad)
Message-Id: <20080211112433.ZZRA012@mailhub.coreip.homeip.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1202684222.6237.9.camel@localhost.localdomain> <200802101922.29214.vapier@gentoo.org> <15561.85.118.17.158.1202739603.squirrel@newgolddream.dyndns.info> <200802111119.23841.vapier@gentoo.org>
In-Reply-To: <200802111119.23841.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>, Paul Mundt <lethal@users.sourceforge.net>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Feb 11, 2008 at 11:19:22AM -0500, Mike Frysinger wrote:
> On Monday 11 February 2008, Adrian McMenamin wrote:
> > On Mon, February 11, 2008 12:22 am, Mike Frysinger wrote:
> > > no remove function ?  looks like the probe() forces a connect, but
> > > there's no remove() to force a disconnect ...
> >
> > Removing these devices (or any other plugged directly into the maple
> > ports) is a quick way to destroy your Dreamcast: hence they were never
> > implemented I guess. But there is no convincing reason for the software
> > not doing so, I suppose. I can just put in comments about it.
> 
> and not allow the driver to be built as a module until the comments become 
> code ...
> -mike

Normally drivers can be unbound from devices via sysfs even if they are
built-in, not modules.


-- 
Dmitry
