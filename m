From: Liam Girdwood <lrg@slimlogic.co.uk>
Date: Mon, 25 Jan 2010 13:58:38 +0000
Subject: Re: [PATCH 2a/4 v2] ASoC: add DAI and platform / DMA drivers for
Message-Id: <1264427918.3038.21.camel@odin>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
	 <Pine.LNX.4.64.1001190902000.4607@axis700.grange>
	 <Pine.LNX.4.64.1001221900030.4652@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001221900030.4652@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <damm@opensource.se>

On Fri, 2010-01-22 at 19:09 +0100, Guennadi Liakhovetski wrote:
> Several SuperH platforms, including sh7722, sh7343, sh7354, sh7367 include 
> a Sound Interface Unit (SIU). This patch adds DAI and platform / DMA 
> drivers for this interface.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> v1 -> v2:
> 
> 1. splitted off board support into a separate patch
> 2. made SND_SOC_SH4_SIU a hidden Kconfig variable
> 3. SND_SOC_SH4_SIU now can be selected on other SuperH platforms, not only 
>    on sh7722
> 4. moved many defines, that are only used in one of .c-files in those 
>    files
> 5. prefixed remaining defines in the header with SIU_
> 6. clarification: "only fixed Left-upper, Left-lower, Right-upper, 
>    Right-lower packing is supported" means - only this byte order is 
>    hard-coded without support for other possible byte-orders
> 7. clk_put() doesn't mind getting an error code as its argument, but moved 
>    it under the respective "if" just in case;)
> 8. removed mono-emulation via data-copying. Looking for a recipe to achive 
>    this via alsa-configuration, anyone?
> 

Acked-by:Liam Girdwood <lrg@slimlogic.co.uk>


