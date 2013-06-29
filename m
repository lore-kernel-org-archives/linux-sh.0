From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 29 Jun 2013 21:49:16 +0000
Subject: Re: [PATCH] dma: add driver for R-Car HPB-DMAC
Message-Id: <51CF565C.1020309@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201306300015.50713.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306300015.50713.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: djbw@fb.com, vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 06/30/2013 12:15 AM, Sergei Shtylyov wrote:

    Oops, forgot to add the From: line. The patch is not mine, I've only 
modified it slightly. Will repost now...

> Add support for HPB-DMAC found in Renesas R-Car SoCs, using 'shdma-base' DMA
> driver framework.
>
> Based on the original patch by Phil Edworthy <phil.edworthy@renesas.com>.
>
> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> [Sergei: removed useless #include, sorted #include's, fixed HPB_DMA_TCR_MAX,
> fixed formats and removed line breaks in the dev_dbg() calls, rephrased and
> added IRQ # to the shdma_request_irq() failure message, added MODULE_AUTHOR(),
> fixed guard macro name in the header file, fixed #define ASYNCRSTR_ASRST20,
> added #define ASYNCRSTR_ASRST24, beautified some commets.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

WBR, Sergei

