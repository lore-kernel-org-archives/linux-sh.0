From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 13 Aug 2019 08:51:26 +0000
Subject: Re: [PATCH 05/16] sh: prefer __section from compiler_attributes.h
Message-Id: <875zn1phwx.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20190812215052.71840-1-ndesaulniers@google.com>
        <20190812215052.71840-5-ndesaulniers@google.com>
In-Reply-To: <20190812215052.71840-5-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: akpm@linux-foundation.org, sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com, miguel.ojeda.sandonis@gmail.com, clang-built-linux@googlegroups.com, Rich Felker <dalias@libc.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

On Tue, 13 Aug 2019 06:50:38 +0900,
Nick Desaulniers wrote:
> 
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/sh/include/asm/cache.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/include/asm/cache.h b/arch/sh/include/asm/cache.h
> index 2408ac4873aa..07ddf31124a3 100644
> --- a/arch/sh/include/asm/cache.h
> +++ b/arch/sh/include/asm/cache.h
> @@ -15,7 +15,7 @@
>  
>  #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
>  
> -#define __read_mostly __attribute__((__section__(".data..read_mostly")))
> +#define __read_mostly __section(.data..read_mostly)
>  
>  #ifndef __ASSEMBLY__
>  struct cache_info {
> -- 
> 2.23.0.rc1.153.gdeed80330f-goog
> 

Applied sh-next.
Thanks.

-- 
Yosinori Sato
