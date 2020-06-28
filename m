From: Steven Rostedt <rostedt@goodmis.org>
Date: Sun, 28 Jun 2020 19:07:55 +0000
Subject: Re: [PATCH] kbuild: introduce ccflags-remove-y and asflags-remove-y
Message-Id: <20200628150755.523fbb2c@oasis.local.home>
List-Id: <linux-sh.vger.kernel.org>
References: <20200628015041.1000002-1-masahiroy@kernel.org>
In-Reply-To: <20200628015041.1000002-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kbuild@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Sami Tolvanen <samitolvanen@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, linux-arm-kernel@lists.infradead.org

On Sun, 28 Jun 2020 10:50:41 +0900
Masahiro Yamada <masahiroy@kernel.org> wrote:

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

Nice feature!

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
