From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 25 Aug 2008 06:27:34 +0000
Subject: Re: [2.6 patch] sh64: re-add the __strnlen_user() prototype
Message-Id: <20080825062734.GA19834@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080822152029.GA26762@cs181140183.pp.htv.fi>
In-Reply-To: <20080822152029.GA26762@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 22, 2008 at 06:20:29PM +0300, Adrian Bunk wrote:
> Commit 42fd3b142d8867f5b58d6fb75592cd20fd654c1b
> (sh: Initial consolidation of the _32/_64 uaccess split.)
> mistakenly removed the sh64 __strnlen_user() prototype,
> resulting in the following compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      init/main.o
> In file included from include/linux/poll.h:13,
>                  from include/linux/rtc.h:113,
>                  from include/linux/efi.h:19,
>                  from init/main.c:43:
> arch/sh/include/asm/uaccess.h: In function 'strnlen_user':
> arch/sh/include/asm/uaccess.h:213: error: implicit declaration of function '__strnlen_user'
> ...
> make[2]: *** [init/main.o] Error 1
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
Applied, thanks.
