From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 03 Aug 2008 02:23:14 +0000
Subject: Re: [2.6 patch] sh/boards/Makefile typo fix
Message-Id: <20080803022313.GA15509@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080802165344.GP19682@cs181140183.pp.htv.fi>
In-Reply-To: <20080802165344.GP19682@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 02, 2008 at 07:53:44PM +0300, Adrian Bunk wrote:
> The following build error was caused by an obvious typo:
> 
> <--  snip  -->
> 
> ...
>   LD      arch/sh/mm/built-in.o
> make[2]: *** No rule to make target `arch/sh/boards/board-shmin..o', needed by `arch/sh/boards/built-in.o'.  Stop.
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
Applied, thanks.
