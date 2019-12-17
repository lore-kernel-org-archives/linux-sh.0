From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 17 Dec 2019 10:18:57 +0000
Subject: Re: [PATCH] SH: Convert ins[bwl]/outs[bwl] macros to inline functions
Message-Id: <1cbfc481-ed50-64fa-ff29-c99eb434562c@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d0cnh2eb.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d0cnh2eb.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello!

On 17.12.2019 9:50, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Macro ins[bwl]/outs[bwl] are just calling BUG(), but that results in
> unused variable warnings all over the place.
> This patch convert macro to inline to avoid warning
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/sh/include/asm/io_noioport.h | 34 ++++++++++++++++++++++++++++------
>   1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sh/include/asm/io_noioport.h b/arch/sh/include/asm/io_noioport.h
> index 90d6109..d39a1a8 100644
> --- a/arch/sh/include/asm/io_noioport.h
> +++ b/arch/sh/include/asm/io_noioport.h
> @@ -53,12 +53,34 @@ static inline void ioport_unmap(void __iomem *addr)
>   #define outw_p(x, addr)	outw((x), (addr))
>   #define outl_p(x, addr)	outl((x), (addr))
>   
> -#define insb(a, b, c)	BUG()
> -#define insw(a, b, c)	BUG()
> -#define insl(a, b, c)	BUG()
> +static inline void insb (unsigned long port, void *dst, unsigned long count)

    Why this space after the function name? I don't think scripts/checkpatch.pl
is happy about it...

[...]

MBR, Sergei
