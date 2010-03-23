From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Mar 2010 04:34:09 +0000
Subject: Re: [PATCH] SH: fix SCIFA SCASCR register bit definitions
Message-Id: <20100323043409.GF13417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1003191451290.5412@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1003191451290.5412@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 19, 2010 at 02:52:35PM +0100, Guennadi Liakhovetski wrote:
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/serial/sh-sci.h |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

On Fri, Mar 19, 2010 at 02:53:36PM +0100, Guennadi Liakhovetski wrote:
> This warning has been introduced during the SCI DMA support developmenr and is
> not needed any more.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

These are applied for 2.6.34.
