From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Sep 2013 05:19:29 +0000
Subject: Re: [PATCH] ARM: shmobile: Break out R-Car Gen2 setup code
Message-Id: <20130925051928.GH24243@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130912003249.24015.41583.sendpatchset@w520>
 <20130912004730.GG23279@verge.net.au>
 <20130912005504.GH23279@verge.net.au>
In-Reply-To: <20130912005504.GH23279@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 12, 2013 at 09:55:06AM +0900, Simon Horman wrote:
> On Thu, Sep 12, 2013 at 09:47:32AM +0900, Simon Horman wrote:
> > On Thu, Sep 12, 2013 at 09:32:49AM +0900, Magnus Damm wrote:
> > > From: Magnus Damm <damm@opensource.se>
> > > 
> > > Move arch timer workaround code and boot mode pin
> > > handling from setup-r8a7790.c to setup-rcar-gen2.c.
> > > 
> > > With this in place the same code can be used on
> > > other R-Car Generation 2 devices such as r8a7791.
> > 
> > This seems reasonable to me.
> > 
> > Am I correct in thinking that you plan a follow-up patch to make use of
> > this on the r8a7771 in the not to distant future.
> 
> I see my reply was too hasty and you have sent such a patch.
> Sorry for the noise!

I have queued up the following as a cleanup and
I plan to push it later this afternoon.

There were some minor conflicts in arch/arm/mach-shmobile/Makefile
and arch/arm/mach-shmobile/include/mach/r8a7790.h.
Please let me know if I messed things up.
