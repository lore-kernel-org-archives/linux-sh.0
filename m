From: Steven Rostedt <rostedt@goodmis.org>
Date: Sun, 23 Dec 2018 03:53:38 +0000
Subject: Re: [for-next][PATCH 2/5] tracing: Use str_has_prefix() helper for histogram code
Message-Id: <20181222225338.34cc579c@vmware.local.home>
List-Id: <linux-sh.vger.kernel.org>
References: <20181222162007.697862256@goodmis.org>
        <20181222162856.666843139@goodmis.org>
        <20181222130107.43aaac9c@gandalf.local.home>
        <1545501821.4383.2.camel@kernel.org>
In-Reply-To: <1545501821.4383.2.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Zanussi <zanussi@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

On Sat, 22 Dec 2018 12:03:41 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Steve,
> 
> On Sat, 2018-12-22 at 13:01 -0500, Steven Rostedt wrote:
> > On Sat, 22 Dec 2018 11:20:09 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > The tracing histogram code contains a lot of instances of the
> > > construct:
> > > 
> > >  strncmp(str, "const", sizeof("const") - 1)
> > > 
> > > This can be prone to bugs due to typos or bad cut and paste. Use
> > > the
> > > str_has_prefix() helper macro instead that removes the need for
> > > having two
> > > copies of the constant string.
> > > 
> > > Cc: Tom Zanussi <zanussi@linux.intel.com>  
> > 
> > I have no idea why I copied your intel email. The linux.intel.com
> > appears to be no longer active. I'm going to rebase to fix this email
> > address.  
> 
> linux.intel.com is active, but there's no zanussi there, just
> tom.zanussi ;-)
> 
> So tom.zanussi@linux.intel.com should work fine.

BTW, would you give me your ack-by?

-- Steve
