From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 22 May 2010 07:46:32 +0000
Subject: Re: [PATCH] SH: add Video Output Unit and AK8813 video encoder support on ecovec
Message-Id: <20100522074632.GC17814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1004211039220.5292@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1004211039220.5292@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, Apr 21, 2010 at 10:45:25AM +0200, Guennadi Liakhovetski wrote:
> Ecovec uses the AK8813 video envoder similarly to the ms7724se platform with
> the only difference, that on ecovec GPIOs are used for resetting and powering
> up and down the chip.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> This patch extends the SuperH VOU / AK881x patch series: 
> http://thread.gmane.org/gmane.linux.ports.sh.devel/7751/focusw53
> 
>  arch/sh/boards/mach-ecovec24/setup.c |   78 ++++++++++++++++++++++++++++++++++
>  1 files changed, 78 insertions(+), 0 deletions(-)
> 
Applied, thanks.
