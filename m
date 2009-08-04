From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 04 Aug 2009 05:46:39 +0000
Subject: Re: [PATCH] ms7724se: add 1280x720 lcdc output support
Message-Id: <20090804054638.GC21171@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <u8wi1ts7g.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u8wi1ts7g.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 03, 2009 at 01:52:03PM +0900, Kuninori Morimoto wrote:
> There was no big meaning in the support of SVGA,
> but 720p support is necessary for ms7724se board.
> So, this patch support 720p instead of SVGA.

On Mon, Aug 03, 2009 at 01:52:24PM +0900, Kuninori Morimoto wrote:
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/include/asm/dma-sh.h           |    1 +
>  arch/sh/include/cpu-sh4/cpu/dma-sh4a.h |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
Applied.
