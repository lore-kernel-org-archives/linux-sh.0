From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Apr 2011 10:18:10 +0000
Subject: Re: [Update][PATCH 7/9] PM / Runtime: Add generic clock manipulation
Message-Id: <BANLkTimZpXAH7uGTDmYJSJJWgX=H5md0JQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201104130205.26988.rjw@sisk.pl>
	<201104170135.19388.rjw@sisk.pl>
	<201104170142.10723.rjw@sisk.pl>
	<201104182159.54316.rjw@sisk.pl>
In-Reply-To: <201104182159.54316.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Kevin Hilman <khilman@ti.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Len Brown <lenb@kernel.org>, linux-sh@vger.kernel.org, lethal@linux-sh.org, Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@suse.de>

Hi Rafael,

On Tue, Apr 19, 2011 at 4:59 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Many different platforms and subsystems may want to disable device
> clocks during suspend and enable them during resume which is going to
> be done in a very similar way in all those cases. =A0For this reason,
> provide generic routines for the manipulation of device clocks during
> suspend and resume.
>
> Convert the ARM shmobile platform to using the new routines.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>
> Hi,
>
> The previous version of the patch had a build problem for CONFIG_HAVE_CLK
> unset and a the name of pm_runtime_clock_add_notifier() misspelled (a
> couple of times).

Thanks for your work on this. I like that we get closer to a shared code ba=
se.

Do you have any plans to add support for multiple clocks per struct
device? I had some plans to play around with that myself, but if we're
moving the code to a common place then this obviously becomes a bit
more complicated.

It's rather common that each hardware block in an SoC is connected to
more than a single clock. This needs to be managed by software
somehow.

So if the plan is to make to the code generic, how about allowing the
architecture to associate clocks with each struct device somehow?

Thanks,

/ magnus
