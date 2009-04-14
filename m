From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Apr 2009 05:16:12 +0000
Subject: Re: [PATCH v5] dmaengine: sh: Add Support SuperH DMA Engine driver
Message-Id: <20090414051612.GA2443@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49E41BA8.4090807@renesas.com>
In-Reply-To: <49E41BA8.4090807@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 14, 2009 at 02:14:16PM +0900, Nobuhiro Iwamatsu wrote:
> This supported all DMA channels, and it was tested in SH7722,
> SH7780 and SH7763.
> This can not use with SH DMA API.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> Reviewed-by: Matt Fleming <matt@console-pimps.org>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Maciej Sosnowski <maciej.sosnowski@intel.com>
> ---
>  v5: Fix some bug.
>      Add Cyclic extention API (got hint from dw_dmac.c)
> 
I didn't see any comment from Dan on the last version. Dan?
