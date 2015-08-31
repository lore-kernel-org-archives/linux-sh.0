From: Simon Horman <horms@verge.net.au>
Date: Mon, 31 Aug 2015 06:40:04 +0000
Subject: Re: [PATCH] drivers: sh: Get rid of CONFIG_ARCH_SHMOBILE_MULTI
Message-Id: <20150831064004.GB4181@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440706012-3334-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440706012-3334-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2015 at 10:06:52PM +0200, Geert Uytterhoeven wrote:
> Shmobile is all multiplatform these days, so get rid of the reference to
> CONFIG_ARCH_SHMOBILE_MULTI.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This must not be applied to a branch that still has
> CONFIG_ARCH_SHMOBILE_LEGACY.
> 
>  drivers/sh/pm_runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, I have queued this up for v4.4.
