From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 05 Aug 2008 20:22:54 +0000
Subject: Re: rsk7203_defconfig build error
Message-Id: <87sktjw6sh.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20080805154429.GD22895@cs181140183.pp.htv.fi>
In-Reply-To: <20080805154429.GD22895@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org, Adrian Bunk <bunk@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

At Tue, 5 Aug 2008 18:44:29 +0300,
Adrian Bunk wrote:
> 
> Hi Paul,
> 
> rsk7203_defconfig fails to build with the following error:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> arch/sh/kernel/built-in.o:(__ksymtab+0xb8): undefined reference to `__udivsi3_i4i'
> arch/sh/kernel/built-in.o:(__ksymtab+0xc8): undefined reference to `__sdivsi3_i4i'
> make[1]: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> That worked with 2.6.26, and these are far less undefined references 
> than in the cases where libgcc was missing.

This functions is not defined sh2 and sh2a.
See gcc-4.3.1/gcc/config/sh/lib1funcs.asm

Sorry I forget report.

This patch not tested.
Please test and apply.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

diff --git a/arch/sh/kernel/sh_ksyms_32.c b/arch/sh/kernel/sh_ksyms_32.c
index 8f91653..6e1b1c2 100644
--- a/arch/sh/kernel/sh_ksyms_32.c
+++ b/arch/sh/kernel/sh_ksyms_32.c
@@ -107,10 +107,12 @@ DECLARE_EXPORT(__movmemSI12_i4);
  * GCC >= 4.2 emits these for division, as do GCC 4.1.x versions of the ST
  * compiler which include backported patches.
  */
-DECLARE_EXPORT(__sdivsi3_i4i);
 DECLARE_EXPORT(__udiv_qrnnd_16);
+#if !defined(CONFIG_CPU_SH2)
+DECLARE_EXPORT(__sdivsi3_i4i);
 DECLARE_EXPORT(__udivsi3_i4i);
 #endif
+#endif
 #else /* GCC 3.x */
 DECLARE_EXPORT(__movstr_i4_even);
 DECLARE_EXPORT(__movstr_i4_odd);

> Does it build with your toolchain?
> Do you have any clue what's going wrong here?
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
