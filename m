From: Simon Horman <horms@verge.net.au>
Date: Fri, 21 Nov 2014 04:09:10 +0000
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: Increase MMCIF clock rate to 97.5MHz
Message-Id: <20141121040907.GA31076@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415688142-20023-1-git-send-email-ykaneko0929@gmail.com>
 <87sihoklaj.wl%kuninori.morimoto.gx@renesas.com>
 <20141113002446.GB9195@verge.net.au>
 <87zjbvhoj0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zjbvhoj0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Thu, Nov 13, 2014 at 01:34:13AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > you are correct in assuming that this patch came from the BSP.
> > 
> > Is your opinion that a) changing the clock rate is good but
> > b) it needs to be done using a standard method?
> > 
> > If so, is the main change required to use a standard binding string
> > rather than "renesas,clk-rate"? Is the driver change above needed at all?
> 
> I'm not 100% understand, but, maybe these settings are required for
> MMC/SHDI's good performance.
> I guess we can use CCF method for it ?

That does sound like an idea worth investigating.
I wonder what the best way is to move this forwards.
