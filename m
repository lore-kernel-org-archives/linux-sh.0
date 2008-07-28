From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jul 2008 20:44:38 +0000
Subject: Re: drivers/sh/maple/maple.c compile error
Message-Id: <20080728204438.GC20019@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080728202012.GD7713@cs181140183.pp.htv.fi>
In-Reply-To: <20080728202012.GD7713@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 28, 2008 at 11:20:12PM +0300, Adrian Bunk wrote:
> Commit 306cfd630a4d121cf4e08b894d8b4c4cf106e57e
> (maple: tidy maple_driver code by removing redundant connect/disconnect)
> causes the following compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/sh/maple/maple.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/sh/maple/maple.c: In function 'attach_matching_maple_driver':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/sh/maple/maple.c:259: error: 'struct maple_driver' has no member named 'connect'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/sh/maple/maple.c: In function 'maple_detach_driver':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/sh/maple/maple.c:272: error: 'struct maple_driver' has no member named 'disconnect'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/sh/maple/maple.c:273: error: 'struct maple_driver' has no member named 'disconnect'
> make[4]: *** [drivers/sh/maple/maple.o] Error 1
> 
> <--  snip  -->
> 
Adrian was supposed to send follow-up patches for this, which never
happened. I thought I had dropped this already, but in this case I'll
just revert it.
