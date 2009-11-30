From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 30 Nov 2009 02:56:18 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: update ecovec24 defconfig
Message-Id: <20091130025618.GB7217@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 27, 2009 at 06:01:55PM +0900, Kuninori Morimoto wrote:
> o modify memory size
> o change cache configuration to boot
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> I change cache configuration 
> because currect kernel can not use CONFIG_CACHE_WRITEBACK
> 
Uhm, why not? Where is the bug report on this?

The memory change is fine, but if you've discovered a regression then
report it, rather than just turning off options until it goes away.
