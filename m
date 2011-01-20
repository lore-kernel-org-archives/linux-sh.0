From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 Jan 2011 12:32:57 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0 CPGA fix for PLL CFG bit
Message-Id: <20110120123257.GC13114@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101222061405.25163.82564.sendpatchset@t400s>
In-Reply-To: <20101222061405.25163.82564.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 20, 2011 at 05:11:11PM +0900, Magnus Damm wrote:
> PLL1 and PLL2 in the sh73a0 CPGA has a CFG bit that
> must be taken into account to correctly calculate the
> frequency.

On Thu, Jan 20, 2011 at 05:41:03PM +0900, Magnus Damm wrote:
> Add platform data for MIPI-DSI and LCDC on the AG5EVM
> board. The sh73a0 clkdev bindings are also updated.

Applied, thanks.
