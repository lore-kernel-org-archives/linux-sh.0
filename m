From: Simon Horman <horms@verge.net.au>
Date: Tue, 01 Dec 2015 06:44:35 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: Enable CONFIG_PRINTK_TIME
Message-Id: <20151201064434.GI16260@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1448890534-1430-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448890534-1430-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 30, 2015 at 02:35:34PM +0100, Geert Uytterhoeven wrote:
> Enable timestamps for kernel log output to improve debugging.
> You can always use "dmesg -t" to strip the timestamps.
> 
> Don't specify CONFIG_LOG_BUF_SHIFT while we're at it.  There's a
> reason the default in Kconfig is higher ;-)
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
