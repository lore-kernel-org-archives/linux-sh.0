From: Olof Johansson <olof@lixom.net>
Date: Wed, 28 Aug 2013 18:24:17 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: Do not use register_type field of struct sh_eth_plat_data
Message-Id: <20130828182417.GF8607@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1377156998-15421-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1377156998-15421-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 22, 2013 at 04:36:38PM +0900, Simon Horman wrote:
> As of 8d3214c ("sh_eth: remove 'register_type' field from 'struct
> sh_eth_plat_data'") is is no longer necessary or correct to use the
> 'register_type' field from 'struct sh_eth_plat_data' and doing so results
> in a build error.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> Olof,
> 
> as discussed, please apply this to for-next and merge it upstream
> after the patch mentioned above lands upstream via net-next.
> ---

Thanks, applied. Please help me remember to send this upstream if I forget. :)


-Olof

