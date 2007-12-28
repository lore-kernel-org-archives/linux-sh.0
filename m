From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Fri, 28 Dec 2007 23:40:13 +0000
Subject: Re: [DREAMCAST] : Buildfailure
Message-Id: <20071229004013.9a05bbd6.Kristoffer.Ericson@Gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 26 Dec 2007 15:55:16 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Thu, Dec 20, 2007 at 04:17:13PM +0900, Nobuhiro Iwamatsu wrote:
> > On Thu, 20 Dec 2007 02:44:54 +0100
> > Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> > > > It was possible to confirm it even in my environment. 
> > > > The problem occurs when it is gcc-3.4. 
> > > 
> > > Is this a bug in GCC or is it more of a design thing?
> > 
> > I do not understand in which there is a cause. 
> > If I have time, I want to examine it. 
> 
> There were a few inconsistencies, and also a const mismatch in the
> get_user() case. This fixes those up, and makes the get/put_user
> interfaces a bit more consistent, with more reliable type checking.
> 
> See if this fixes things for you, seems to do the trick with my gcc-3.x
> and gcc-4.x compilers.

Builds nicely now, thanks.

> 
> ---
> 
>  include/asm-sh/uaccess_32.h |   64 +++++++++++++++++++-------------------------
>  1 file changed, 28 insertions(+), 36 deletions(-)
> 
> diff --git a/include/asm-sh/uaccess_32.h b/include/asm-sh/uaccess_32.h
> index 59a9f20..50b2f0b 100644
> --- a/include/asm-sh/uaccess_32.h
> +++ b/include/asm-sh/uaccess_32.h
> @@ -95,11 +95,9 @@ static inline int __access_ok(unsigned long addr, unsigned long size)
>  }
>  #endif /* CONFIG_MMU */
>  
> -static inline int access_ok(int type, const void __user *p, unsigned long size)
> -{
> -	unsigned long addr = (unsigned long)p;
> -	return __access_ok(addr, size);
> -}
> +#define access_ok(type, addr, size)	\
> +	(__chk_user_ptr(addr),		\
> +	 __access_ok((unsigned long __force)(addr), (size)))
>  
>  /*
>   * Uh, these should become the main single-value transfer routines ...
> @@ -113,18 +111,16 @@ static inline int access_ok(int type, const void __user *p, unsigned long size)
>   * (a) re-use the arguments for side effects (sizeof is ok)
>   * (b) require any knowledge of processes at this stage
>   */
> -#define put_user(x,ptr)	__put_user_check((x),(ptr),sizeof(*(ptr)))
> -#define get_user(x,ptr) __get_user_check((x),(ptr),sizeof(*(ptr)))
> +#define put_user(x,ptr)		__put_user_check((x), (ptr), sizeof(*(ptr)))
> +#define get_user(x,ptr)		__get_user_check((x), (ptr), sizeof(*(ptr)))
>  
>  /*
>   * The "__xxx" versions do not do address space checking, useful when
>   * doing multiple accesses to the same area (the user has to do the
>   * checks by hand with "access_ok()")
>   */
> -#define __put_user(x,ptr) \
> -  __put_user_nocheck((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
> -#define __get_user(x,ptr) \
> -  __get_user_nocheck((x),(ptr),sizeof(*(ptr)))
> +#define __put_user(x,ptr)	__put_user_nocheck((x), (ptr), sizeof(*(ptr)))
> +#define __get_user(x,ptr)	__get_user_nocheck((x), (ptr), sizeof(*(ptr)))
>  
>  struct __large_struct { unsigned long buf[100]; };
>  #define __m(x) (*(struct __large_struct __user *)(x))
> @@ -132,7 +128,6 @@ struct __large_struct { unsigned long buf[100]; };
>  #define __get_user_size(x,ptr,size,retval)			\
>  do {								\
>  	retval = 0;						\
> -	__chk_user_ptr(ptr);					\
>  	switch (size) {						\
>  	case 1:							\
>  		__get_user_asm(x, ptr, retval, "b");		\
> @@ -151,24 +146,22 @@ do {								\
>  
>  #define __get_user_nocheck(x,ptr,size)				\
>  ({								\
> -	long __gu_err, __gu_val;				\
> -	__typeof__(*(ptr)) *__pu_addr = (ptr);  \
> -	__get_user_size(__gu_val, (__pu_addr), (size), __gu_err);	\
> +	long __gu_err;						\
> +	unsigned long __gu_val;					\
> +	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
> +	__chk_user_ptr(ptr);					\
> +	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
>  	(x) = (__typeof__(*(ptr)))__gu_val;			\
>  	__gu_err;						\
>  })
>  
>  #define __get_user_check(x,ptr,size)					\
>  ({									\
> -	long __gu_err, __gu_val;					\
> -	__typeof__(*(ptr)) *__pu_addr = (ptr);				\
> -	__chk_user_ptr(__pu_addr);					\
> -	if (likely(__addr_ok((unsigned long)(__pu_addr)))) {		\
> -		__get_user_size(__gu_val, (__pu_addr), (size), __gu_err);\
> -	} else {							\
> -		__gu_err = -EFAULT;					\
> -		__gu_val = 0;						\
> -	}								\
> +	long __gu_err = -EFAULT;					\
> +	unsigned long __gu_val = 0;					\
> +	const __typeof__(*(ptr)) *__gu_addr = (ptr);			\
> +	if (likely(access_ok(VERIFY_READ, __gu_addr, (size))))		\
> +		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
>  	(x) = (__typeof__(*(ptr)))__gu_val;				\
>  	__gu_err;							\
>  })
> @@ -199,7 +192,6 @@ extern void __get_user_unknown(void);
>  #define __put_user_size(x,ptr,size,retval)		\
>  do {							\
>  	retval = 0;					\
> -	__chk_user_ptr(ptr);				\
>  	switch (size) {					\
>  	case 1:						\
>  		__put_user_asm(x, ptr, retval, "b");	\
> @@ -218,22 +210,22 @@ do {							\
>  	}						\
>  } while (0)
>  
> -#define __put_user_nocheck(x,ptr,size)			\
> -({							\
> -	long __pu_err;					\
> -	__put_user_size((x),(ptr),(size),__pu_err);	\
> -	__pu_err;					\
> +#define __put_user_nocheck(x,ptr,size)				\
> +({								\
> +	long __pu_err;						\
> +	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
> +	__chk_user_ptr(ptr);					\
> +	__put_user_size((x), __pu_addr, (size), __pu_err);	\
> +	__pu_err;						\
>  })
>  
>  #define __put_user_check(x,ptr,size)				\
>  ({								\
> -	long __pu_err;						\
> +	long __pu_err = -EFAULT;				\
>  	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
> -								\
> -	if (likely(__addr_ok((unsigned long)__pu_addr)))	\
> -		__put_user_size((x),__pu_addr,(size),__pu_err);	\
> -	else							\
> -		__pu_err = -EFAULT;				\
> +	if (likely(access_ok(VERIFY_WRITE, __pu_addr, size)))	\
> +		__put_user_size((x), __pu_addr, (size),		\
> +				__pu_err);			\
>  	__pu_err;						\
>  })
>  


-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
