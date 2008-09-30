From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 30 Sep 2008 11:50:16 +0000
Subject: Re: [UBoot] Hows to boot Linux Kernel from USB
Message-Id: <20080930115016.GA11774@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <loom.20080930T111336-805@post.gmane.org>
In-Reply-To: <loom.20080930T111336-805@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 30, 2008 at 11:30:09AM +0000, thaoth wrote:
> => usb start
> 
> - List file on USB Flash memory
> 
> => fatls usb 0:1
>   3876248   vmlinux.srec
>   1348231   vmlinux
>   2207942   vmlinux.bin
> .
>   1277956   zimage
> 
> - load zImage into SDRAM memory at base address 0x8c000000 + 200000 
> 
> => fatload usb 0:1 200000 zimage
> reading zimage
> .
> .
> .
> .
> ......................................................
> ..........................
> ............................................
> 
> 1277956 bytes read
> 
> => bootm
> Wrong Image Format for bootm command
> ERROR: can't get kernel image!
> 
> This seems here is wrong command. I should load uImage (not zImage) 
> into SDRAM
> memory. Google booting kernel from USB on the internet but I 
> didn't see any help. :(
> 
You can certainly boot the zImage from SDRAM. Once it's loaded, you can
just 'go <load address>' and hit the decompressor. The uImage tends to be
handier in that it has more information on hand, but there is nothing
stopping you from using other formats.
