From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Nov 2015 03:12:34 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7794: alt: Enable PFC DU for the VGA port
Message-Id: <20151124031234.GM21853@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20151117032759.27590.11692.sendpatchset@little-apple>
In-Reply-To: <20151117032759.27590.11692.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 17, 2015 at 12:27:59PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Tie in r8a7794 PFC DU support to the VGA port on the
> r8a7794 ALT board.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Written on top of "renesas-devel-20151113-v4.3" with
>  "[PATCH v2 00/03] ARM: shmobile: r8a7794 ALT board DU VGA port enablement V2"
> 
>  No other build time dependencies.
> 
>  Run time dependency exists on
>  "[PATCH 00/04] pinctrl: sh-pfc: r8a7794: DU support"

I have marked this patch as deferred pending acceptance of that series.
Please repost or otherwise ping me once that has happened.

