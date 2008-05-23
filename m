From: Paul Mundt <paul.mundt@renesas.com>
Date: Fri, 23 May 2008 02:19:22 +0000
Subject: Re: [PATCH] sh: fix USBF resource for sh7722
Message-Id: <20080523021922.GA6230@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080522131531.12223.45466.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080522131531.12223.45466.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 22, 2008 at 10:15:31PM +0900, Magnus Damm wrote:
> The USBF function on sh7722 is currently not working with the m66592_udc
> driver. The driver is using platform_get_resource_byname() so my commit
> a0d29798e568116aa6c32aef7bab2d9e620c88ad broke sh7722 support.
> 
> The long term fix is to replace platform_get_resource_byname() in the
> driver with platform_get_resource(), but this helps until that happens.

On Thu, May 22, 2008 at 10:19:39PM +0900, Magnus Damm wrote:
> This patch fixes a VPU vector typo for sh7723. The correct value is 0x980,
> the same as for sh7722.

On Thu, May 22, 2008 at 10:24:51PM +0900, Magnus Damm wrote:
> This patch adds support for sh7723 silicon with a prr value of 0x51.

On Thu, May 22, 2008 at 10:34:28PM +0900, Magnus Damm wrote:
> Make use of recently added sm501 8250 uart support, commit
> 61711f8fd8180e458cfb6846bcf4fc636a95f3db makes the mfd code
> handle 8250 uarts so there is no longer need to do it from
> the r2d board code.

On Thu, May 22, 2008 at 10:38:36PM +0900, Magnus Damm wrote:
> Update the Migo-R defconfig to include support for KEYSC, I2C, RTC and
> NAND and NOR MTD devices.

I'll add these to the 2.6.26 queue, thanks.
