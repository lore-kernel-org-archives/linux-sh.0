From: Simon Horman <horms@verge.net.au>
Date: Mon, 20 Jan 2014 00:32:44 +0000
Subject: Re: [PATCH 1/1] ARM: shmobile: Koelsch: pass Ether PHY IRQ
Message-Id: <20140120003241.GG9752@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201312200226.38815.sergei.shtylyov@cogentembedded.com>
 <201312200228.00555.sergei.shtylyov@cogentembedded.com>
 <CANqRtoT1bN4jYHA2+DYRzsVjXXMXRdR_9mqx3sUUXDhJAxe5Ow@mail.gmail.com>
In-Reply-To: <CANqRtoT1bN4jYHA2+DYRzsVjXXMXRdR_9mqx3sUUXDhJAxe5Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 17, 2014 at 03:02:20PM +0900, Magnus Damm wrote:
> On Fri, Dec 20, 2013 at 8:28 AM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > Pass Ether's PHY IRQ (which is IRQC's IRQ0) to the 'sh_eth' driver. Set the IRQ
> > trigger type to be low-level as per the Micrel PHY driver's setup.
> >
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >
> > ---
> >  arch/arm/mach-shmobile/board-koelsch.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Thanks for this. The code looks good to me. I have now tested this on
> my Koelsch board using ifconfig up/down and checking /proc/interrupts.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Hi Sergei,

please repost this patch with Magnus's ack once an rc release is
available with the pre-requisites of this patch.

Thanks
