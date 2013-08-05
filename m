From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Aug 2013 07:47:15 +0000
Subject: Re: [PATCH 0/4] ARM: shmobile: ape6evm: support GPIO switches and LEDs
Message-Id: <20130805074715.GA13274@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
 <20130801080132.GA2157@verge.net.au>
In-Reply-To: <20130801080132.GA2157@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 01, 2013 at 05:01:32PM +0900, Simon Horman wrote:
> On Tue, Jul 30, 2013 at 10:58:59AM +0900, Simon Horman wrote:
> > This short series adds support for GPIO swtiches and LEDS to
> > the ape6evm board.
> > 
> > Applies on top of renesas-devel-20130726.
> > 
> > Simon Horman (4):
> >   ARM: shmobile: ape6evm: support GPIO switches
> >   ARM: shmobile: ape6evm: Enable gpio-keys in defconfig
> >   ARM: shmobile: ape6evm: Add GPIO LEDs
> >   ARM: shmobile: ape6evm: Enable gpio-leds in defconfig
> > 
> >  arch/arm/configs/ape6evm_defconfig     |  6 +++-
> >  arch/arm/mach-shmobile/board-ape6evm.c | 60 ++++++++++++++++++++++++++++++++++
> 
> Hi Magnus, Hi All,
> 
> could I get a review of this, and if appropriate an Ack.

Ping.
