From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Apr 2012 07:03:43 +0000
Subject: Re: [PATCH 5/6] ARM: mach-shmobile: armadillo800eva: add support gpio_key
Message-Id: <20120406070338.GA20174@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87iphe4lx7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iphe4lx7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 05, 2012 at 10:21:47PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> Thank you for checking patch.
> 
> > I am seeing the following, is it expected?
> > 
> > gpio-keys gpio-keys: Unable to get irq number for GPIO 99, error -38
> > gpio-keys: probe of gpio-keys failed with error -38
> 
> Sorry for confusion.
> Yes. gpio-keys support needs +1 patch.
> 
> I expected it on [0/6] mail :)

Sorry, I should have read that email more thoroughly.
