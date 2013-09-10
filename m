From: Simon Horman <horms@verge.net.au>
Date: Tue, 10 Sep 2013 01:04:39 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: Do not use register_type field of struct sh_eth_plat_data
Message-Id: <20130910010439.GC2865@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1377156998-15421-1-git-send-email-horms+renesas@verge.net.au>
 <20130910002600.GA30656@quad.lixom.net>
In-Reply-To: <20130910002600.GA30656@quad.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Sep 09, 2013 at 05:26:00PM -0700, Olof Johansson wrote:
> On Thu, Aug 22, 2013 at 04:36:38PM +0900, Simon Horman wrote:
> > As of 8d3214c ("sh_eth: remove 'register_type' field from 'struct
> > sh_eth_plat_data'") is is no longer necessary or correct to use the
> > 'register_type' field from 'struct sh_eth_plat_data' and doing so results
> > in a build error.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Applied to fixes.

Thanks, it will be nice to get this out of our collective hair.
