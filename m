From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 19 Feb 2013 19:20:44 +0000
Subject: Re: [PATCH v4 00/13] mmc: core and driver DT and related development
Message-Id: <5123D08C.9060904@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

On 02/15/2013 08:13 AM, Guennadi Liakhovetski wrote:
> This is v4 of a patch-series, extending mmc subsystem device-tree usage 
> and adding more advanced DT capabilities to sh_mmcif and sh_mobile_sdhi / 
> tmio_mmc drivers. Changes since v3 are described in respective patches. 
> Thanks to all who commented on v3.

Chris, do you know if this series is going into 3.9 or if it'll only
make 3.10?

If it goes into 3.10, I may need to merge the MMC tree into the Tegra
tree to resolve some conflicts. Perhaps this series could be applied in
a topic branch on its own to simplify this?
