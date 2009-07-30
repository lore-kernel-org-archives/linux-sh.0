From: Rafael Ignacio Zurita <rizurita@yahoo.com>
Date: Thu, 30 Jul 2009 01:11:45 +0000
Subject: Re: Problem with current kernel and old sh3 machines
Message-Id: <20090730011145.GA10521@rafazurita.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <aec7e5c30907232030pf8d5e92h1ae9d73d5a5e8e44@mail.gmail.com>
In-Reply-To: <aec7e5c30907232030pf8d5e92h1ae9d73d5a5e8e44@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus!

On Mon, Jul 27, 2009 at 11:40:18AM +0900, Magnus Damm wrote:
> 
> On Fri, Jul 24, 2009 at 11:49 PM, Rafael Ignacio
> Zurita<rizurita@yahoo.com> wrote:
> > On Fri, Jul 24, 2009 at 12:30:06PM +0900, Magnus Damm wrote:
> >> Sorry about the delay. If you still have time, please let me know
> >> which hardware platform you want to focus on.
> >
> > No problem. I want to get early printk in sh3 sh7709 (sh770x) + hd64461
> > cchip, because I would like to work/test with both: Jornada 680 and Palmtop
> > 660lx.
> 
> Step 1: Figure out which serial port to use.
> 
> First of all I need to know which serial port that is being used on
> your hardware platform(s). In most cases there's a
> "console=ttySCX,115200" in CONFIG_CMDLINE for the board defconfig (X
> is used to point out the serial port), but the file hp6xx_defconfig
> does not have CONFIG_CMDLINE_BOOL set so CONFIG_CMDLINE happens to be
> empty.
> 
> So please figure out which serial port(s) that are used by your
> hardware platform(s). sh7709 has 3 serial ports, your job is to figure
> out which port your board(s) are using.
> 
> The easiest way to do so is to read some hardware specs, and if you
> can't find any then just look at /proc/interrupts on a working kernel
> and compare the IRQ number for the serial port with the IRQ numbers in
> sci_platform_data[] in your cpu setup file (setup-sh770x.c in this
> case). What we want to get is the .mapbase value for the serial port
> we should use for early printk.
> 
> Please do this for both hardware platforms and email the .mapbase
> values to the list.

The serial port being used on the hardware is ttySC1. The hardware
specs and setup-sh770x.c show the .mapbase value 0xa4000150.
 
> > I tried to patch arch/sh/kernel/cpu/sh3/setup-sh770x.c
> > like you did with sh772 in http://patchwork.kernel.org/patch/23714/ ,
> > but when I try to boot with "earlyprintk=sh-sci.0" or "earlyprintk=sh-sci.1"
> > the machine resets after a while without serial output.
> 
> Aha, thanks for trying that out. That code was my attempt to unify the
> early printk code with the serial driver. We're not 100% there yet. =)
> I think the in-tree version of early prink should be enough for our
> needs at this point though.
> 
> Step 2: Get early prink working on an old known working kernel.
> 
> When you know the result from Step 1 then edit
> arch/sh/kernel/early_printk.c and change both instances of
> CONFIG_EARLY_SCIF_CONSOLE_PORT to the .mapbase value. You may also
> need to change scif_port.type depending on if your port is a SCI, SCIF
> or SCIFA.
> 
> Then edit your kernel config and make sure your command line includes
> "earlyprintk=serial".
> 
> Look at the defconfig for migor_defconfig - both wrt CONFIG_CMDLINE
> and early printk config options - CONFIG_EARLY_SCIF_CONSOLE=y +
> CONFIG_EARLY_PRINTK=y.
> 
> That should be it! Depending on your boot loader you may also need to
> comment out code in early_printk.c.

After some tests, I get early printk working on an old known working kernel
with the patch below :

diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 9412d91..9334bad 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -247,6 +247,8 @@ static struct platform_device *sh770x_devices[] __initdata = {
 
 static int __init sh770x_devices_setup(void)
 {
+	for(;;)
+		printk("infinite loop to test early printk\n");
 	return platform_add_devices(sh770x_devices,
 		ARRAY_SIZE(sh770x_devices));
 }
diff --git a/arch/sh/kernel/early_printk.c b/arch/sh/kernel/early_printk.c
index a952dcf..e08e86e 100644
--- a/arch/sh/kernel/early_printk.c
+++ b/arch/sh/kernel/early_printk.c
@@ -76,8 +76,8 @@ static struct console bios_console = {
 
 static struct uart_port scif_port = {
 	.type		= PORT_SCIF,
-	.mapbase	= CONFIG_EARLY_SCIF_CONSOLE_PORT,
-	.membase	= (char __iomem *)CONFIG_EARLY_SCIF_CONSOLE_PORT,
+	.mapbase	= 0xa4000150,
+	.membase	= (char __iomem *)0xa4000150,
 };
 
 static void scif_sercon_putc(int c)
@@ -134,7 +134,7 @@ static void scif_sercon_init(char *s)
 	sci_out(&scif_port, SCFCR, 0x0030);	/* TTRG=b'11 */
 	sci_out(&scif_port, SCSCR, 0x0030);	/* TE, RE */
 }
-#elif defined(CONFIG_CPU_SH4)
+#elif defined(CONFIG_CPU_SH4) || defined(CONFIG_CPU_SH3)
 #define DEFAULT_BAUD 115200
 /*
  * Simple SCIF init, primarily aimed at SH7750 and other similar SH-4
@@ -221,7 +221,7 @@ static int __init setup_early_printk(char *buf)
 
 #if !defined(CONFIG_SH_STANDARD_BIOS)
 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7721)
+    defined(CONFIG_CPU_SUBTYPE_SH7721) || defined(CONFIG_CPU_SH3)
 		scif_sercon_init(buf + 6);
 #endif
 #endif


> Step 3: Test the early printk code on the old kernel.
> 
> Add a BUG() or panic() or printk() with an endless loop somewhere
> early. Inside sh770x_devices_setup() may be a good place. Hanging the
> kernel there should be early enough for not getting any output without
> early printk, but will give you output when early printk is enabled.
> 
> You probably want to boot the kernel without mouting any root
> partition to avoid checking disks if you need to boot many times....

I have not gotten output from the for(;;) printk();
(in sh770x_devices_setup(void)). When system boots, minicom shows:

Linux version 2.6.30-rc4-hpc (r                        9
Boot params:                                                                    
.... MOUNT_ROOT_RDONLY - 00000000                                                
.... RAMDISK_FLAGS     - 00000000                                                
.... ORIG_ROOT_DEV     - 00000100                                                
.... LOADER_TYPE       - 00000001                                                
.... INITRD_START      - 00400000                                                
.... INITRD_SIZE       - 00400000                                                
console [sercon0] enabled                                                       
Booting machvec: hp6xx                                                          
Node 0: start_pfn = 0xd000, low = 0xe000                                        
Zone PFN ranges:                                                                
  Normal   0x0000d000 -> 0x0000e000                                             
Movable zone start PFN for each node                                            
early_node_map[1] active PFN ranges                                             
    0: 0x0000d000 -> 0x0000e000                                                 
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064      
Kernel command line: memM init=/bin/sh earlyprintk=serial                    
NR_IRQS:256                                                                     
PID hash table entries: 64 (order: 6, 256 bytes)                                
Console: colour dummy device 80x25                                              
console handover: boot [sercon0] -> real [tty0]        

and I guess that the system hangs. 
Should I try other printks in other places? Suggestions?

> Step 4: Get early printk working on the broken kernel
> 
> This should be farily easy if you've managed to get Step 2 + 3 working. =)

Working on that :-)

Thanks a lot for the big help!!, I will continue testing/working on this.

Rafael
