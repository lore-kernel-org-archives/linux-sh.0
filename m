From: Simon Horman <horms@verge.net.au>
Date: Fri, 05 Apr 2013 07:38:41 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: enable AS3711 PMIC in defconfig
Message-Id: <20130405073841.GC23419@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1304031752440.10531@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1304031752440.10531@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 05, 2013 at 09:15:29AM +0200, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Thu, 4 Apr 2013, Simon Horman wrote:
> 
> > On Wed, Apr 03, 2013 at 05:53:54PM +0200, Guennadi Liakhovetski wrote:
> > > An AS3711 PMIC is used on kzm9g to supply CPU power and LCD backlight.
> > > This patch enables it in board defconfig.
> > 
> > Thanks, applied to the defconfigs branch.
> > I will endeavour to get this included in v3.10.
> 
> Thanks, but actually this patch is just a reply to your request to support 
> the earlier "ARM: shmobile: add AS3711 PMIC platform data on kzm9g" patch 
> from me, which I still don't see in your tree?

I see no particular problem with adding the defconfig change first.

With regards to "ARM: shmobile: add AS3711 PMIC platform data on kzm9g",
I'm unsure why I didn't queue-that up yesterday. I have done so now.
It is in the new boards-kzm9g branch.
