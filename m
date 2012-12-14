From: Simon Horman <horms@verge.net.au>
Date: Fri, 14 Dec 2012 00:57:08 +0000
Subject: Re: [PATCH] ARM: shmobile: sh73a0: fixup div4_clks bitmap
Message-Id: <20121214005706.GF29354@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehj5nuip.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehj5nuip.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 04, 2012 at 05:43:29PM -0800, Kuninori Morimoto wrote:
> div4_clks's bitmap of sh73a0 was wrong.
> This patch is based on v2.0 datasheet.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks applied.

I have applied this to a temporary 'soc5' branch which is based on 3.7-rc1.
I will rebase this on 3.8-rc1 once it is released and rename the branch
to the more sane 'soc'.

I have also merged this change into the next branch.
