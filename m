From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 May 2013 00:23:59 +0000
Subject: Re: marzen-reference doesn't boot with CONFIG_PREEMPT
Message-Id: <20130515002358.GA5314@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <4961084.Cgj9yMUAgI@avalon>
In-Reply-To: <4961084.Cgj9yMUAgI@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 14, 2013 at 09:08:07PM +0200, Laurent Pinchart wrote:
> But marzen does (renesas-next-20130513). Is that a known issue ?

No, I was not aware of that.

I would suspect, based on work on the kzm9g, that the problem
relates to driver initialisation order. In the case of kzm9g
my recollection is that the problem was resolved by initialising
clocksources earlier by changing their initcall level.
