From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 30 May 2019 10:50:40 +0000
Subject: Re: [PATCH] x86,sh: use __builtin_constant_p() directly instead of IS_IMMEDIATE()
Message-Id: <CAK7LNATKCRqcDWg4X_e2N3TuxTmfr34ZYJOJU=SbubE-+S4eTQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1556887064-12882-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1556887064-12882-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: X86 ML <x86@kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Andrew,

On Fri, May 3, 2019 at 9:48 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> __builtin_constant_p(nr) is used everywhere now. It does not make
> much sense to define IS_IMMEDIATE() as its alias.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Ping. Is this a good clean-up?

Thanks.

> ---
>
>  arch/sh/include/asm/bitops-op32.h | 8 +++-----
>  arch/x86/include/asm/bitops.h     | 7 +++----
>  2 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/arch/sh/include/asm/bitops-op32.h b/arch/sh/include/asm/bitops-op32.h
> index 4668803..cfe5465 100644
> --- a/arch/sh/include/asm/bitops-op32.h
> +++ b/arch/sh/include/asm/bitops-op32.h
> @@ -16,11 +16,9 @@
>  #define BYTE_OFFSET(nr)                ((nr) % BITS_PER_BYTE)
>  #endif
>
> -#define IS_IMMEDIATE(nr)       (__builtin_constant_p(nr))
> -
>  static inline void __set_bit(int nr, volatile unsigned long *addr)
>  {
> -       if (IS_IMMEDIATE(nr)) {
> +       if (__builtin_constant_p(nr)) {
>                 __asm__ __volatile__ (
>                         "bset.b %1, @(%O2,%0)           ! __set_bit\n\t"
>                         : "+r" (addr)
> @@ -37,7 +35,7 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
>
>  static inline void __clear_bit(int nr, volatile unsigned long *addr)
>  {
> -       if (IS_IMMEDIATE(nr)) {
> +       if (__builtin_constant_p(nr)) {
>                 __asm__ __volatile__ (
>                         "bclr.b %1, @(%O2,%0)           ! __clear_bit\n\t"
>                         : "+r" (addr)
> @@ -64,7 +62,7 @@ static inline void __clear_bit(int nr, volatile unsigned long *addr)
>   */
>  static inline void __change_bit(int nr, volatile unsigned long *addr)
>  {
> -       if (IS_IMMEDIATE(nr)) {
> +       if (__builtin_constant_p(nr)) {
>                 __asm__ __volatile__ (
>                         "bxor.b %1, @(%O2,%0)           ! __change_bit\n\t"
>                         : "+r" (addr)
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 8e790ec..2621438 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -45,7 +45,6 @@
>   * We do the locked ops that don't return the old value as
>   * a mask operation on a byte.
>   */
> -#define IS_IMMEDIATE(nr)               (__builtin_constant_p(nr))
>  #define CONST_MASK_ADDR(nr, addr)      WBYTE_ADDR((void *)(addr) + ((nr)>>3))
>  #define CONST_MASK(nr)                 (1 << ((nr) & 7))
>
> @@ -67,7 +66,7 @@
>  static __always_inline void
>  set_bit(long nr, volatile unsigned long *addr)
>  {
> -       if (IS_IMMEDIATE(nr)) {
> +       if (__builtin_constant_p(nr)) {
>                 asm volatile(LOCK_PREFIX "orb %1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
>                         : "iq" ((u8)CONST_MASK(nr))
> @@ -105,7 +104,7 @@ static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
>  static __always_inline void
>  clear_bit(long nr, volatile unsigned long *addr)
>  {
> -       if (IS_IMMEDIATE(nr)) {
> +       if (__builtin_constant_p(nr)) {
>                 asm volatile(LOCK_PREFIX "andb %1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
>                         : "iq" ((u8)~CONST_MASK(nr)));
> @@ -186,7 +185,7 @@ static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
>   */
>  static __always_inline void change_bit(long nr, volatile unsigned long *addr)
>  {
> -       if (IS_IMMEDIATE(nr)) {
> +       if (__builtin_constant_p(nr)) {
>                 asm volatile(LOCK_PREFIX "xorb %1,%0"
>                         : CONST_MASK_ADDR(nr, addr)
>                         : "iq" ((u8)CONST_MASK(nr)));
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
