From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 07 Jul 2020 19:58:01 +0000
Subject: Re: [PATCH v2 1/2] kbuild: introduce ccflags-remove-y and asflags-remove-y
Message-Id: <CAFd5g46eCjZA-e4akYc1K8u29tp94gpmrAOxZ_joZ=9kJtZeuA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200707092117.963394-1-masahiroy@kernel.org>
In-Reply-To: <20200707092117.963394-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Rich Felker <dalias@libc.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, Anders Roxell <anders.roxell@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Haren Myneni <haren@us.ibm.com>, Sami Tolvanen <samitolvanen@google.com>, Petr Mladek <pmladek@suse.com>, linux-kbuild <linux-kbuild@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, KUnit Development <kunit-dev@googlegroups.com>, Michal Marek <michal.lkml@markovi.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tal Gilboa <talgi@mellanox.com>, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Tue, Jul 7, 2020 at 2:22 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> CFLAGS_REMOVE_<file>.o filters out flags when compiling a particular
> object, but there is no convenient way to do that for every object in
> a directory.
>
> Add ccflags-remove-y and asflags-remove-y to make it easily.
>
> Use ccflags-remove-y to clean up some Makefiles.
>
> The add/remove order works as follows:
>
>  [1] KBUILD_CFLAGS specifies compiler flags used globally
>
>  [2] ccflags-y adds compiler flags for all objects in the
>      current Makefile
>
>  [3] ccflags-remove-y removes compiler flags for all objects in the
>      current Makefile (New feature)
>
>  [4] CFLAGS_<file> adds compiler flags per file.
>
>  [5] CFLAGS_REMOVE_<file> removes compiler flags per file.
>
> Having [3] before [4] allows us to remove flags from most (but not all)
> objects in the current Makefile.
>
> For example, kernel/trace/Makefile removes $(CC_FLAGS_FTRACE)
> from all objects in the directory, then adds it back to
> trace_selftest_dynamic.o and CFLAGS_trace_kprobe_selftest.o
>
> Please note ccflags-remove-y has no effect to the sub-directories.
> In contrast, the previous notation got rid of compiler flags also from
> all the sub-directories.
>
>   arch/arm/boot/compressed/
>   arch/powerpc/xmon/
>   arch/sh/
>   kernel/trace/
>
> ... have no sub-directories.
>
>   lib/
>
> ... has several sub-directories.
>
> To keep the behavior, I added ccflags-remove-y to all Makefiles
> in subdirectories of lib/, except:
>
>   lib/vdso/Makefile        - Kbuild does not descend into this Makefile
>   lib/raid/test/Makefile   - This is not used for the kernel build
>
> I think commit 2464a609ded0 ("ftrace: do not trace library functions")
> excluded too much. In later commit, I will try to remove ccflags-remove-y
> from sub-directory Makefiles.
>
> Suggested-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Acked-by: Brendan Higgins <brendanhiggins@google.com> (KUnit)
