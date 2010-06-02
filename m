From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 02 Jun 2010 08:23:03 +0000
Subject: Re: [PATCH v2] sh_tmu: compute mult and shift before registration
Message-Id: <20100602082303.GB19079@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1275342348-22499-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 31, 2010 at 11:45:48PM +0200, Aurelien Jarno wrote:
> Since commit 98962465ed9e6ea99c38e0af63fe1dcb5a79dc25 ("nohz: Prevent
> clocksource wrapping during idle"), the CPU of an R2D board never goes
> to idle. This commit assumes that mult and shift are assigned before
> the clocksource is registered. As a consequence the safe maximum sleep
> time is negative and the CPU never goes into idle.
> 
> This patch fixes the problem by moving mult and shift initialization
> from sh_tmu_clocksource_enable() to sh_tmu_register_clocksource().
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Applied, thanks.

I've made a similar change for the sh_cmt driver, too.

Both of these should show up in the next 2.6.34-stable release.
