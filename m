From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 17 Apr 2012 22:18:43 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: r8a7740: cleanup I2C workaround method
Message-Id: <201204180018.44082.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <87wr5k2clt.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wr5k2clt.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, April 16, 2012, Simon Horman wrote:
> On Fri, Apr 13, 2012 at 02:41:06AM -0700, Kuninori Morimoto wrote:
> > 
> > Current workaround of I2C on r8a7740 used mdelay(),
> > but it were overkill.
> > This patch cleanup workaround delay.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Tested-by: Simon Horman <horms@verge.net.au>

Applied to the r8a7740 branch of the renesas.git tree.

Thanks,
Rafael
