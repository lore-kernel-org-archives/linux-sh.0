From: Simon Horman <horms@verge.net.au>
Date: Mon, 07 May 2012 04:10:24 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-r8a7740: use followparent_recalc on usb24s
Message-Id: <20120507041012.GJ1866@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201204252313.23899.rjw@sisk.pl>
In-Reply-To: <201204252313.23899.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, May 06, 2012 at 06:12:41PM -0700, Kuninori Morimoto wrote:
> If the clocks is always same value as the parent clock,
> we can use followparent_recalc() for .recalc
> 
> Reported-by: Paul Mundt <lethal@linux-sh.org>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Simon Horman <horms@verge.net.au>
