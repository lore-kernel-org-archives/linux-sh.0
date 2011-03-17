From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 Mar 2011 08:20:17 +0000
Subject: Re: [PATCH 9/10] sh: Use struct syscore_ops instead of sysdev class and sysdev
Message-Id: <20110317082016.GB13315@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201103100131.58206.rjw@sisk.pl> <201103122212.40828.rjw@sisk.pl> <201103131402.48129.rjw@sisk.pl> <201103131403.49561.rwys@fuw.edu.pl>
In-Reply-To: <201103131403.49561.rwys@fuw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Sun, Mar 13, 2011 at 02:03:49PM +0100, R. J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
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

This misses the use of the sysdev class by the userimask code, though I'm
open to suggestions for alternatives.
