From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 24 Feb 2008 21:50:34 +0000
Subject: Re: [PATCH] maple: fix device detection
Message-Id: <1203889834.6474.35.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1203863423.6474.27.camel@localhost.localdomain>
In-Reply-To: <1203863423.6474.27.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>


On Sun, 2008-02-24 at 14:30 +0000, Adrian McMenamin wrote:
> The maple bus driver that went into the kernel mainline in September 2007 contained some bugs which were revealed by the update of the kobj code for the current release series. Unfortunately those bugs also helped ensure maple devices were properly detected. This patch (against the current git) now ensures that devices are properly detected again.
> 

Further testing has shown this has introduced another bug, this time
limiting the effectiveness of subdevice detection. Please ignore this
while I work on a fix.

