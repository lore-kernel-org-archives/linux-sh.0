From: Andrea Baldini <andrea.baldini@spesonline.com>
Date: Thu, 24 Nov 2011 09:43:41 +0000
Subject: Re: SH2a Write-back cache issue
Message-Id: <201111241043.41988.andrea.baldini@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201111221415.22367.andrea.baldini@spesonline.com>
In-Reply-To: <201111221415.22367.andrea.baldini@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> In our setup, the problem seems related to an LCD flickering, when the
> cache is setup in read-back mode we had an heavy flickering on the LCD,
> when in write-through it seems much less present, even though not
> completely absent. We tried many different setup for cache and DRAM, but
> found no solutions for it. Of course the problem is present in 2.6.17,
> 2.6.37-38, 3.0 and 3.1 kernels. We found just one situation where the
> flickering is nearly invisible, while reserving 2Mb of frame buffer - so
> placing the fb and the other kernel/code memory far each other. What is
> your problem and setup?
> 
> Federico

Hi Federico,

Currently I'm working with a framebuffer on my custom board but the problem I 
described occurs in a basic setup too (without frambuffer support and other not  
essential stuff).

I found this problem when I was working with the Renesas demo board rsk7203.
I tried some kernels compiled with the board defconfig and a busybox built with 
a basic configuration (using a toolchain which creates flat binaries).

With this setup I found that the timer interrupts were missed when executing 
the busybox applets and it was very clear especially in shell loop scripts.
With some debug work I saw that the problem was located in the function i 
mentioned in the first mail, that is flush_icache_range (you can find it in 
cache-sh2a.c) which caused interrupts to be missed during its execution.

The flush_icache_range is called in some points of the kernel and one of them 
is in the load_flat_file() which, in my case, is heavy used (having a flat 
busybox).

Hope this helps to better understand the issue.

Andrea

-- 
Andrea Baldini

Elettronica di Processo

 

SPES. S.c.p.a
Via  Lamberto Corsi, 43
60044 Fabriano (AN)
tel. +39 0732 25291
fax +39 0732 2529441

 <mailto:andrea.baldini@spesonline.com> andrea.baldini@spesonline.com

 <http://www.spesonline.com> www.spesonline.com
