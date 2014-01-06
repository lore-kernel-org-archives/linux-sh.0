From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Jan 2014 05:26:33 +0000
Subject: Re: [PATCH V2] ARM: shmobile: r8a7790: Fix I2C controller names
Message-Id: <20140106052632.GC24653@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1388141888-5424-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388141888-5424-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 27, 2013 at 02:58:08PM +0400, Valentine Barshak wrote:
> This fixes the issue introduced by the following commit:
> b448c904f5058b6c "ARM: shmobile: r8a7790: add I2C support"
> 
> The R8A7790 is an R-Car Gen2 SoC. The clock division factor
> (CDF) width is 3 bits on Gen2 as opposed to 2 bits on Gen1.
> Fix the device names for R8A7790 SoC to make the R-Car I2C
> driver configure the hardware properly.
> 
> Changes in V2:
> * rebased on top of the latest branch;
> * capitalized ARM in the subject line;
> * noted the commit that caused the issue in the log.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I will queue this up.
