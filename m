From: Simon Horman <horms@verge.net.au>
Date: Mon, 13 May 2013 01:27:15 +0000
Subject: Re: [PATCH v4 2/4] sh-pfc: r8a7778: add VIN pin groups
Message-Id: <20130513012715.GC7826@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201305090314.35733.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201305090314.35733.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 09, 2013 at 03:14:35AM +0400, Sergei Shtylyov wrote:
> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Add VIN DATA[0:8]/CLK/HSYNC/VSYNC pin groups to R8A7778 PFC driver.
> While at it, add SH_PFC_MUX8() macro for 8-bit data busses.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: updated the copyrights, added SH_PFC_MUX8() macro for 8-bit data bus,
> made use of SH_PFC_*() macros to define the pin groups.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, queued-up for v3.11 in the pinmux branch.
