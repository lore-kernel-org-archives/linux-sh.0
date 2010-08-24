From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 Aug 2010 06:33:28 +0000
Subject: Re: [PATCH] sh: fix kconfig warning
Message-Id: <20100824063327.GA7384@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1282579872-16609-1-git-send-email-lacombar@gmail.com>
In-Reply-To: <1282579872-16609-1-git-send-email-lacombar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnaud Lacombe <lacombar@gmail.com>
Cc: Michal Marek <mmarek@suse.cz>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Mon, Aug 23, 2010 at 12:11:12PM -0400, Arnaud Lacombe wrote:
> warning: (SUPERH32) selects HAVE_HW_BREAKPOINT which has unmet direct dependencies (PERF_EVENTS)
> 
> This warning was causing Kconfig to segfault.
> 
> Signed-off-by: Arnaud Lacombe <lacombar@gmail.com>

This was already fixed by Sam, thanks anyways.
