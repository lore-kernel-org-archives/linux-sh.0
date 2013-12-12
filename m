From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Dec 2013 21:05:55 +0000
Subject: Re: [PATCH 00/10] sh-pfc: Fix GPIO to IRQ mapping
Message-Id: <CACRpkdZnqzAWdnmjo6cNakwOZcLjZ2Mt_LtM1Vf-L9=b_0_p4g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386732390-31724-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131212131139.GE30624@verge.net.au>
In-Reply-To: <20131212131139.GE30624@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 12, 2013 at 2:11 PM, Simon Horman <horms@verge.net.au> wrote:

> It seems to me that if Linus applies the pfc changes the
> shmobile changes could be applied independently. Am I missing
> and do the shmobile patches have build-dependencies on the pfc patches?

I've applied the PFC changes to the pin control tree and will push
to kernelorg shortly, then allow it to stablilze before you attempt to
pull that into the SH mobile tree please, and notify me before
doing so and make sure to just pick the top commit you need.

Yours,
Linus Walleij
