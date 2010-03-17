From: Ralf Baechle <ralf@linux-mips.org>
Date: Wed, 17 Mar 2010 15:51:28 +0000
Subject: Re: [PATCH 42/66] arch/mips/lib/libgcc.h: Checkpatch cleanup
Message-Id: <20100317155126.GE4554@linux-mips.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
 <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
 <20100301023316.GB23086@linux-sh.org>
 <9cdbb57f1003020713x4e897af9ka87e348bf782f380@mail.gmail.com>
In-Reply-To: <9cdbb57f1003020713x4e897af9ka87e348bf782f380@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org

On Tue, Mar 02, 2010 at 04:13:11PM +0100, Andrea Gelmini wrote:

> 2010/3/1 Paul Mundt <lethal@linux-sh.org>:
> Hi Paul,
>    thanks for your reply.
> 
> > I'll apply the sh part by itself, and I suppose Ralf will do the same for
> > MIPS. I'm a bit confused as to why these were lumped together when 65 out
> > of 66 oneliner patches made no use of ad-hoc grouping.
> 
> After the experience with GregKH, I was looking for others maintainer
> interested in code cleanup. So I sent some patches over random files.
> If you care, I can checkpatch.pl all mips subtree and send you patches (if any).

Feel free to - but remember that the coding style document is a guideline
not something to be followed unconditionally.

  Ralf
