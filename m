From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 Nov 2011 07:01:16 +0000
Subject: Re: [PATCH 1/2] sh: sh7724.h: bugfix: remove unused clock index
Message-Id: <20111124070116.GA32112@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5v8yi8p.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5v8yi8p.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 21, 2011 at 06:59:54PM -0800, Kuninori Morimoto wrote:
> Current sh clocks are using pm_runtime frame work instead of old hwblk.
> So, HWBLK_UNKNOWN and HWBLK_DBG are not needed for now.
> 
> Now mstp32 clocks are registered by sh_clk_mstp32_register(),
> but the clock which isn't defined by SH_CLK_MSTP32() macro
> will be crash. because it doesn't have enable_reg.

On Mon, Nov 21, 2011 at 07:00:04PM -0800, Kuninori Morimoto wrote:
> Current sh clocks are using pm_runtime frame work instead of old hwblk.
> So, HWBLK_UNKNOWN, HWBLK_DBG and HWBLK_SUBC are not needed for now.
> 
> Now mstp32 clocks are registered by sh_clk_mstp32_register(),
> but the clock which isn't defined by SH_CLK_MSTP32() macro
> will be crash. because it doesn't have enable_reg.

On Wed, Nov 23, 2011 at 10:53:46PM +0100, Guennadi Liakhovetski wrote:
> Unused indices produce empty entries in the clock array, which then lead to
> Oopses at boot-time.

All applied to sh/hwblk, thanks.
