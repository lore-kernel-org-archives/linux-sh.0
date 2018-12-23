From: Steven Rostedt <rostedt@goodmis.org>
Date: Sun, 23 Dec 2018 03:53:25 +0000
Subject: Re: [for-next][PATCH 0/5] tracing: Add string_has_prefix() and usages
Message-Id: <20181222225325.6be0c77f@vmware.local.home>
List-Id: <linux-sh.vger.kernel.org>
References: <20181222162007.697862256@goodmis.org>
        <20181223034120.GF11421@danjae.aot.lge.com>
In-Reply-To: <20181223034120.GF11421@danjae.aot.lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, kernel-team@lge.com

On Sun, 23 Dec 2018 12:41:20 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> > Steven Rostedt (VMware) (5):
> >       string.h: Add str_has_prefix() helper function
> >       tracing: Use str_has_prefix() helper for histogram code
> >       tracing: Use str_has_prefix() instead of using fixed sizes
> >       tracing: Have the historgram use the result of str_has_prefix() for len of prefix
> >       tracing: Use the return of str_has_prefix() to remove open coded numbers  
> 
> For the series:
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks Namhyung!

-- Steve
