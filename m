From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Sep 2013 07:12:29 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: lager: disable MMCIF Command Completion Signal, add CLK_CTRL2
Message-Id: <20130925071229.GQ6663@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
 <1373484077-10460-7-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373484077-10460-7-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

On Wed, Jul 10, 2013 at 09:21:17PM +0200, Guennadi Liakhovetski wrote:
> MMCIF on r8a7790 doesn't support Command Completion Signal, but it does
> implement a CE_CLK_CTRL2 register. Platform parameters have to be added to
> account for these features on lager.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks, I have queued this up for v3.13.
