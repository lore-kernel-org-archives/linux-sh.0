From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Tue, 08 Apr 2014 10:48:02 +0000
Subject: Re: [Linux-kernel] [PATCH 2/9] ARM: shmobile: r8a7790: add dma defines for sys and audio dmacs
Message-Id: <1396954082.12538.73.camel@xylophone>
List-Id: <linux-sh.vger.kernel.org>
References: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk>
	 <1396901229-29117-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396901229-29117-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, vinod.koul@intel.com, horms@verge.net.au, magnus.damm@opensource.se, dan.j.williams@intel.com, g.liakhovetski@gmx.d

On Mon, 2014-04-07 at 21:07 +0100, Ben Dooks wrote:
> Add the DMA resource IDs for the R8A7790 Audio and SYS DMA controllers
> for use when specifying DMA handles.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  include/dt-bindings/dma/r8a7790-dma.h | 223 ++++++++++++++++++++++++++++++++++
>  1 file changed, 223 insertions(+)
>  create mode 100644 include/dt-bindings/dma/r8a7790-dma.h
> 
> diff --git a/include/dt-bindings/dma/r8a7790-dma.h b/include/dt-bindings/dma/r8a7790-dma.h
> new file mode 100644
> index 0000000..7c52132
> --- /dev/null
> +++ b/include/dt-bindings/dma/r8a7790-dma.h
> @@ -0,0 +1,223 @@
> +/*
> + * R8A7790 System and Audio DMA channel resource identifiers
> + *
> + * Copyirght (c) 2014 Codethink Ltd.
[...]

Typo: 'Copyirght'

Ben.


