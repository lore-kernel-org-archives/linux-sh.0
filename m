From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 13 Dec 2011 02:22:54 +0000
Subject: Re: [PATCH (sh-2.6)] sh: do not export syscalls that are actually not implemented
Message-Id: <20111213022253.GD19960@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1322685809-15587-1-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1322685809-15587-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 12, 2011 at 11:58:39AM +0100, Carmelo AMOROSO wrote:
> On 30/11/2011 21.56, Mike Frysinger wrote:
> > On Wednesday 30 November 2011 15:43:29 Carmelo AMOROSO wrote:
> >> Avoid user space to erroneously assume that a syscall is
> >> implemented by picking __NR_xxx from kernel headers that are
> >> actually mapped to sys_ni_syscall.
> > 
> > Acked-by: Mike Frysinger <vapier@gentoo.org> -mike
> 
> Paul,
> anu chance to include it ? to avoid any doubts, patch was done against
> HEAD, the subject sh-2.6 was due to a old git setting.
> 
It's on my review list, just haven't had a chance to go through it yet.
