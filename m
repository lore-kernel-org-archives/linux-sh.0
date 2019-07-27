From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat, 27 Jul 2019 13:46:43 +0000
Subject: Re: [PATCH] sh: use __builtin_constant_p() directly instead of IS_IMMEDIATE()
Message-Id: <87pnlvpp30.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20190723074943.17093-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190723074943.17093-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 16:49:43 +0900,
Masahiro Yamada wrote:
> 
> __builtin_constant_p(nr) is used everywhere now. It does not make
> much sense to define IS_IMMEDIATE() as its alias.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/sh/include/asm/bitops-op32.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/sh/include/asm/bitops-op32.h b/arch/sh/include/asm/bitops-op32.h
> index 466880362ad1..cfe5465acce7 100644
> --- a/arch/sh/include/asm/bitops-op32.h
> +++ b/arch/sh/include/asm/bitops-op32.h
> @@ -16,11 +16,9 @@
>  #define BYTE_OFFSET(nr)		((nr) % BITS_PER_BYTE)
>  #endif
>  
> -#define IS_IMMEDIATE(nr)	(__builtin_constant_p(nr))
> -
>  static inline void __set_bit(int nr, volatile unsigned long *addr)
>  {
> -	if (IS_IMMEDIATE(nr)) {
> +	if (__builtin_constant_p(nr)) {
>  		__asm__ __volatile__ (
>  			"bset.b %1, @(%O2,%0)		! __set_bit\n\t"
>  			: "+r" (addr)
> @@ -37,7 +35,7 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
>  
>  static inline void __clear_bit(int nr, volatile unsigned long *addr)
>  {
> -	if (IS_IMMEDIATE(nr)) {
> +	if (__builtin_constant_p(nr)) {
>  		__asm__ __volatile__ (
>  			"bclr.b %1, @(%O2,%0)		! __clear_bit\n\t"
>  			: "+r" (addr)
> @@ -64,7 +62,7 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
>   */
>  static inline void __change_bit(int nr, volatile unsigned long *addr)
>  {
> -	if (IS_IMMEDIATE(nr)) {
> +	if (__builtin_constant_p(nr)) {
>  		__asm__ __volatile__ (
>  			"bxor.b %1, @(%O2,%0)		! __change_bit\n\t"
>  			: "+r" (addr)
> -- 
> 2.17.1
> 

Applied sh-next.
Thanks.

-- 
Yosinori Sato
