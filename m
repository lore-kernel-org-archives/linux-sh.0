From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 06:20:22 +0000
Subject: Re: [PATCH] sh: sh7372 SH4AL-DSP probe support
Message-Id: <20110113062022.GG12013@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110112105421.11079.83096.sendpatchset@t400s>
In-Reply-To: <20110112105421.11079.83096.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 12, 2011 at 07:54:21PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add probe support for the sh7372 SH4AL-DSP core.
> 
> The most common use case for this is when the system
> boots from the ARM core in the sh7372 and uses the
> SH core for application offload as a slave CPU.
> 
> May also be used to boot the sh7372 from the SH core.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied, thanks.
