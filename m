From: Chris Ball <cjb@laptop.org>
Date: Mon, 14 Jan 2013 19:17:44 +0000
Subject: Re: [PATCH/RFC] mmc: sh-mmcif: simplify IRQ processing
Message-Id: <87hamjtvzb.fsf@laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1212121540250.10522@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1212121540250.10522@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 12 Dec 2012 15:45:14 +0100 (CET)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Guennadi,

On Wed, Dec 12 2012, Guennadi Liakhovetski wrote:
> The classical way to process IRQs is read out the status, ack all triggered
> IRQs, possibly mask them, then process them. Follow this simple procesure
> instead of the current complex custom algorithm.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> Hi Chris
>
> Attention: this patch is __NOT__ for 3.8, please, let it simmer in -next 
> until 3.9. It modifies the driver's interrupt handling significantly, so, 
> we want to have it tested over a longer period.

Sorry for the delay, this is in mmc-next now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
