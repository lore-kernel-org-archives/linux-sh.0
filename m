From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 09 May 2011 19:22:09 +0000
Subject: Re: [linux-pm] [PATCH 1/5] PM / Runtime: Support for generic I/O power domains (v3)
Message-Id: <201105092122.09690.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201104290154.12966.rjw@sisk.pl> <201105082322.44268.rjw@sisk.pl> <BANLkTinPGQNUrFnyFVazqA72iyMbB-K_OA@mail.gmail.com>
In-Reply-To: <BANLkTinPGQNUrFnyFVazqA72iyMbB-K_OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Todd Poynor <toddpoynor@google.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Monday, May 09, 2011, Todd Poynor wrote:
> On Sun, May 8, 2011 at 2:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> ...
> 
> > power management (i.e. ->stop_device() may disable a device's
> > clocks, while ->start_device() may enable them, ->power_on() is
> > supposed to remove power from the entire power domain
> > and ->power_off() is supposed to restore it).
> >
> 
> power_off removes power, power_on restores?

Yes, that's the intention.  Thanks for spotting that!

Rafael
