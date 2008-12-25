From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 25 Dec 2008 10:16:37 +0000
Subject: Re: [PATCH] sh: export the sh7343 JPU to user space
Message-Id: <20081225101637.GA22403@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081225095526.32515.83316.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081225095526.32515.83316.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 25, 2008 at 06:55:26PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch exports the sh7343 JPU to user space using uio_pdrv_genirq,
> very similar to the sh7722 JPU patch by Hayama-san.
> 
> While at it fix up the end of the sh7722 JPU iomem resource.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

I'll add this and the others to the queue for the next merge, after Linus
pulls the current batch.
