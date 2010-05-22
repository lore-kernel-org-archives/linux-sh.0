From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 22 May 2010 08:32:45 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7367/G3EVM evt2irq() update
Message-Id: <20100522083245.GF17814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100520143530.27616.16098.sendpatchset@t400s>
In-Reply-To: <20100520143530.27616.16098.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 20, 2010 at 11:35:30PM +0900, Magnus Damm wrote:
> This patch updates the irq numbers on sh7367/G3EVM
> to make use of evt2irq() and intcs_evt2irq().

On Thu, May 20, 2010 at 11:39:21PM +0900, Magnus Damm wrote:
> This patch updates the irq numbers on sh7377/G4EVM
> to make use of evt2irq() and intcs_evt2irq().
> 
> Makes the system cope with an updated INTCS_VECT_BASE.

On Thu, May 20, 2010 at 11:41:00PM +0900, Magnus Damm wrote:
> This patch updates the irq numbers on sh7372/AP4EVB
> to make use of evt2irq() and intcs_evt2irq().

On Thu, May 20, 2010 at 11:45:03PM +0900, Magnus Damm wrote:
> Fixes for the sh7372 clock framework:
>  - remove unused #include <linux/platform_device.h>
>  - add sh7372 prefix to user modifiable root clocks
>  - put modifiable root clock prototypes in header file
>  - fix off-by-one id error on VEU MSTP clocks
>  - make arrays static

On Thu, May 20, 2010 at 11:49:28PM +0900, Magnus Damm wrote:
> This patch is V2 of clock framework tables/code for sh7367.
> MSTP support is included for the following hardware blocks:
> KEYSC, SCIF, IIC, IRDA, FLCTL, VOU, SIU, USB, SDHI and UIO.

All applied, thanks.
