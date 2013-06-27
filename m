From: Simon Horman <horms@verge.net.au>
Date: Thu, 27 Jun 2013 08:18:57 +0000
Subject: Re: [PATCH 1/2 v3] ARM: shmobile: r8a7778: add __initdata on resource and device data
Message-Id: <20130627081856.GE13927@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87mwrh8cqa.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mwrh8cqa.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 27, 2013 at 06:54:52PM +0900, Simon Horman wrote:
> On Sun, May 26, 2013 at 05:53:37PM -0700, Kuninori Morimoto wrote:
> > These data will be kmemdup()'ed on
> > platform_device_add_resources() and platform_device_add_data()
> 
> Thanks, queued up for v3.11 in the pinmux branch.
> 
> I added it there as that is the branch which includes
> all the code that this patch modifies.

I ended up dropping this patch for v3.11 as part of some patch resuffling.

I have queued if up for v3.12 in the cleanup branch.
