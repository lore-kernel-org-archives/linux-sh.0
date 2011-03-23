From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 23 Mar 2011 09:59:20 +0000
Subject: Re: [PATCH 9/10] sh: Use struct syscore_ops instead of sysdev class and sysdev
Message-Id: <20110323095920.GA6008@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201103100131.58206.rjw@sisk.pl> <201103190147.28001.rjw@sisk.pl> <20110322140420.GA24004@linux-sh.org> <201103222119.28328.rjw@sisk.pl>
In-Reply-To: <201103222119.28328.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Tue, Mar 22, 2011 at 09:19:28PM +0100, Rafael J. Wysocki wrote:
> Convert the SuperH clocks framework and shared interrupt handling
> code to using struct syscore_ops instead of a sysdev classes and
> sysdevs for power managment.
> 
> This reduces the code size significantly and simplifies it.  The
> optimizations causing things not to be restored after creating a
> hibernation image are removed, but they might lead to undesirable
> effects during resume from hibernation (e.g. the clocks would be left
> as the boot kernel set them, which might be not the same way as the
> hibernated kernel had seen them before the hibernation).
> 
> This also is necessary for removing sysdevs from the kernel entirely
> in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/sh/clk/core.c       |   68 ++++++++-----------------------
>  drivers/sh/intc/core.c      |   95 +++++++++++++++++++++-----------------------
>  drivers/sh/intc/internals.h |    1 
>  3 files changed, 65 insertions(+), 99 deletions(-)
> 
This one looks good, and seems to work fine. Applied, thanks.
