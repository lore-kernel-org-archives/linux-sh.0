From: Simon Horman <horms@verge.net.au>
Date: Thu, 24 Apr 2014 06:59:46 +0000
Subject: Re: [PATCH v6 0/2] clk: shmobile: r8a7779: Add clocks support
Message-Id: <20140424065946.GC3925@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1397775951-30992-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1397775951-30992-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Apr 18, 2014 at 08:05:49AM +0900, Simon Horman wrote:
> Hi Mike,
> 
> please consider applying this series.
> 
> It is the first step on the way towards using the common clock framework
> and in turn multi-platform on the r8a7779 (R-Car H1) SoC.
> 
> It has been acked by Laurent Pinchart who did similar work
> for the R-Car Gen-2 family of SoCs. This work is based on that work.
> 
> The bindings added in this series have not been changed since
> v4 was posted with devicetree@vger.kernel.org CCed on the 13th of March.

Hi Mike,

if you could take a look at this I would be most grateful.

> 
> Simon Horman (2):
>   clk: shmobile: r8a7779: Add clocks support
>   clk: shmobile: r8a7779: Add MSTP clock support
> 
>  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
>  .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  |  27 ++++
>  drivers/clk/shmobile/Makefile                      |   1 +
>  drivers/clk/shmobile/clk-r8a7779.c                 | 180 +++++++++++++++++++++
>  include/linux/clk/shmobile.h                       |   3 +
>  5 files changed, 212 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
>  create mode 100644 drivers/clk/shmobile/clk-r8a7779.c
> 
> -- 
> 1.8.4
> 
