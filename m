From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 01 Jun 2009 09:14:02 +0000
Subject: Re: [PATCH] sh: shared mstp32 clock code
Message-Id: <20090601091402.GB31292@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 28, 2009 at 09:52:29PM +0900, Magnus Damm wrote:
> Add shared 32-bit module stop bit clock support.
> 
> Processor specific code can use SH_CLK_MSTP32()
> to initialize module stop bit clocks, and then
> use sh_clk_mstp32() for registration.

On Thu, May 28, 2009 at 10:01:53PM +0900, Magnus Damm wrote:
> Hook up the shared 32-bit module stop bit code to sh7785.

On Thu, May 28, 2009 at 10:11:31PM +0900, Magnus Damm wrote:
> Add shared code for 4-bit divisor clocks.

On Thu, May 28, 2009 at 10:13:56PM +0900, Magnus Damm wrote:
> Hook up the shared 4-bit divisor clock code to sh7785.

Applied, thanks.
