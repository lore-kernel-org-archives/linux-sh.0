From: Simon Horman <horms@verge.net.au>
Date: Fri, 13 Dec 2013 00:14:56 +0000
Subject: Re: [PATCH 00/10] sh-pfc: Fix GPIO to IRQ mapping
Message-Id: <20131213001456.GB32101@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131212131139.GE30624@verge.net.au>
 <CACRpkdZnqzAWdnmjo6cNakwOZcLjZ2Mt_LtM1Vf-L9=b_0_p4g@mail.gmail.com>
In-Reply-To: <CACRpkdZnqzAWdnmjo6cNakwOZcLjZ2Mt_LtM1Vf-L9=b_0_p4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 12, 2013 at 10:05:55PM +0100, Linus Walleij wrote:
> On Thu, Dec 12, 2013 at 2:11 PM, Simon Horman <horms@verge.net.au> wrote:
> 
> > It seems to me that if Linus applies the pfc changes the
> > shmobile changes could be applied independently. Am I missing
> > and do the shmobile patches have build-dependencies on the pfc patches?
> 
> I've applied the PFC changes to the pin control tree and will push
> to kernelorg shortly, then allow it to stablilze before you attempt to
> pull that into the SH mobile tree please, and notify me before
> doing so and make sure to just pick the top commit you need.

Thanks, I understand.

I'll re-visit this next week.
