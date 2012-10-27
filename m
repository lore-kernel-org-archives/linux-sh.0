From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 27 Oct 2012 07:45:30 +0000
Subject: Re: [PATCH] sh: clkfwk: bugfix: sh_clk_div_enable() care sh_clk_div_set_rate() if div6
Message-Id: <20121027074529.GA32370@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87pq45mxd9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pq45mxd9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 26, 2012 at 01:49:26AM -0700, Kuninori Morimoto wrote:
> 764f4e4e33d18cde4dcaf8a0d860b749c6d6d08b
> (sh: clkfwk: Use shared sh_clk_div_enable/disable())
> shared enable/disable funcions for div4/div6.
> But new sh_clk_div_enable() didn't care sh_clk_div_set_rate()
> which is required on div6 clock.
> This patch fixes it, and is tested by HDMI sound output on armadillo800eva
> 
> Reported-by: Cao Minh Hiep <hiepcm@gmail.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Looks good, I'll queue it up, thanks.
