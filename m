From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 01 Jun 2009 08:39:27 +0000
Subject: Re: [PATCH] sh: boot word / mode pin support V2
Message-Id: <20090601083927.GA31292@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090521071620.12842.12995.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090521071620.12842.12995.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 28, 2009 at 08:51:51PM +0900, Magnus Damm wrote:
> Add mode pin support for the SuperH architecture V2.
> 
> With this patch applied the board code can add their
> own function to export the cpu mode pin configuration.
> In most cases this will be a constant bitmap, but
> boards that allow reading this from a register can
> instead read out the pin state from hardware.
> 
> The code warns if a pin is tested but no board specific
> mode pin function has been provided.
> 

On Thu, May 28, 2009 at 08:56:21PM +0900, Magnus Damm wrote:
> This patch adds sh7785 mode pin definitions. Mode pins and
> pin function controller comments are added as well.
> 
[snip]

> --- 0001/arch/sh/include/cpu-sh4/cpu/sh7785.h
> +++ work/arch/sh/include/cpu-sh4/cpu/sh7785.h	2009-05-28 20:42:21.000000000 +0900
> @@ -1,6 +1,28 @@
>  #ifndef __ASM_SH7785_H__
>  #define __ASM_SH7785_H__
>  
> +/* Boot Mode Pins, more information in sh7785 manual Rev.1.00, page 1628 */
> +#define MODE_PIN_MODE0 0 /* CPG - Initial Pck/Bck Frequency [FRQMR1] */
> +#define MODE_PIN_MODE1 1 /* CPG - Initial Uck/SHck/DDRck Frequency [FRQMR1] */
> +#define MODE_PIN_MODE2 2 /* CPG - Reserved (L: Normal operation) */
> +#define MODE_PIN_MODE3 3 /* CPG - Reserved (L: Normal operation) */
> +#define MODE_PIN_MODE4 4 /* CPG - Initial PLL setting (72x/36x) */
> +#define MODE_PIN_MODE5 5 /* LBSC - Area0 Memory Type / Bus Width [CS0BCR.8] */
> +#define MODE_PIN_MODE6 6 /* LBSC - Area0 Memory Type / Bus Width [CS0BCR.9] */
> +#define MODE_PIN_MODE7 7 /* LBSC - Area0 Memory Type / Bus Width [CS0BCR.3] */
> +#define MODE_PIN_MODE8 8 /* LBSC - Endian Mode (L: Big, H: Little) [BCR.31] */
> +#define MODE_PIN_MODE9 9 /* LBSC - Master/Slave Mode (L: Slave) [BCR.30] */
> +#define MODE_PIN_MODE10 10 /* CPG - Clock Input (L: Ext Clk, H: Crystal) */
> +#define MODE_PIN_MODE11 11 /* PCI - Pin Mode (LL: PCI host, LH: PCI slave) */
> +#define MODE_PIN_MODE12 12 /* PCI - Pin Mode (HL: Local bus, HH: DU) */
> +#define MODE_PIN_MODE13 13 /* Boot Address Mode (L: 29-bit, H: 32-bit) */
> +#define MODE_PIN_MODE14 14 /* Reserved (H: Normal operation) */
> +#define MODE_PIN_MPMD 15 /* Emulation Mode (L: Emulation mode, H: LSI mode) */
> +
I've changed this to an enum so it appears less visually offensive.

On Thu, May 28, 2009 at 09:00:25PM +0900, Magnus Damm wrote:
> This patch adds mode pin support to the sh7785lcr board.
> 
> The harware allows the user to control the mode pins using
> dip switches S1 and S2, but from the software the pins are
> fixed to the factory default since we have no way to reading
> out this configuration from software.

On Thu, May 28, 2009 at 09:06:17PM +0900, Magnus Damm wrote:
> This patch modifies the sh7785 clock code to use the MODE4
> value to switch between 72x and 36x PLL multiplication.

All applied, thanks.
