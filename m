From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 02 Sep 2013 10:42:00 +0000
Subject: Re: [PATCH v3] dma: add driver for R-Car HPB-DMAC
Message-Id: <20130902103000.GL7376@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201308250033.24936.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308250033.24936.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: djbw@fb.com, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, max.filippov@cogentembedded.com

On Sun, Aug 25, 2013 at 12:33:24AM +0400, Sergei Shtylyov wrote:
> From: Max Filippov <max.filippov@cogentembedded.com>
> 
> Add support for HPB-DMAC found in Renesas R-Car SoCs, using 'shdma-base' DMA 
> driver framework.
> 
> Based on the original patch by Phil Edworthy <phil.edworthy@renesas.com>.
> 
> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> [Sergei: removed useless #include, sorted #include's, fixed HPB_DMA_TCR_MAX,
> fixed formats and removed line breaks in the dev_dbg() calls, rephrased and
> added IRQ # to the shdma_request_irq() failure message, added MODULE_AUTHOR(),
> removed '__init'/'__exit' annotations from the probe()/remove() methods, removed
> '__initdata' annotation from 'hpb_dmae_driver', fixed guard macro name in the
> header file, fixed #define ASYNCRSTR_ASRST20, added #define ASYNCRSTR_ASRST24,
> added the necessary runtime PM calls to the probe() and remove() methods,
> handled errors returned by dma_async_device_register(), beautified comments
> and #define's.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Applied, thanks

~Vinod
