From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Aug 2011 07:47:52 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 MSIOF clock support
Message-Id: <20110829074752.GI31809@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110826052511.25734.78502.sendpatchset@rxone.opensource.se>
In-Reply-To: <20110826052511.25734.78502.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 26, 2011 at 02:25:11PM +0900, Magnus Damm wrote:
> Add clock control support for sh7372 MSIOF hardware blocks.
> 
> No upstream sh7372 boards are making use of MSIOF0->2,
> but the sh7372 hardware happens to come out of reset with
> all MSIOF MSTP clocks _enabled_, so to save power we need
> to implement a fix in software to shut down unused clocks.
> 
> This patch relies on the recently merged
> 
>  794d78f drivers: sh: late disabling of clocks V2
> 
> to make sure the unused clocks get disabled as expected.

On Fri, Aug 26, 2011 at 02:28:42PM +0900, Magnus Damm wrote:
> Add clock control support for sh7372 CMT hardware blocks.
> 
> No upstream sh7372 boards are making use of CMT3 + CMT4,
> but the sh7372 hardware happens to come out of reset with
> all CMT MSTP clocks _enabled_, so to save power we need
> to implement a fix in software to shut down unused clocks.
> 
> This patch relies on the recently merged
> 
>  794d78f drivers: sh: late disabling of clocks V2
> 
> to make sure the unused clocks get disabled as expected.

Both applied, thanks.
