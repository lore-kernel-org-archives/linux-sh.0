From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 26 Feb 2008 05:28:17 +0000
Subject: Re: needs change macro HAS_SR_RB
Message-Id: <20080226052817.GH19814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080216.101223.68566246.saito@densan.co.jp>
In-Reply-To: <20080216.101223.68566246.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Feb 16, 2008 at 10:12:23AM +0900, Hideo Saito wrote:
> I wonder if you don't change a name intentionally, if not so ...
> 
> diff -pU8 -Naur linux-2.6.24.org/include/asm-sh/entry-macros.S linux-2.6.24/include/asm-sh/entry-macros.S
> --- linux-2.6.24.org/include/asm-sh/entry-macros.S	2008-01-25 07:58:37.000000000 +0900
> +++ linux-2.6.24/include/asm-sh/entry-macros.S	2008-02-04 11:45:35.000000000 +0900
> @@ -7,25 +7,25 @@
>  	.endm
>  
>  	.macro	sti
>  	mov	#0xf0, r11
>  	extu.b	r11, r11
>  	not	r11, r11
>  	stc	sr, r10
>  	and	r11, r10
> -#ifdef CONFIG_HAS_SR_RB
> +#ifdef CONFIG_CPU_HAS_SR_RB
>  	stc	k_g_imask, r11
>  	or	r11, r10
>  #endif
>  	ldc	r10, sr
>  	.endm
>  
Oops. Yes, that's correct. The fact this has gone undetected so far
prooves just how often SR.IMASK is used.. Good catch, thanks!
