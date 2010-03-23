From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Mar 2010 04:33:15 +0000
Subject: Re: [PATCH] serial: sh-sci: fix SH-Mobile SH breakage
Message-Id: <20100323043315.GE13417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100316112107.25732.49922.sendpatchset@t400s>
In-Reply-To: <20100316112107.25732.49922.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 16, 2010 at 08:21:07PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The follwing commit breaks SH-Mobile on non-ARM platforms:
> "8a77b8d serial: sh-sci: Support ARM-based SH-Mobile CPUs."
> 
> The commit assumed that CONFIG_ARCH_SHMOBILE only was set
> on ARM platforms, but it turns out that this kconfig is also
> set by all SH-based SoCs. Sh7724 and other older SH-Mobile
> SoCs are all broken without this fix.
> 
> This patch converts the "defined(CONFIG_ARCH_SHMOBILE)" into
> one "defined()" per SoC model - similar to existing SH code.
> 
> Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied, thanks.
