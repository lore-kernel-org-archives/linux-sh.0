From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jul 2008 20:42:36 +0000
Subject: Re: [2.6 patch] SH_AP325RXA must select I2C
Message-Id: <20080728204236.GB20019@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <20080728201705.GC7713@cs181140183.pp.htv.fi>
References: <20080728201705.GC7713@cs181140183.pp.htv.fi>
In-Reply-To: <20080728201705.GC7713@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: Yusuke Goda <goda.yusuke@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 28, 2008 at 11:17:05PM +0300, Adrian Bunk wrote:
> This patch fixes the following build error:
> 
> <--  snip  -->
> 
> ...
>   LD      vmlinux
> arch/sh/boards/renesas/ap325rxa/built-in.o: In function `camera_set_capture':
> setup.c:(.text+0x80): undefined reference to `i2c_get_adapter'
> setup.c:(.text+0x88): undefined reference to `i2c_transfer'
> make[1]: *** [vmlinux] Error 1
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
The camera stuff should probably just be conditionalized in the platform
code instead.. Magnus, can you sort out the proper dependencies for this?
