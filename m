From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 19 Apr 2011 21:35:34 +0000
Subject: Re: [linux-pm] [PATCH 7/9] PM / Runtime: Add generic clock manipulation rountines for runtime PM
Message-Id: <201104192335.34560.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201104130205.26988.rjw@sisk.pl> <201104170142.10723.rjw@sisk.pl> <20110419105836.GG9462@sirena.org.uk>
In-Reply-To: <20110419105836.GG9462@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>

On Tuesday, April 19, 2011, Mark Brown wrote:
> On Sun, Apr 17, 2011 at 01:42:10AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Many different platforms and subsystems may want to disable device
> > clocks during suspend and enable them during resume which is going to
> > be done in a very similar way in all those cases.  For this reason,
> > provide generic routines for the manipulation of device clocks during
> > suspend and resume.
> 
> > Convert the ARM shmobile platform to using the new routines.
> 
> I've had similar thoughts with respect to the regulator API - I'd been
> thinking of dealing with this by adding a notifier which subsystems
> could build upon, in much the same way as already exists for the system
> ssuspend and resume events.

Well, I generally avoid using notifiers, because they lead to big functions
that carry out many different tasks.

That said, I think consolidation and reduction of duplicate code is all good,
this way or another. :-)

Thanks,
Rafael
