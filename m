From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Tue, 02 Mar 2010 15:13:11 +0000
Subject: Re: [PATCH 42/66] arch/mips/lib/libgcc.h: Checkpatch cleanup
Message-Id: <9cdbb57f1003020713x4e897af9ka87e348bf782f380@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
         <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
         <20100301023316.GB23086@linux-sh.org>
In-Reply-To: <20100301023316.GB23086@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org

2010/3/1 Paul Mundt <lethal@linux-sh.org>:
Hi Paul,
   thanks for your reply.

> I'll apply the sh part by itself, and I suppose Ralf will do the same for
> MIPS. I'm a bit confused as to why these were lumped together when 65 out
> of 66 oneliner patches made no use of ad-hoc grouping.

After the experience with GregKH, I was looking for others maintainer
interested in code cleanup. So I sent some patches over random files.
If you care, I can checkpatch.pl all mips subtree and send you patches (if any).

Thanks a lot for your work,
Andrea
