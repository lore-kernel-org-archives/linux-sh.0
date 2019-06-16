From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 16 Jun 2019 10:05:07 +0000
Subject: Re: Linux SH kernel currently broken on qemu-system
Message-Id: <a7d72eff-554d-4d9a-5155-89dad2a5d134@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <e7855beb-fbf6-8f67-140f-21820a0fe4af@physik.fu-berlin.de>
In-Reply-To: <e7855beb-fbf6-8f67-140f-21820a0fe4af@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 6/16/19 11:38 AM, Rob Landley wrote:
> I booted 5.1 to a shell prompt when it came out and you're pointing at a commit
> from 2017? Sigh, let's see...
> 
> Nope, I just built current git -master (commit e01e060fe00d) and it booted just
> fine. (Well, the stupid ___slab_alloc.constprop stack dump it's been doing
> forever but I've complained about that here before. I get the shell prompt anyway.)

This has already been tracked down. It's kprobes that's broken [1] 

> Could you attach your .config? Here's the one I built, and how I'm launching it.

You need to enable kernel probes which are enabled in Debian by default.

> Hmmm... I checked my notes on the sh7760 hardware and the newest kernel I ran on
> that (with dma working, memory to memory with dmaengine and the dmatest plumbing
> passed) 4.14, which is just older than  your commit. (But I didn't stop moving
> the version forward because of a DMA issue, I stopped because jffs2 on the NOR
> flash went flaky in a way that took 10 minutes of hammering to reliably
> reproduce and was thus a pain to bisect, and we had a ship deadline, so I stayed
> with the last stable one which was less than a year old at the time...)

The second issue we had was with the resulting kernel being larger than 8 MiB
which is not supported by QEMU. So, we have to move drivers out of the kernel
into modules.

Adrian

> [1] https://marc.info/?l=linux-sh&m6034655921917&w=2

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
