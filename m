From: Chris Ball <cjb@laptop.org>
Date: Thu, 05 Jul 2012 17:35:56 +0000
Subject: Re: [PATCH 3/9 v3] mmc: sh_mmcif: remove unneeded struct sh_mmcif_dma, prepare to shdma conversion
Message-Id: <87a9zexg8z.fsf@octavius.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1336576161-27082-1-git-send-email-g.liakhovetski@gmx.de>
	<1336576161-27082-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1336576161-27082-4-git-send-email-g.liakhovetski@gmx.de>
	(Guennadi Liakhovetski's message of "Wed, 9 May 2012 17:09:15 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

Hi,

On Wed, May 09 2012, Guennadi Liakhovetski wrote:
> Now that all users have been updated to use the embedded in struct
> sh_mmcif_plat_data DMA slave IDs, struct sh_mmcif_dma is no longer needed
> and can be removed. This also makes preparation to the shdma base library
> conversion easier.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Chris Ball <cjb@laptop.org>

Acked-by: Chris Ball <cjb@laptop.org>

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
