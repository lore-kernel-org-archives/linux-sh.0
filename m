From: Simon Horman <horms@verge.net.au>
Date: Thu, 12 Dec 2013 12:53:38 +0000
Subject: Re: [PATCH] ARM: shmobile: remove unnecessary platform_device as header cleanup
Message-Id: <20131212125336.GB30624@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87hajocc4i.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hajocc4i.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 09, 2013 at 06:34:45PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> 8e0e7aaef3c98c52e85f5640b73ffa82058abcfd
> (ARM: shmobile: Drop r8a7779_add_device_to_domain())
> removed last user of struct platform_device on this header.
> It is no longer needed
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 --
>  1 file changed, 2 deletions(-)

Thanks, I will queue this up.
