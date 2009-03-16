From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 16 Mar 2009 11:24:36 +0000
Subject: Re: [PATCH] dmaengine: sh: Add support DMA-Engine driver for DMA of SuperH
Message-Id: <20090316112436.GH21433@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49B8AF67.8080309@renesas.com>
In-Reply-To: <49B8AF67.8080309@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: Linux-sh <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, maciej.sosnowski@intel.com, dan.j.williams@intel.com

On Thu, Mar 12, 2009 at 03:44:55PM +0900, Nobuhiro Iwamatsu wrote:
> This supports DMA-Engine driver for DMA of SuperH.
> This supported all DMA channels, and it was tested in SH7722/SH7780.
> This can not use with SH DMA API and can control this in Kconfig.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
> Cc: Maciej Sosnowski <maciej.sosnowski@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>

The updated version looks ok to me. If no one else has any issues with
it, and someone from the dmaengine side wants to provide an Acked-by, I
can take it through my tree.
