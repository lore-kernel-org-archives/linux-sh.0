From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 04 Aug 2009 05:44:22 +0000
Subject: Re: [PATCH] sh: romImage support V2
Message-Id: <20090804054421.GB21171@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 30, 2009 at 12:04:05AM +0900, Magnus Damm wrote:
> This patch contains support for the romImage build target V2.
> 
> The resulting romImage file should be burned to rom
> or flash and could be used as small boot loader.
> 
> Board code should keep their setup code in the file
> romimage.h located in their mach include directory.

On Thu, Jul 30, 2009 at 12:06:15AM +0900, Magnus Damm wrote:
> This patch is romImage support for the kfr2r09 board V2.
> 
> The partner-jet-setup.txt file is converted into assembly code
> which becomes the first code to execute from the reset vector.
> 
> The file partner-jet-setup.txt can also be used to setup
> the hardware using a JTAG debugger so booting from RAM can
> be done without burning the code to flash.

On Fri, Jul 31, 2009 at 03:57:36PM +0900, Magnus Damm wrote:
> This patch adds hwblk support for the sh7724 processor.

On Fri, Jul 31, 2009 at 04:01:36PM +0900, Magnus Damm wrote:
> This patch removes the unused MSTPCRn register definitions
> from the SuperH Mobile code for sh7722, sh7723 and sh7724.

These are all applied.
