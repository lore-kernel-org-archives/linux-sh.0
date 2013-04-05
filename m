From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Apr 2013 07:15:29 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: enable AS3711 PMIC in defconfig
Message-Id: <Pine.LNX.4.64.1304050913220.32675@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1304031752440.10531@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1304031752440.10531@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon

On Thu, 4 Apr 2013, Simon Horman wrote:

> On Wed, Apr 03, 2013 at 05:53:54PM +0200, Guennadi Liakhovetski wrote:
> > An AS3711 PMIC is used on kzm9g to supply CPU power and LCD backlight.
> > This patch enables it in board defconfig.
> 
> Thanks, applied to the defconfigs branch.
> I will endeavour to get this included in v3.10.

Thanks, but actually this patch is just a reply to your request to support 
the earlier "ARM: shmobile: add AS3711 PMIC platform data on kzm9g" patch 
from me, which I still don't see in your tree?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
