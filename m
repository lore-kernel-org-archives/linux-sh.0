From: Liam Girdwood <lrg@slimlogic.co.uk>
Date: Fri, 22 Jan 2010 17:39:20 +0000
Subject: Re: [PATCH 1/4 v2] ASoC: add a WM8978 codec driver
Message-Id: <1264181960.3094.159.camel@odin>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
	 <Pine.LNX.4.64.1001190851380.4607@axis700.grange>
	 <Pine.LNX.4.64.1001221659410.4652@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001221659410.4652@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <damm@opensource.se>

On Fri, 2010-01-22 at 17:27 +0100, Guennadi Liakhovetski wrote:
> The WM8978 codec from Wolfson Microelectronics is very similar to wm8974, but
> is stereo and also has some differences in pin configuration and internal
> signal routing. This driver is based on wm8974 and takes the differences into
> account.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

> 
> In short - addressed all comments (thanks a lot again!) - except one... I 
> still would not like to use symbolic names for register bits. Instead I 
> thoroughly commented all multi-bit register manipulations. Reasons:
> 
> 1. thanks for the header, Mark, but unfortunately it contains errors 
>    (duplicate register names, duplicate and wrong bitfield names)
> 2. the header also uses spaces for indentation, which would have to be 
>    manually replaced with TABs
> 3. I am still not convinced, that macro names like WM8978_WL or 
>    WM8978_DLRSWAP or WM8978_MS or... better describe the meaning of the 
>    bitfield than respective comment in the source. Here's an example of a 
>    comment from this patch:
> 
> 	/* bit 3: enable bias, bit 2: enable I/O tie off buffer */
> 	power1 |= 0xc;
> 
>    Where bit-field names do make sense, IMHO, is in drivers, where the 
>    same bitfields have to be written / evaluated multiple times at 
>    different locations. Than indeed giving those bits symbolic names helps 
>    finding them. So, I'd like to request a permission to preserve the 
>    present style of the driver.
> 

I think we will have to agree to disagree on this one, but it can be
fixed at a later stage.

Liam

