From: Simon Horman <horms@verge.net.au>
Date: Fri, 30 Oct 2015 07:55:35 +0000
Subject: Re: [PATCH] ARM: shmobile: bockw dts: define sdhi0 pins with pull-ups
Message-Id: <20151030075534.GF31252@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1446148654-20551-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1446148654-20551-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 29, 2015 at 08:57:34PM +0100, Geert Uytterhoeven wrote:
> From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> 
> Ensures that the pull-ups for pins SD0_CD and SD0_WP are enabled.
> 
> This is one of two features from the DT reference platform that are
> still missing in MP.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The dependencies are now in pinctrl/for-next:
> ae7465a0972aee88 pinctrl: sh-pfc: r8a7778: Add bias (pull-up) pinconf support
> 22768fc60abbf58b pinctrl: sh-pfc: Add macros defining GP ports with config flags
> 

Am I correct in thinking that it is safe for me to apply this patch
without those dependencies present in my dt-for-v4.5 branch?
