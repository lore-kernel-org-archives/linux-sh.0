From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Sep 2010 06:13:13 +0000
Subject: Re: [PATCH] sh: Remove unused __IGNORE_recvmmsg macro.
Message-Id: <20100902061312.GF10947@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1283306055-761-1-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1283306055-761-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 02, 2010 at 06:29:11AM +0200, Carmelo AMOROSO wrote:
> Your patch wiring up the broken out syscalls does not wire up recvmmsg,
> so could you explain your reasoning for why you think this is unused?
> 
> Paul,
> I've grep-ed across all the kernel source and I did not find any use of this macro.
> It is not relates to the sockecall at all.
> 
The macro isn't, but the syscall is. recvmmsg is accessible through
socketcall, which is why we don't define it. Now that you have provided
broken out implementations to co-exist with the socketcall interface,
you'll want to wire up the recvmmsg syscall also (note that this is
different from recvmsg, which you already handle).

The IGNORE macros are there to tell the syscall checker that we don't
care about it, so not to warn during the build about the syscall being
unimplemented -- see scripts/checksyscalls.sh.
