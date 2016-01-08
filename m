From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 08 Jan 2016 05:09:04 +0000
Subject: Re: [PATCH 1b/1] serial: sh-sci: Remove cpufreq notifier to fix crash/deadlock
Message-Id: <20160108050904.GH30293@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452018997-14103-1-git-send-email-geert+renesas@glider.be>
 <1452018997-14103-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1452018997-14103-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jiri Slaby <jslaby@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Michael Turquette <mturquette@baylibre.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 05, 2016 at 07:36:37PM +0100, Geert Uytterhoeven wrote:
> The BSP team noticed that there is spin/mutex lock issue on sh-sci when
> CPUFREQ is used.  The issue is that the notifier function may call
> mutex_lock() while the spinlock is held, which can lead to a BUG().
> This may happen if CPUFREQ is changed while another CPU calls
> clk_get_rate().
> 
> Taking the spinlock was added to the notifier function in commit
> e552de2413edad1a ("sh-sci: add platform device private data"), to
> protect the list of serial ports against modification during traversal.
> At that time the Common Clock Framework didn't exist yet, and
> clk_get_rate() just returned clk->rate without taking a mutex.
> Note that since commit d535a2305facf9b4 ("serial: sh-sci: Require a
> device per port mapping."), there's no longer a list of serial ports to
> traverse, and taking the spinlock became superfluous.
> 
> To fix the issue, just remove the cpufreq notifier:
>   1. The notifier doesn't work correctly: all it does is update stored
>      clock rates; it does not update the divider in the hardware.
>      The divider will only be updated when calling sci_set_termios().
>      I believe this was broken back in 2004, when the old
>      drivers/char/sh-sci.c driver (where the notifier did update the
>      divider) was replaced by drivers/serial/sh-sci.c (where the
>      notifier just updated port->uartclk).
>      Cfr. full-history-linux commits 6f8deaef2e9675d9 ("[PATCH] sh: port
>      sh-sci driver to the new API") and 3f73fe878dc9210a ("[PATCH]
>      Remove old sh-sci driver").
>   2. On modern SoCs, the sh-sci parent clock rate is no longer related
>      to the CPU clock rate anyway, so using a cpufreq notifier is
>      futile.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This version applies against scif-clk-sck-brg-for-v4.5.

I took this version.  If the 1a needs to go to 4.4-stable, email it, and
the git commit id to stable@vger.kernel.org when this ends up in Linus's
tree.

thanks,

greg k-h
