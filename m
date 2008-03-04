From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 04 Mar 2008 06:26:18 +0000
Subject: Re: [2.6 patch] sh/mm/pg-sh7705.c must #include <linux/fs.h>
Message-Id: <20080304062618.GA29174@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080303180742.GJ26072@cs181133002.pp.htv.fi>
In-Reply-To: <20080303180742.GJ26072@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <adrian.bunk@movial.fi>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 03, 2008 at 08:07:42PM +0200, Adrian Bunk wrote:
> This patch fixes the following compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      arch/sh/mm/pg-sh7705.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/mm/pg-sh7705.c: In function 'ptep_get_and_clear':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/mm/pg-sh7705.c:130: error: implicit declaration of function 'mapping_writably_mapped'
> make[2]: *** [arch/sh/mm/pg-sh7705.o] Error 1
> 
> <--  snip  -->
> 
> Signed-off-by: Adrian Bunk <adrian.bunk@movial.fi>
> 
Applied, thanks.
