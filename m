From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Mar 2014 00:25:23 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: koelsch-reference: Work around core clock issues
Message-Id: <20140318002523.GA19571@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 13, 2014 at 03:29:30PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Due to issues with runtime PM clock management, clocks not explicitly
> managed by their drivers may not be enabled at all, or be inadvertently
> disabled by the clk_disable_unused() late initcall.
> 
> Until this is fixed, add a temporary workaround, calling
> shmobile_clk_workaround() with enable = true.
> 
> For now this enables the clocks for: ether, i2c2, msiof0, qspi_mod, and
> thermal. More clocks can be added if needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Thanks, I have queued this up.
