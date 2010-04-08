From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 08 Apr 2010 14:18:02 +0000
Subject: Re: SDK7786 zImage difficulities
Message-Id: <20100408141801.GA2263@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <0C997DD87CC88A4F86C897F52650B52B0299816A@MOLSON.mpc-data.co.uk>
In-Reply-To: <0C997DD87CC88A4F86C897F52650B52B0299816A@MOLSON.mpc-data.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 08, 2010 at 02:40:48PM +0100, Andrew Murray wrote:
> I've been unable to successfully use a zImage when using the defconfig
> for the SDK7786 (head ...2fe3fe Apr 7).
> 
> When loading the zImage though a debugger to 0x60000000 and executing
> from 0x60000000 (after allowing the ETS firmware to run to prompt) the
> decompressor head relocates itself and jumps to 0x80800058 - however I
> thought this was somewhere in the PCI space. This then results in a
> general instruction exception which seems to be handled by the ETS:
> 
> **** Unhandled interrupt! - Exception registers: ****
> TRAPA : 0x0
> EXPEVT: 0x180
> INTEVT: 0x420
> 
> Has anyone successfully used a zImage on this board - or could it be
> broken in some way? I'm nearing my depth here so will be more than happy
> for assistance.

The ETS firmware will only work with vmlinux.bin's at the moment, not
zImages. vmlinux.bin is the default target for SDK7786, so simply not
specifying a build target will result in the proper image being
generated.
