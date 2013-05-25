From: Simon Horman <horms@verge.net.au>
Date: Sat, 25 May 2013 00:10:21 +0000
Subject: Re: [PATCH v2] gpio-rcar: Add support for IRQ_TYPE_EDGE_BOTH
Message-Id: <20130525001020.GC32093@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130524094724.1510.80331.sendpatchset@w520>
In-Reply-To: <20130524094724.1510.80331.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, May 24, 2013 at 06:47:24PM +0900, Magnus Damm wrote:
> From: Simon Horman <horms+renesas@verge.net.au>
> 
> As hardware support for this feature is not universal for all SoCs a flag,
> has_both_edge_trigger, has been added to the platform data of the driver to
> allow this feature to be enabled.
> 
> The motivation for this is to allow use of the gpio-keys driver on the
> lager board which is based on the r8a7790 SoC. The V2 of this patch has been
> fully exercised using that driver on that board.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up for v3.11 in the gpio-rcar branch.
