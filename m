From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Nov 2009 05:17:24 +0000
Subject: Re: [PATCH] uio: pm_runtime_disable is needed if failed
Message-Id: <20091109051724.GA23903@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ufx8oju54.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ufx8oju54.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 09, 2009 at 11:42:47AM +0900, Kuninori Morimoto wrote:
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> >> Magnus
> 
> Please check this patch.
> I think pm_runtime_disable is needed here.
> 
>  drivers/uio/uio_pdrv_genirq.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
Unfortunately this missed my pull request by about an hour, so I'll queue
it up once Linus pulls the already pending stuff. I'll merge this for
2.6.32-rc8.
