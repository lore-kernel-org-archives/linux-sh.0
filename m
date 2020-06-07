From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 07 Jun 2020 12:36:27 +0000
Subject: Re: [PATCH v3] sh: fix inline asm strncpy()
Message-Id: <a1afad68-e921-36a7-edf9-11cc23a3a222@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20191219031914.20457-1-knnspeed@aol.com>
In-Reply-To: <20191219031914.20457-1-knnspeed@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich!

I just noticed this patch that got posted without any reply.

Should we consider this patch?

Adrian

On 12/19/19 4:19 AM, Karl Nasrallah wrote:
> The SH asm strncpy() implementation does not pad arrays with null bytes
> when the size passed in is larger than than the size of the input string
> (e.g. if the size of a larger destination array is passed in). Under
> certain targets, it also generates 'array boundary exceeded' warnings.
> This patch updates the extended asm function to address both of those
> issues, and allows strncpy() to behave as described by the strncpy()
> manual page.
> 
> Signed-off-by: Karl Nasrallah <knnspeed@aol.com>
> ---
> 
> Please note: This is an improved version of my prior code, tested
> standalone with sh4-elf-gcc 9.2.0 and a Sega Dreamcast (SH7750/R-like).
> 
> If anyone is interested in an easier-to-read version of the assembly that
> does not match the in-kernel style, it is included in this note:
> 
> static inline char *strncpy(char *__dest, const char *__src, size_t __n)
> {
> 	char * retval = __dest;
> 	const char * __dest_end = __dest + __n - 1;
> 
> 	if(__n = 0)
> 	{
> 		return retval;
> 	}
> 
> 	__asm__ __volatile__(
> 	"strncpy_start:\n\t"
> 		"mov.b @%[src]+,r0\n\t"
> 		"mov.b r0,@%[dest]\n\t"
> 		"cmp/eq %[dest],%[dest_end]\n\t"
> 		"bt.s strncpy_end\n\t"
> 		"cmp/eq #0,r0\n\t"
> 		"bf.s strncpy_start\n\t"
> 		"add #1,%[dest]\n\t"
> 	"strncpy_pad:\n\t"
> 		"mov.b r0,@%[dest]\n\t"
> 		"cmp/eq %[dest],%[dest_end]\n\t"
> 		"bf.s strncpy_pad\n\t"
> 		"add #1,%[dest]\n\t"
> 	"strncpy_end:\n\t"
> 		: [dest] "+r" (__dest), [src] "+r" (__src)
> 		: [dest_end] "r" (__dest_end)
> 		: "r0","t","memory");
> 
> 	return retval;
> }
> 
> (In maintaining the spirit of the original work, consider this piece of
> code public domain.)
> 
>  arch/sh/include/asm/string_32.h | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sh/include/asm/string_32.h b/arch/sh/include/asm/string_32.h
> index 3558b1d7123e..7f83eaea987a 100644
> --- a/arch/sh/include/asm/string_32.h
> +++ b/arch/sh/include/asm/string_32.h
> @@ -32,6 +32,7 @@ static inline char *strcpy(char *__dest, const char *__src)
>  static inline char *strncpy(char *__dest, const char *__src, size_t __n)
>  {
>  	register char *__xdest = __dest;
> +	const char *__dest_end = __dest + __n - 1;
>  	unsigned long __dummy;
>  
>  	if (__n = 0)
> @@ -41,14 +42,19 @@ static inline char *strncpy(char *__dest, const char *__src, size_t __n)
>  		"1:\n"
>  		"mov.b	@%1+, %2\n\t"
>  		"mov.b	%2, @%0\n\t"
> -		"cmp/eq	#0, %2\n\t"
> -		"bt/s	2f\n\t"
> -		" cmp/eq	%5,%1\n\t"
> -		"bf/s	1b\n\t"
> +		"cmp/eq	%0, %5\n\t"
> +		"bt.s	3f\n\t"
> +		" cmp/eq	#0, %2\n\t"
> +		"bf.s	1b\n\t"
>  		" add	#1, %0\n"
> -		"2:"
> +		"2:\n\t"
> +		"mov.b	%2,	@%0\n\t"
> +		"cmp/eq	%0,	%5\n\t"
> +		"bf.s 2b\n\t"
> +		" add	#1,	%0\n"
> +		"3:"
>  		: "=r" (__dest), "=r" (__src), "=&z" (__dummy)
> -		: "0" (__dest), "1" (__src), "r" (__src+__n)
> +		: "0" (__dest), "1" (__src), "r" (__dest_end)
>  		: "memory", "t");
>  
>  	return __xdest;
> 

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
