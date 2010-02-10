From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 10 Feb 2010 03:50:15 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: driver kconfig update
Message-Id: <20100210035015.GB21624@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100209095621.1458.15191.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100209095621.1458.15191.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 09, 2010 at 06:56:21PM +0900, Magnus Damm wrote:
> This patch updates the Kconfig entries for various
> SuperH drivers to enable use on SH-Mobile G-series.
> 
Why? If you have a user for one of these, then send the Kconfig-enabling
part along with that patch, otherwise this is just introducing merge
conflicts for no reason whatsoever.

> While at it, add a HAVE_CLK dependency for drivers
> that use the clock framework.
> 
HAVE_CLK is really only useful for drivers that are generically exposed.
For ones that are restricted to SUPERH || ARCH_SHMOBILE it doesn't really
make any sense, since the clock framework will always be there anyways.
