From: morimoto.kuninori@renesas.com
Date: Mon, 08 Dec 2008 07:53:53 +0000
Subject: Re: [Bug report] dead lock is occur in mutex_trylock
Message-Id: <ud4g3yuem.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uej0jyw3m.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uej0jyw3m.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> > It works well if I use old ${LINUX}/arch/sh/include/asm/mutex-llsc.h,
> > But, latest mutex-llsc.h seems cause dead lock on __mutex_fastpath_trylock.
> > 
> > It confirmed on AP325 board.
> > 
> Do you have a test case that can reproduce this?

I'm using latest linux-sh git and normal AP325 defconfig.
you can get dead lock when kernel starts MTD setting.

like this
----------------
(snip)
Driver 'sd' needs updating - please use bus_type methods                        
physmap platform flash device: 01000000 at 00000000                             
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank                      
NOR chip too large to fit in mapping. Attempting to cope...                     
 Amd/Fujitsu Extended Query Table at 0x0040                                     
physmap-flash.0: CFI does not contain boot bank location. Assuming top.         
number of CFI chips: 1                                                          
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.        
Reducing visibility of 32768KiB chip to 16384KiB                                
RedBoot partition parsing not available                                         
Using physmap partition information                                             
Creating 5 MTD partitions on "physmap-flash.0":                                 
0x00000000-0x00100000 : "uboot"                                                 
0x00100000-0x00300000 : "kernel"                                                
                                         <= *** dead lock ***
----------------
