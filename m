From: Simon Horman <horms@verge.net.au>
Date: Sat, 20 Apr 2013 08:28:19 +0000
Subject: Re: r8a7779_init_irq_extpin
Message-Id: <20130420082816.GA21761@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130417063526.GA21490@verge.net.au>
In-Reply-To: <20130417063526.GA21490@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 19, 2013 at 04:11:34AM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Thu, Apr 18, 2013 at 9:22 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Apr 18, 2013 at 02:23:57PM +0900, Magnus Damm wrote:
> >> Hi Simon,
> >>
> >> On Wed, Apr 17, 2013 at 3:35 PM, Simon Horman <horms@verge.net.au> wrote:
> >> > Hi Magnus,
> >> >
> >> > r8a7779_init_irq_extpin() and related code was added in your
> >> > patch "ARM: shmobile: Use Renesas INTC External IRQ pin driver"
> >> > but appears to be unused.
> >> >
> >> > Are you still planning to use it?
> >>
> >> Perhaps I'm misunderstanding, but isn't it used by the Marzen board code in:
> >> [PATCH 03/03] ARM: shmobile: INTC External IRQ pin driver on r8a7779
> >
> > Thanks. Some how I that portion got lost and isn't present
> > in the tree. I'll post a patch with the missing portions shortly.
> 
> Ok, thanks for dealing with this!

One more question, is the code in r8a7779_init_irq_extpin()
before the call to platform_device_register() needed if
irqpin is registered using DT? IF so, perhaps it needs to
go into the driver? With a binding?
