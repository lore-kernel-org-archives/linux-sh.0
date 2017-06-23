From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Jun 2017 03:25:10 +0000
Subject: Re: [PATCH v2 1/3] sh: thin archives fix linking
Message-Id: <CAK7LNAQk9Vm0u1Avm6ruPw6rdbiXmmdpG0gLtduHM30tHs7=6g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170622123929.15054-1-npiggin@gmail.com> <20170622123929.15054-2-npiggin@gmail.com>
In-Reply-To: <20170622123929.15054-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

2017-06-22 21:39 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> The VDSO symbols can't be linked into built-in.o when building with
> thin archives, so change this to linking a new object file that is
> included into the built-in.o.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/sh/kernel/vsyscall/Makefile | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/arch/sh/kernel/vsyscall/Makefile b/arch/sh/kernel/vsyscall/Makefile
> index 8f0ea5fc835c..efc7a6837ef6 100644
> --- a/arch/sh/kernel/vsyscall/Makefile
> +++ b/arch/sh/kernel/vsyscall/Makefile
> @@ -1,4 +1,4 @@
> -obj-y += vsyscall.o vsyscall-syscall.o
> +obj-y += vsyscall.o vsyscall-syscall.o vsyscall-syms.o
>
>  $(obj)/vsyscall-syscall.o: \
>         $(foreach F,trapa,$(obj)/vsyscall-$F.so)
> @@ -26,11 +26,13 @@ $(obj)/vsyscall-%.so: $(src)/vsyscall.lds $(obj)/vsyscall-%.o FORCE
>  # We also create a special relocatable object that should mirror the symbol
>  # table and layout of the linked DSO.  With ld -R we can then refer to
>  # these symbols in the kernel code rather than hand-coded addresses.
> -extra-y += vsyscall-syms.o
> -$(obj)/built-in.o: $(obj)/vsyscall-syms.o
> -$(obj)/built-in.o: ld_flags += -R $(obj)/vsyscall-syms.o
> -
> -SYSCFLAGS_vsyscall-syms.o = -r
> -$(obj)/vsyscall-syms.o: $(src)/vsyscall.lds \
> +SYSCFLAGS_vsyscall-dummy.o = -r
> +$(obj)/vsyscall-dummy.o: $(src)/vsyscall.lds \
>                         $(obj)/vsyscall-trapa.o $(obj)/vsyscall-note.o FORCE
>         $(call if_changed,syscall)
> +
> +quiet_cmd_syscall_syms = SYSCALL $@
> +      cmd_syscall_syms = $(LD) -r -R $(obj)/vsyscall-dummy.o -o $@
> +
> +$(obj)/vsyscall-syms.o: $(obj)/vsyscall-dummy.o
> +       $(call if_changed,syscall_syms)
> --
> 2.11.0

I applied this, but
I just noticed vsyscall-dummy is rebuilt every time.


  SYSCALL arch/sh/kernel/vsyscall/vsyscall-dummy.o
  SYSCALL arch/sh/kernel/vsyscall/vsyscall-syms.o
  AR      arch/sh/kernel/vsyscall/built-in.o
  AR      arch/sh/kernel/built-in.o



We can avoid the unneeded rebuild by adding "vsyscall-dummy.o" to "targets".

targets += vsyscall-note.o vsyscall.lds vsyscall-dummy.o



-- 
Best Regards
Masahiro Yamada
