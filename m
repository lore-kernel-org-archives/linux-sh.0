From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Aug 2014 16:22:02 +0000
Subject: Re: [PATCH v2] flush_icache_range: Export symbol to fix build errors
Message-Id: <CAMo8BfKshP0KT=D8dWzDfbGSfEpd_SeQPRboGGN9b8B4btRBtQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1408377559-30775-1-git-send-email-bobby.prani@gmail.com>
In-Reply-To: <1408377559-30775-1-git-send-email-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Vineet Gupta <vgupta@synopsys.com>, Richard Kuo <rkuo@codeaurora.org>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>, Noam Camus <noamc@ezchip.com>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tony Lu <zlu@tilera.com>, Kirill Tkhai <tkhai@yandex.ru>, open list <linux-kernel@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:TENSILICA XTENSA..." <linux-xtensa@linux-xtensa.org>

On Mon, Aug 18, 2014 at 7:59 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> Fix building errors occuring due to a missing export of flush_icache_range() in
>
> kisskb.ellerman.id.au/kisskb/buildresult/11677809/
>
> ERROR: "flush_icache_range" [drivers/misc/lkdtm.ko] undefined!
>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: Andrew Morton <akpm@linux-foundation.org>
> ---
>  arch/arc/mm/cache_arc700.c | 1 +
>  arch/hexagon/mm/cache.c    | 1 +
>  arch/sh/mm/cache.c         | 1 +
>  arch/tile/kernel/smp.c     | 1 +
>  arch/xtensa/kernel/smp.c   | 1 +
>  5 files changed, 5 insertions(+)

For xtensa
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
