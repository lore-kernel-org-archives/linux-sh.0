From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 24 Nov 2010 09:56:21 +0000
Subject: Re: [PATCH 2/6 v2] ARM: mach-shmobile: ap4evb: FSI clock use
Message-Id: <20101124095621.GB5139@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3ptyj7zbim.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3ptyj7zbim.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 24, 2010 at 11:44:06AM +0900, Kuninori Morimoto wrote:
> Current AP4 FSI set_rate function used bogus clock process
> which didn't care enable/disable and clk->usecound.
> To solve this issue, this patch also modify FSI driver to call
> set_rate with enough options.
> This patch modify it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
