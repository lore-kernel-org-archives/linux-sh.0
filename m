From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 26 May 2009 08:39:14 +0000
Subject: Re: [PATCH 00/04] sh: share clock framework frequency table code
Message-Id: <20090526083914.GA1610@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090525081011.7893.47950.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090525081011.7893.47950.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 25, 2009 at 05:10:11PM +0900, Magnus Damm wrote:
> sh: share clock framework frequency table code 
> 
> [PATCH 01/04] sh: add pll_clk to sh7785
> [PATCH 02/04] sh: add shared clock framework frequency table code
> [PATCH 03/04] sh: use shared frequency tables on sh7785
> [PATCH 04/04] sh: remove clk_ops->build_rate_table()
> 
> These patches modify the clkfwk topic branch with the following:
> - break out sh7785 pll_clk to remove multiplier from frqmr_recalc()
> - implement clk_rate_table_build() and clk_rate_table_round()
> - hook in the above functions in the sh7785 code, drop ->build_rate_table()
> - remove ->build_rate_table() callback since recalc() can be used instead
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Series applied to sh/clkfwk branch, thanks.
