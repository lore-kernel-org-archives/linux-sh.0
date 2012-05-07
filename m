From: Simon Horman <horms@verge.net.au>
Date: Mon, 07 May 2012 05:20:40 +0000
Subject: Re: [PATCH] clocksource: em_sti: Emma Mobile STI driver
Message-Id: <20120507052028.GA26593@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20120503125611.4314.52231.sendpatchset@w520>
In-Reply-To: <20120503125611.4314.52231.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-sh@vger.kernel.org, johnstul@us.ibm.com, rjw@sisk.pl, lethal@linux-sh.org, gregkh@linuxfoundation.org, olof@lixom.net, tglx@linutronix.de

On Thu, May 03, 2012 at 09:56:11PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This is V1 of the Emma Mobile STI timer driver.
> 
> The STI hardware is based on a single 48-bit 32kHz
> counter that together with two individual compare
> registers can generate interrupts. There are no
> timer operating modes selectable which means that
> the timer can not clear on match.
> 
> This driver is providing clocksource support for the
> 48-bit counter. Clockevents are also supported using
> the same timer in periodic or oneshot modes.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Tested-by: Simon Horman <horms@verge.net.au>
