From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 01 Mar 2011 06:41:50 +0000
Subject: Re: [PATCH] sh: Enable PMB support on SH4AL-DSP
Message-Id: <20110301064150.GB5985@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 01, 2011 at 03:45:14PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The SH4AL-DSP core included in sh7372 requires use of the PMB,
> update the CONFIG_PMB Kconfig entry to reflect this.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

No. SH4AL-DSP does not in general have a PMB. If this CPU subtype is
special, then it needs to be special cased.
