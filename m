From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 19 Nov 2018 16:50:50 +0000
Subject: Re: [PATCH v3 1/3] sh: add __NR_syscalls along with NR_syscalls
Message-Id: <CAK8P3a3fFznLDZTs0eLa_dJCKdENC96w1MoC1pNM6gYwcb=Cow@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
 <1542169930-24118-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542169930-24118-2-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-arch <linux-arch@vger.kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Nov 14, 2018 at 5:32 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> NR_syscalls macro holds the number of system call exist
> in sh architecture. We have to change the value of NR-
> _syscalls, if we add or delete a system call.
>
> One of the patch in this patch series has a script which
> will generate a uapi header based on syscall.tbl file.
> The syscall.tbl file contains the total number of system
> calls information. So we have two option to update NR_sy-
> scalls value.
>
> 1. Update NR_syscalls in asm/unistd.h manually by count-
>    ing the no.of system calls. No need to update NR_sys-
>    calls until we either add a new system call or delete
>    existing system call.
>
> 2. We can keep this feature it above mentioned script,
>    that will count the number of syscalls and keep it in
>    a generated file. In this case we don't need to expli-
>    citly update NR_syscalls in asm/unistd.h file.
>
> The 2nd option will be the recommended one. For that, I
> added the __NR_syscalls macro in uapi/asm/unistd_32/64.h
> along with NR_syscalls which is moved to asm/unistd.h.
> The macro __NR_syscalls also added for making the name
> convention same across all architecture. While __NR_sys-
> calls isn't strictly part of the uapi, having it as part
> of the generated header to simplifies the implementation.
> We also need to enclose this macro with #ifdef __KERNEL__
> to avoid side effects.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Looks correct to me, but since there are only three references to
'NR_syscalls' in arch/sh, I wonder if we should just replace it with
__NR_syscalls in the same patch.

       Arnd
