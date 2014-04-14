From: Simon Horman <horms@verge.net.au>
Date: Mon, 14 Apr 2014 01:59:10 +0000
Subject: Re: [PATCH v2 repost 1/2] ARM: shmobile: r8a7779: Use clks as MSTP007 parent
Message-Id: <20140414015910.GD22411@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1397439698-30123-1-git-send-email-horms+renesas@verge.net.au>
 <1397439698-30123-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1397439698-30123-3-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

On Mon, Apr 14, 2014 at 10:41:37AM +0900, Simon Horman wrote:
> According to the documentation the parent clock of
> MSTP007 should be clks not clkp.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Sorry for the mess, please ignore this patch, it is a repost of
a version with an incorrect changelog.
