From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Sep 2015 00:52:11 +0000
Subject: Re: [PATCH v3 0/5] r8a7778/bockw: fix SMSC Ethernet for MP
Message-Id: <20150909005211.GD29272@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1441726946-30131-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1441726946-30131-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 08, 2015 at 05:42:21PM +0200, Ulrich Hecht wrote:
> Hi!
> 
> This series enables the DT-wise IRLM setup in the intc-irqpin driver (same
> as on r8a7779) and configures the FPGA correctly.
> 
> This revision adds defconfig updates and Simon's Tested-By.
> 
> CU
> Uli
> 
> 
> Changes since v2:
> - added defconfig updates
> - added Tested-By
> 
> Changes since v1:
> - split IRLM support into C and DT parts
> - added clarifying comment to FPGA description
> - added Acks

Hi Uli,

Thanks for following up on this

Bockw boots all the way to userspace using nfsroot using this series.

Tested-by: Simon Horman <horms+renesas@verge.net.au>

> Ulrich Hecht (5):
>   irqchip: renesas-intc-irqpin: r8a7778 IRLM setup support
>   ARM: shmobile: r8a7778: enable IRLM setup via DT
>   ARM: shmobile: bockw dts: enable SMSC interrupt
>   ARM: shmobile_defconfig: enable PINCTRL_SINGLE
>   ARM: multi_v7_defconfig: enable PINCTRL_SINGLE

Jason,

could you consider picking-up the irqchip patch, the first of the series?
With that in place I can go ahead and queue up the remaining patches.
