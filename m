From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 May 2010 08:49:48 +0000
Subject: Re: [PATCH 00/09] SuperH clkdev rework round 2
Message-Id: <20100513084948.GA11391@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100511045933.26302.37116.sendpatchset@t400s>
In-Reply-To: <20100511045933.26302.37116.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 11, 2010 at 01:59:33PM +0900, Magnus Damm wrote:
> [PATCH 01/09] sh: sh7343 mstp32 index rework
> [PATCH 02/09] sh: sh7343 mstp32 clkdev lookup 
> [PATCH 03/09] sh: sh7366 mstp32 index rework
> [PATCH 04/09] sh: sh7366 mstp32 clkdev lookup 
> [PATCH 05/09] sh: sh7785 mstp32 index rework
> [PATCH 06/09] sh: sh7785 mstp32 clkdev lookup 
> [PATCH 07/09] sh: sh7786 mstp32 index rework
> [PATCH 08/09] sh: sh7786 mstp32 clkdev lookup 
> [PATCH 09/09] sh: get rid of mstp32 clock name and id

On Tue, May 11, 2010 at 04:05:01PM +0900, Magnus Damm wrote:
> [PATCH 01/09] sh: div4 reparent workaround
> [PATCH 02/09] sh: sh7722 div4 clkdev lookup
> [PATCH 03/09] sh: sh7723 div4 clkdev lookup
> [PATCH 04/09] sh: sh7724 div4 clkdev lookup
> [PATCH 05/09] sh: sh7343 div4 clkdev lookup
> [PATCH 06/09] sh: sh7366 div4 clkdev lookup
> [PATCH 07/09] sh: sh7785 div4 clkdev lookup
> [PATCH 08/09] sh: sh7786 div4 clkdev lookup
> [PATCH 09/09] sh: get rid of div4 clock name

On Tue, May 11, 2010 at 06:35:04PM +0900, Magnus Damm wrote:
> [PATCH 01/15] sh: switch legacy clocks to clkdev
> [PATCH 02/15] sh: switch sh7724 to clkdev 
> [PATCH 03/15] sh: switch sh7723 to clkdev 
> [PATCH 04/15] sh: switch sh7722 to clkdev 
> [PATCH 05/15] sh: switch sh7343 to clkdev 
> [PATCH 06/15] sh: switch sh7366 to clkdev 
> [PATCH 07/15] sh: switch sh7785 to clkdev 
> [PATCH 08/15] sh: switch sh7786 to clkdev 
> [PATCH 09/15] sh: switch sh7780 to clkdev 
> [PATCH 10/15] sh: switch sh7763 to clkdev 
> [PATCH 11/15] sh: switch sh7757 to clkdev 
> [PATCH 12/15] sh: switch shx3 to clkdev 
> [PATCH 13/15] sh: switch sh4-202 to clkdev 
> [PATCH 14/15] sh: switch boards to clkdev 
> [PATCH 15/15] sh: remove unused clock lookup

On Tue, May 11, 2010 at 10:29:09PM +0900, Magnus Damm wrote:
> [PATCH 01/03] sh: move sh asm/clock.h contents to linux/sh_clk.h V2
> [PATCH 02/03] sh: move sh clock.c contents to drivers/sh/clk.
> [PATCH 03/03] sh: move sh clock-cpg.c contents to drivers/sh/clk-cpg.c

All applied, thanks.
