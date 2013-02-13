From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 11:02:06 +0000
Subject: Re: [PATCH v2 2/3] ARM: shmobile: switch SDHI0 to GPIO regulator on armadillo800eva
Message-Id: <20130213110205.GE22623@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1302131120360.18535@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1302131120360.18535@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 13, 2013 at 11:34:03AM +0100, Guennadi Liakhovetski wrote:
> When regulators are used with MMC devices, explicitly provided OCR masks
> are ignored, they can be removed from platform data. Also switch SDHI0
> from fixed regulator with hard-wired GPIO levels to a proper GPIO regulator
> instance to enable dynamic voltage switching.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v2: fix wrong curly bracket placement and an overly-long line, thanks to 
> Morimoto-san for reporting

Thanks, applied to boards3.
