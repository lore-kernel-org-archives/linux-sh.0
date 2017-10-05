From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 05 Oct 2017 07:58:19 +0000
Subject: Re: [PATCH] mm, arch: remove empty_bad_page*
Message-Id: <20171005075819.nehorwiced7emgfi@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20171004150045.30755-1-mhocko@kernel.org>
In-Reply-To: <20171004150045.30755-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, David Howells <dhowells@redhat.com>, Jeff Dike <jdike@addtoit.com>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, uclinux-h8-devel@lists.sourceforge.jp, Yoshinori Sato <ysato@users.sourceforge.jp>


* Michal Hocko <mhocko@kernel.org> wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> empty_bad_page and empty_bad_pte_table seems to be a relict from old
> days which is not used by any code for a long time. I have tried to find
> when exactly but this is not really all that straightforward due to many
> code movements - traces disappear around 2.4 times.
> 
> Anyway no code really references neither empty_bad_page nor
> empty_bad_pte_table. We only allocate the storage which is not used by
> anybody so remove them.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: <uclinux-h8-devel@lists.sourceforge.jp>
> Cc: <linux-mips@linux-mips.org>
> Cc: <linux-sh@vger.kernel.org>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

For the x86 bits:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
