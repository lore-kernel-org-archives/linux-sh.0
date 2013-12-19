From: Simon Horman <horms@verge.net.au>
Date: Thu, 19 Dec 2013 06:40:52 +0000
Subject: Re: [PATCH 00/10] sh-pfc: Fix GPIO to IRQ mapping
Message-Id: <20131219064052.GE10230@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131212131139.GE30624@verge.net.au>
 <CACRpkdZnqzAWdnmjo6cNakwOZcLjZ2Mt_LtM1Vf-L9=b_0_p4g@mail.gmail.com>
 <20131213001456.GB32101@verge.net.au>
In-Reply-To: <20131213001456.GB32101@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 13, 2013 at 09:14:56AM +0900, Simon Horman wrote:
> On Thu, Dec 12, 2013 at 10:05:55PM +0100, Linus Walleij wrote:
> > On Thu, Dec 12, 2013 at 2:11 PM, Simon Horman <horms@verge.net.au> wrote:
> > 
> > > It seems to me that if Linus applies the pfc changes the
> > > shmobile changes could be applied independently. Am I missing
> > > and do the shmobile patches have build-dependencies on the pfc patches?
> > 
> > I've applied the PFC changes to the pin control tree and will push
> > to kernelorg shortly, then allow it to stablilze before you attempt to
> > pull that into the SH mobile tree please, and notify me before
> > doing so and make sure to just pick the top commit you need.
> 
> Thanks, I understand.
> 
> I'll re-visit this next week.

Hi Linus,

just to let you know I am planning to use
70c8f01a357ac74d ("sh-pfc: Support GPIO to IRQ mapping specified IRQ resources")
