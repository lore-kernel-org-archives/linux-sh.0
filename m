From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 29 Jan 2008 00:46:34 +0000
Subject: Re: [PATCH] sh: declared coherent memory support V2 fix
Message-Id: <20080129004634.GB9937@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080113135447.30289.54583.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080113135447.30289.54583.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 25, 2008 at 12:42:48PM +0900, Magnus Damm wrote:
> sh: declared coherent memory support V2 fix
> 
> This patch fixes the recently introduced declared coherent memory support.
> Without this fix a cached memory area is returned by dma_alloc_coherent() -
> unless dma_declare_coherent_memory() has setup a separate area.
> 
> This patch makes sure an uncached memory area is returned. With this patch
> it is now possible to ping through an rtl8139 interface on r2d-plus.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Grr, missed this one. For some reason my eyes stopped at 'V2' and didn't
see the 'fix' part, so I thought I had already applied this one. I'll
roll it in to the next -rc1 batch.
