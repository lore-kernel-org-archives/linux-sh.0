From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Tue, 10 Dec 2019 08:47:56 +0000
Subject: Re: [PATCH] sh: kgdb: Mark expected switch fall-throughs
Message-Id: <1009e85d-882a-d43b-8936-a0b4de596aa3@c-s.fr>
List-Id: <linux-sh.vger.kernel.org>
References: <87o8wgy3ra.wl-kuninori.morimoto.gx@renesas.com>
 <87muc0y3q4.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87muc0y3q4.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Daniel Thompson <daniel.thompson@linaro.org>, Will Deacon <will@kernel.org>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, "stable@vger.kernel.org" <stable@vger.kernel.org>



On 12/10/2019 08:39 AM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following error:
> 
> LINUX/arch/sh/kernel/kgdb.c: In function 'kgdb_arch_handle_exception':
> LINUX/arch/sh/kernel/kgdb.c:267:6: error: this statement may fall through [-Werror=implicit-fallthrough=]
> if (kgdb_hex2long(&ptr, &addr))
> ^
> LINUX/arch/sh/kernel/kgdb.c:269:2: note: here
> case 'D':
> ^~~~
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

I guess you should also add:

Fixes: ab6e570ba33d ("sh: Generic kgdb stub support.")
Cc: stable@vger.kernel.org

Christophe
