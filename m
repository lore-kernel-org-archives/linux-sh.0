From: "Adrian McMenamin" <adrian@newgolddream.dyndns.info>
Date: Mon, 11 Feb 2008 14:20:03 +0000
Subject: Re: [PATCH 1/2] SH/Dreamcast - joystick (Control pad)
Message-Id: <15561.85.118.17.158.1202739603.squirrel@newgolddream.dyndns.info>
List-Id: <linux-sh.vger.kernel.org>
References: <1202684222.6237.9.camel@localhost.localdomain>
    <200802101922.29214.vapier@gentoo.org>
In-Reply-To: <200802101922.29214.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: dtor@insightbb.com, Paul Mundt <lethal@users.sourceforge.net>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, February 11, 2008 12:22 am, Mike Frysinger wrote:
>
> no remove function ?  looks like the probe() forces a connect, but there's
> no
> remove() to force a disconnect ...


Removing these devices (or any other plugged directly into the maple
ports) is a quick way to destroy your Dreamcast: hence they were never
implemented I guess. But there is no convincing reason for the software
not doing so, I suppose. I can just put in comments about it.

