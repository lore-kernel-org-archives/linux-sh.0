From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Jan 2011 04:51:57 +0000
Subject: Re: [PATCH] sh: fix MSIOF0 SPI on ecovec: it conflicts with VOU
Message-Id: <20110118045157.GK2122@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1101170901520.11874@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1101170901520.11874@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 17, 2011 at 09:02:53AM +0100, Guennadi Liakhovetski wrote:
> MSIOF0 and VOU share pins on sh7724, make MSIOF0 available again, as long as
> VOU is not configured.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Should be good for 2.6.37
> 
Applied, thanks.
