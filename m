From: Chris Ball <cjb@laptop.org>
Date: Sun, 25 Aug 2013 04:11:13 +0000
Subject: Re: [PATCH v2] mmc: sh_mmcif: add support for Device Tree DMA bindings
Message-Id: <877gfaquji.fsf@octavius.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1306241434200.19735@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1306241434200.19735@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 24 Jun 2013 14:36:34 +0200 (CEST)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Guennadi,

On Mon, Jun 24 2013, Guennadi Liakhovetski wrote:
> To use DMA in the Device Tree case the driver has to be modified
> to use suitable API to obtain DMA channels.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
