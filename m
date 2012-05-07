From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 07 May 2012 18:59:09 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-r8a7740: add sh-eth clock
Message-Id: <201205072101.44656.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201204252313.23899.rjw@sisk.pl>
In-Reply-To: <201204252313.23899.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, May 07, 2012, Simon Horman wrote:
> On Sun, May 06, 2012 at 10:58:41PM -0700, Kuninori Morimoto wrote:
> > armadillo800eva board is using sh-eth, but clock-r8a7740 didn't care it.
> > This clock was enabled by boot-loader.
> > This patch fix it up.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Reviewed-by: Simon Horman <horms@verge.net.au>

Applied to the armadillo800eva branch of the renesas.git tree.

Thanks,
Rafael
