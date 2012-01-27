From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 27 Jan 2012 06:11:01 +0000
Subject: Re: [PATCH 1/2] sh: modify resource for SPI0 in setup-sh7757
Message-Id: <20120127061101.GA3174@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F211255.9090300@renesas.com>
In-Reply-To: <4F211255.9090300@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 26, 2012 at 05:44:05PM +0900, Shimoda, Yoshihiro wrote:
> The new spi-sh driver decodes the IORESOURCE_MEM_TYPE_MASK. So, the
> resource needs the IORESOURCE_MEM_32BIT.

On Thu, Jan 26, 2012 at 05:44:07PM +0900, Shimoda, Yoshihiro wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
Applied, thanks.
