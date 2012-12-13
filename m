From: Simon Horman <horms@verge.net.au>
Date: Thu, 13 Dec 2012 01:29:23 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: add TMU timer support
Message-Id: <20121213012921.GX13343@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <871uevinw9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871uevinw9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 12, 2012 at 02:08:09AM -0800, Kuninori Morimoto wrote:
> This patch enabled TMU0 timer on r8a7740.
> But TMU1 timer is not supported yet
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks applied.

I have applied this to a temporary 'soc5' branch which is based on 3.7-rc1.
I will rebase this on 3.8-rc1 once it is released and rename the branch
to the more sane 'soc'.

I have also merged this change into the next branch.
