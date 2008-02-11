From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 11 Feb 2008 15:58:26 +0000
Subject: Re: [PATCH 1/2] SH/Dreamcast - joystick (Control pad)
Message-Id: <20080211105506.ZZRA012@mailhub.coreip.homeip.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1202684222.6237.9.camel@localhost.localdomain> <200802101922.29214.vapier@gentoo.org> <15561.85.118.17.158.1202739603.squirrel@newgolddream.dyndns.info>
In-Reply-To: <15561.85.118.17.158.1202739603.squirrel@newgolddream.dyndns.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Mike Frysinger <vapier@gentoo.org>, Paul Mundt <lethal@users.sourceforge.net>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Adrian,

On Mon, Feb 11, 2008 at 02:20:03PM +0000, Adrian McMenamin wrote:
> On Mon, February 11, 2008 12:22 am, Mike Frysinger wrote:
> >
> > no remove function ?  looks like the probe() forces a connect, but there's
> > no
> > remove() to force a disconnect ...
> 
> 
> Removing these devices (or any other plugged directly into the maple
> ports) is a quick way to destroy your Dreamcast: hence they were never
> implemented I guess. But there is no convincing reason for the software
> not doing so, I suppose. I can just put in comments about it.

But what will happen if the driver gets unloaded by user?

-- 
Dmitry
