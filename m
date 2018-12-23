From: Steven Rostedt <rostedt@goodmis.org>
Date: Sun, 23 Dec 2018 03:46:31 +0000
Subject: Re: [for-next][PATCH 5/5] tracing: Use the return of str_has_prefix() to remove open coded numbers
Message-Id: <20181222224631.02e27c51@vmware.local.home>
List-Id: <linux-sh.vger.kernel.org>
References: <20181222162007.697862256@goodmis.org>
        <20181222162857.116914355@goodmis.org>
        <20181223122352.dd3c077443f0b6621a796039@kernel.org>
In-Reply-To: <20181223122352.dd3c077443f0b6621a796039@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

On Sun, 23 Dec 2018 12:23:52 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Sat, 22 Dec 2018 11:20:12 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > There are several locations that compare constants to the beginning of
> > string variables to determine what commands should be done, then the
> > constant length is used to index into the string. This is error prone as the
> > hard coded numbers have to match the size of the constants. Instead, use the
> > len returned from str_has_prefix() and remove the open coded string length
> > sizes.  
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> for trace_probe part.

Thanks Masami!

-- Steve
