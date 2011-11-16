From: Greg KH <gregkh@suse.de>
Date: Wed, 16 Nov 2011 23:52:27 +0000
Subject: Re: [PATCH] PM Sleep: Don't extend wakeup paths to devices with
Message-Id: <20111116235227.GB14252@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201111162321.58572.rjw@sisk.pl>
In-Reply-To: <201111162321.58572.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Wed, Nov 16, 2011 at 11:21:58PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Commit 4ca46ff3e0d8c234cb40ebb6457653b59584426c (PM / Sleep: Mark
> devices involved in wakeup signaling during suspend) introduced
> the power.wakeup_path field in struct dev_pm_info to mark devices
> whose children are enabled to wake up the system from sleep states,
> so that power domains containing the parents that provide their
> children with wakeup power and/or relay their wakeup signals are not
> turned off.  Unfortunately, that introduced a PM regression on SH7372
> whose power consumption in the system "memory sleep" state increased
> as a result of it, because it prevented the power domain containing
> the I2C controller from being turned off when some children of that
> controller were enabled to wake up the system, although the
> controller was not necessary for them to signal wakeup.
> 
> To fix this issue use the observation that devices whose
> power.ignore_children flag is set for runtime PM should be treated
> analogously during system suspend.  Namely, they shouldn't be
> included in wakeup paths going through their children.  Since the
> SH7372 I2C controller's power.ignore_children flag is set, doing so
> will restore the previous behavior of that SOC.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

