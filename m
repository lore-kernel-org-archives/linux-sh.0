From: Simon Horman <horms@verge.net.au>
Date: Mon, 16 Apr 2012 01:41:07 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: r8a7740: cleanup I2C workaround method
Message-Id: <20120416014106.GA25747@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87wr5k2clt.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wr5k2clt.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 13, 2012 at 02:41:06AM -0700, Kuninori Morimoto wrote:
> 
> Current workaround of I2C on r8a7740 used mdelay(),
> but it were overkill.
> This patch cleanup workaround delay.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>
