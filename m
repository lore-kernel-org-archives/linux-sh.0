From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Jun 2012 07:37:07 +0000
Subject: Re: [PATCH] sh: kfr2r09: fix compile breakage
Message-Id: <20120628073707.GA21764@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1206271125530.24173@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1206271125530.24173@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 27, 2012 at 11:26:34AM +0200, Guennadi Liakhovetski wrote:
> Fix compile breakage caused by
> 
> commit aa82f9fcd0062782dcbe29a2c820ba7c04dbe572
> Author: Paul Mundt <lethal@linux-sh.org>
> 
>     sh: kfr2r09 evt2irq migration.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> needed for 3.5
> 
Figures there was at least one. Oh well, I suppose one breakage out of
hundreds isn't too bad.

Applied to sh/urgent, thanks.
