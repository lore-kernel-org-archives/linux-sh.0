From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Dec 2009 03:37:43 +0000
Subject: Re: [PATCH] sh-sci: Extend sh-sci driver with early console V2
Message-Id: <20091215033743.GB7395@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 14, 2009 at 07:24:42PM +0900, Magnus Damm wrote:
> This is V2 of early serial console support for the sh-sci
> driver. The early serial console is using early platform
> devices and "earlyprintk". To use this feature the early
> platform devices must be broken out to one device per port
> and the desired port should be selected on the kernel command
> line like: "earlyprintk=sh-sci.N[,baudrate][,keep]"

On Mon, Dec 14, 2009 at 09:29:40PM +0900, Magnus Damm wrote:
> These patches break out the scif serial port platform data into
> one platform device per port.
> 
> With these patches and the early serial support in place it is
> possible to select the early serial console port with the kernel
> command line. For example, to enable early serial console on KFR2R09,
> simply add the following to the kernel command line:
> 
> "earlyprintk=sh-sci.1,115200".

On Mon, Dec 14, 2009 at 09:52:53PM +0900, Magnus Damm wrote:
> Now when the sh-sci driver can do early serial output,
> get rid of the old duplicated code. This patch is V2 and
> removes support for "earlyprintk=serial" together with
> the following kconfig options:
> CONFIG_EARLY_SCIF_CONSOLE
> CONFIG_EARLY_SCIF_CONSOLE_PORT
> CONFIG_EARLY_PRINTK
> 
> With this patch applied "earlyprintk=" support is always
> built-in the SuperH kernel. For this to work the serial
> driver must have early platform support and in the case
> of sh-sci the serial console needs to be enabled:
> CONFIG_SERIAL_SH_SCI_CONSOLE=y
> 
> So after enabling the SuperH SCI console kconfig option
> you also need to point out port using the kernel command
> line: "earlyprintk=sh-sci.N[,baudrate][,keep]"
> 
> Remember that clocks may be disabled by the boot loader
> so you may have to do some board specific static clock 
> setup before earlyprintk will work on your platform.

Applied, thanks.
