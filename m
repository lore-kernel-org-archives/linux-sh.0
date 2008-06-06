From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 06 Jun 2008 05:52:50 +0000
Subject: Re: resume woes on jornada (2.6.25)
Message-Id: <20080606055250.GF29591@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080604004112.7cd033d6.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080604004112.7cd033d6.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 04, 2008 at 12:41:12AM +0200, Kristoffer Ericson wrote:
> I've gone through the arch/sh/boards/hp6xx/pm.c & pm_wakeup code and
> both seem fine. Nothing changed and everything is resonable.
> 
> What Im uncertain of is the arch/sh/kernel/pm.c code. It hasn't changed
> any since v2.6.17 (which had working suspend) but it feels like the
> most resonable solution. It does some fly stuff trying to add itself as
> handle for the power button (0x600?).
> 
No one has been touching that code or doing much testing on SH-3, so if
you want to figure out what went wrong, I'm afraid you're going to have
to bisect it. This is also why it tends to be helpful to test your
platform more than once a year, especially since no one else has the
hardware. :-)
