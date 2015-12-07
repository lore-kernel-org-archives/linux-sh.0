From: Simon Horman <horms@verge.net.au>
Date: Mon, 07 Dec 2015 06:24:16 +0000
Subject: Re: [PATCH] dmaengine: sh: Remove unused R-Car HPB-DMAC driver
Message-Id: <20151207062415.GE22834@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449244589-22576-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449244589-22576-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 04, 2015 at 04:56:29PM +0100, Geert Uytterhoeven wrote:
> As of commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
> setup code"), the Renesas R-Car HPB-DMAC driver is no longer used.
> In theory it could still be used on R-Car Gen1 SoCs, but that requires
> adding DT support to the driver, which is not planned.
> 
> Remove the driver, it can be resurrected from git history when needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

