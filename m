From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Aug 2013 08:56:12 +0000
Subject: Re: [PATCH 2/4] ARM: shmobile: r8a7790: add missing __initdata
Message-Id: <20130805085611.GF13274@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87txj898qu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txj898qu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 01, 2013 at 06:33:48PM -0700, Kuninori Morimoto wrote:
> This patch adds missing __initdata to driver data/resource
> which are used from platform_device_register_xxx()
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I will queue this up for v3.12 in the cleanup3 branch.
