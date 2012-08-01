From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 01 Aug 2012 05:04:48 +0000
Subject: Re: bug report: ecovec boot got WARNING
Message-Id: <20120801050447.GC15380@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <878vdze039.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878vdze039.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 31, 2012 at 08:57:02PM -0700, kuninori.morimoto.gx@renesas.com wrote:
> gpio: sh7724_pfc handling gpio 0 -> 486
> core: sh7724_pfc support registered
> HW Breakpoints: SH-4A UBC support registered
> autorequest GPIO-53
> ------------[ cut here ]------------
> WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/drivers/gpio/gpiolib.3
> Modules linked in:
> 
> Pid : 1, Comm:          swapper
> CPU : 0                 Not tainted  (3.5.0-rc6+ #1407)
> 
> PC is at gpio_ensure_requested+0x30/0x78
> PR is at gpio_ensure_requested+0x30/0x78
> PC  : 8814d1d0 SP  : 8f029f0c SR  : 400080f1 TEA : 00000000
> R0  : 00000013 R1  : 000000f0 R2  : 00000000 R3  : 882a5a98
> R4  : 000000f0 R5  : 00000001 R6  : 88013cea R7  : 00000000
> R8  : 88806690 R9  : 8f0151a4 R10 : 00000035 R11 : 00000035
> R12 : 00000000 R13 : 00000000 R14 : 8f029f0c
> MACH: 00000000 MACL: 000000a0 GBR : 00000000 PR  : 8814d1d0
> 
> Call trace:
> [<8814d420>] gpio_direction_output+0x8c/0x110
> [<8840010c>] arch_setup+0x60/0x7c4
> [<8814d394>] gpio_direction_output+0x0/0x110
> [<8814d810>] gpio_request+0x0/0xdc
> [<880022b4>] do_one_initcall+0x18c/0x244
> [<884000ac>] arch_setup+0x0/0x7c4
> [<883fd8fa>] kernel_init+0xae/0x1a8
> [<88003978>] kernel_thread_helper+0x8/0x14
> [<883fd84c>] kernel_init+0x0/0x1a8
> [<88003970>] kernel_thread_helper+0x0/0x14
> 
> 1 lock held by swapper/1:
> #0:  (gpio_lock){......}, at: [<8814d3e2>] gpio_direction_output+0x4e/0x110

This looks like the gpio_request() failed and the sanity check in
gpio_direction_output() triggered.

Can you attach your .config and a boot log with both gpiolib and pinctrl
debugging enabled?

I don't seem to have an ecovec board lying around, so if that doesn't
provide any helpful clues, you can put the board on my desk when you're
done with it and I'll track it down. I'll see if I can reproduce
something similar on the 7724 solution engine in the meantime.
