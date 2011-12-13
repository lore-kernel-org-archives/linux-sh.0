From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 13 Dec 2011 02:21:32 +0000
Subject: Re: [PATCH] sh: clkfwk: sh_clk_init_parent() should be called after clk_register()
Message-Id: <20111213022131.GC19960@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <877h22h4r5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877h22h4r5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Dec 11, 2011 at 07:02:09PM -0800, Kuninori Morimoto wrote:
> sh_clk_init_parent() are using clk->mapped_reg
> which is mapped in clk_register()
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied, thanks.
