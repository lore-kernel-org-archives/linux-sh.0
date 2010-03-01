From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 01 Mar 2010 02:33:16 +0000
Subject: Re: [PATCH 42/66] arch/mips/lib/libgcc.h: Checkpatch cleanup
Message-Id: <20100301023316.GB23086@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net> <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org

On Sat, Feb 27, 2010 at 05:51:23PM +0100, Andrea Gelmini wrote:
> arch/mips/lib/libgcc.h:21: ERROR: open brace '{' following union go on the same line
> 
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  arch/mips/lib/libgcc.h |    3 +--
>  arch/sh/lib/libgcc.h   |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
I'll apply the sh part by itself, and I suppose Ralf will do the same for
MIPS. I'm a bit confused as to why these were lumped together when 65 out
of 66 oneliner patches made no use of ad-hoc grouping.
