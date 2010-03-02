From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 02 Mar 2010 23:35:48 +0000
Subject: Re: [GIT PULL] genesis updates for 2.6.34-rc1
Message-Id: <20100302233548.GA29715@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20100226071805.GA4435@linux-sh.org>
In-Reply-To: <20100226071805.GA4435@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 26, 2010 at 04:18:05PM +0900, Paul Mundt wrote:
> This is the initial batch of updates adding SH-Mobile G series support
> for the merge window.

I get some additional stuff via this pull, which I think is down to
this:

	serial: sh-sci: remove SCIF code in sci_rxd_in()

>  drivers/Makefile                                  |    1 +
>  drivers/serial/Kconfig                            |    2 +-
>  drivers/serial/sh-sci.h                           |   22 +-
>  drivers/sh/intc.c                                 |   10 +-
>  44 files changed, 11516 insertions(+), 10 deletions(-)

 drivers/Makefile                                  |    1 +
 drivers/serial/Kconfig                            |    2 +-
 drivers/serial/sh-sci.h                           |  242 +---
 drivers/sh/intc.c                                 |   10 +-
 44 files changed, 11517 insertions(+), 229 deletions(-)

Please check my devel-stable branch when I push my tree out (which should
be shortly)
