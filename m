From: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 29 Jun 2020 05:57:11 +0000
Subject: Re: [PATCH] kbuild: introduce ccflags-remove-y and asflags-remove-y
Message-Id: <87imfa8le0.fsf@mpe.ellerman.id.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20200628015041.1000002-1-masahiroy@kernel.org>
In-Reply-To: <20200628015041.1000002-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Sami Tolvanen <samitolvanen@google.com>, Rich Felker <dalias@libc.org>, linux-arm-kernel@lists.infradead.org

Masahiro Yamada <masahiroy@kernel.org> writes:
> CFLAGS_REMOVE_<file>.o works per object, that is, there is no
> convenient way to filter out flags for every object in a directory.
>
> Add ccflags-remove-y and asflags-remove-y to make it easily.
>
> Use ccflags-remove-y to clean up some Makefiles.
>
> Suggested-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/arm/boot/compressed/Makefile | 6 +-----
>  arch/powerpc/xmon/Makefile        | 3 +--
>  arch/sh/boot/compressed/Makefile  | 5 +----
>  kernel/trace/Makefile             | 4 ++--
>  lib/Makefile                      | 5 +----
>  scripts/Makefile.lib              | 4 ++--
>  6 files changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
> index 89c76ca35640..55cbcdd88ac0 100644
> --- a/arch/powerpc/xmon/Makefile
> +++ b/arch/powerpc/xmon/Makefile
> @@ -7,8 +7,7 @@ UBSAN_SANITIZE := n
>  KASAN_SANITIZE := n
>  
>  # Disable ftrace for the entire directory
> -ORIG_CFLAGS := $(KBUILD_CFLAGS)
> -KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
> +ccflags-remove-y += $(CC_FLAGS_FTRACE)

This could be:

ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)

Similar to kernel/trace/Makefile below.

I don't mind though.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 6575bb0a0434..7492844a8b1b 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -2,9 +2,9 @@
>  
>  # Do not instrument the tracer itself:
>  
> +ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> +
>  ifdef CONFIG_FUNCTION_TRACER
> -ORIG_CFLAGS := $(KBUILD_CFLAGS)
> -KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
>  
>  # Avoid recursion due to instrumentation.
>  KCSAN_SANITIZE := n
