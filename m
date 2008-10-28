From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 28 Oct 2008 06:57:43 +0000
Subject: Re: [PATCH] SH 7366 needs SCIF_ONLY
Message-Id: <20081028065743.GA8737@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <u63ndp678.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u63ndp678.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 28, 2008 at 03:33:48PM +0900, Kuninori Morimoto wrote:
> 
> SH 7366 has compile bug.
> because there is no SCIF_ONLY for SH 7366.
> this patch add it.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Which platform are you building for? Can you provide your .config? We
presently do not have an in-tree SH7366 board, which is how this was
missed. I'll apply your patch for 2.6.28. For 2.6.29, all of that has
been rewritten.
