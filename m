From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 06 Jul 2020 18:14:40 +0000
Subject: Re: [PATCH] kbuild: introduce ccflags-remove-y and asflags-remove-y
Message-Id: <CAK7LNARg_B+tcbduBzrh2_Q3dwk_XxDcaw+sMTwsMOxNYM7hnQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200628015041.1000002-1-masahiroy@kernel.org>
 <87imfa8le0.fsf@mpe.ellerman.id.au>
 <CAK7LNATusciypBJ4dYZcyrugdi_rXEV_s=zxAehDxsX+Sd5z4g@mail.gmail.com>
 <CADYN=9JnzPC6Ja9s3_01k-CDTSuxKBMRdrqU5rqp0xw1r9XpRw@mail.gmail.com>
In-Reply-To: <CADYN=9JnzPC6Ja9s3_01k-CDTSuxKBMRdrqU5rqp0xw1r9XpRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Michal Marek <michal.lkml@markovi.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Russell King <linux@armlinux.org.uk>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Sami Tolvanen <samitolvanen@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Anders,

On Mon, Jul 6, 2020 at 8:24 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>

> The full log can be found here [1].
>
> Without this patch for  'trace_selftest_dynamic' for instance, CC_FLAGS_FTRACE
> was removed from kernel/trace/*, and then added back to
> kernel/trace/trace_selftest_dynamic.
> While with this patch it looks like we add the flag (even though it is
> already there), and then
> removes the flag for all files in kernel/trace/* .


You are right.

I will drop this patch,
and send v2.


Thank you.




-- 
Best Regards
Masahiro Yamada
