From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Nov 2008 07:04:18 +0000
Subject: Re: [PATCH] sh: enable and disable clocks recursively
Message-Id: <20081113070418.GB25436@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 31, 2008 at 08:13:32PM +0900, Magnus Damm wrote:
> Recurse and make sure parent clocks get enabled/disabled.

On Fri, Oct 31, 2008 at 08:14:03PM +0900, Magnus Damm wrote:
> Use divider index value instead of divider value.

On Fri, Oct 31, 2008 at 08:14:28PM +0900, Magnus Damm wrote:
> Use arch_flags to keep track of register and flag number.

On Fri, Oct 31, 2008 at 08:15:07PM +0900, Magnus Damm wrote:
> Add base code to handle new mstpcr clocks. Make sure clock rates propagate.

On Fri, Oct 31, 2008 at 08:15:48PM +0900, Magnus Damm wrote:
> Add sh7722 mstpcr bits and information about their parent clocks.

On Fri, Oct 31, 2008 at 08:16:08PM +0900, Magnus Damm wrote:
> Add sh7723 mstpcr bits and information about their parent clocks.
> The datasheet is pretty clear about the clocks on this device.

On Fri, Oct 31, 2008 at 08:19:38PM +0900, Magnus Damm wrote:
> Add sh7343 mstpcr bits and information about their parent clocks.

On Fri, Oct 31, 2008 at 08:20:23PM +0900, Magnus Damm wrote:
> Add sh7366 mstpcr bits and information about their parent clocks.
> The datasheet is pretty clear about the clocks on this device.

On Fri, Oct 31, 2008 at 08:20:55PM +0900, Magnus Damm wrote:
> Add clock framework support to the sh_mobile i2c driver and
> adjust the processor specific code accordingly.

On Fri, Oct 31, 2008 at 08:21:23PM +0900, Magnus Damm wrote:
> Add clock framework support to the sh_mobile keysc driver and
> adjust the board specific code accordingly.

On Fri, Oct 31, 2008 at 08:21:44PM +0900, Magnus Damm wrote:
> Add clock framework support to the sh_mobile ceu and
> adjust the board specific code accordingly.

On Fri, Oct 31, 2008 at 08:22:13PM +0900, Magnus Damm wrote:
> Add clock framework support to the usbf/m66592 driver and
> adjust the cpu specific code accordingly.

On Fri, Oct 31, 2008 at 08:22:38PM +0900, Magnus Damm wrote:
> Add clock framework support to the usb/r8a66597 driver and
> adjust the cpu specific code accordingly.

On Fri, Oct 31, 2008 at 08:23:26PM +0900, Magnus Damm wrote:
> Add clock framework support to the lcdc driver and
> adjust the board specific code accordingly.

On Fri, Oct 31, 2008 at 08:24:01PM +0900, Magnus Damm wrote:
> Remove the old sh_mobile mstpcr clocks.

All applied, thanks.
