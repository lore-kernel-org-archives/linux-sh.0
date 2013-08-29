From: Simon Horman <horms@verge.net.au>
Date: Thu, 29 Aug 2013 00:08:33 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: Do not use register_type field of struct sh_eth_plat_data
Message-Id: <20130829000833.GC10207@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1377156998-15421-1-git-send-email-horms+renesas@verge.net.au>
 <20130828182417.GF8607@quad.lixom.net>
In-Reply-To: <20130828182417.GF8607@quad.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 28, 2013 at 11:24:17AM -0700, Olof Johansson wrote:
> On Thu, Aug 22, 2013 at 04:36:38PM +0900, Simon Horman wrote:
> > As of 8d3214c ("sh_eth: remove 'register_type' field from 'struct
> > sh_eth_plat_data'") is is no longer necessary or correct to use the
> > 'register_type' field from 'struct sh_eth_plat_data' and doing so results
> > in a build error.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > ---
> > 
> > Olof,
> > 
> > as discussed, please apply this to for-next and merge it upstream
> > after the patch mentioned above lands upstream via net-next.
> > ---
> 
> Thanks, applied. Please help me remember to send this upstream if I forget. :)

Of course, I'll keep track of this.
