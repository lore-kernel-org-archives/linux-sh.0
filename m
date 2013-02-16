From: Simon Horman <horms@verge.net.au>
Date: Sat, 16 Feb 2013 02:26:35 +0000
Subject: Re: [PATCH v4 00/13] mmc: core and driver DT and related development
Message-Id: <20130216022634.GB11628@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>

On Fri, Feb 15, 2013 at 04:13:49PM +0100, Guennadi Liakhovetski wrote:
> This is v4 of a patch-series, extending mmc subsystem device-tree usage 
> and adding more advanced DT capabilities to sh_mmcif and sh_mobile_sdhi / 
> tmio_mmc drivers. Changes since v3 are described in respective patches. 
> Thanks to all who commented on v3.

Hi,

I do not expect this code to go through the renesas tree.  However, in
order to provide a basis for work on renesas SoCs I have added this patch
to the topic/mmc topic branch in the reneas tree on kernel.org and
merged it into topic/all+next.

In other words, I am not picking this series up to merge it or add it to
linux-next, rather I am storing it for reference.

