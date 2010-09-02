From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Sep 2010 06:14:18 +0000
Subject: Re: [PATCH] sh_net: Do not implement socketcall, use specific syscalls.
Message-Id: <20100902061418.GG10947@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1283305771-31182-2-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1283305771-31182-2-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 02, 2010 at 06:27:41AM +0200, Carmelo AMOROSO wrote:
> 
> 
> -----Original Message-----
> From: Paul Mundt [mailto:lethal@linux-sh.org] 
> Sent: Thursday, September 02, 2010 4:54 AM
> To: Carmelo AMOROSO
> Cc: linux-sh@vger.kernel.org
> Subject: Re: [PATCH] sh_net: Do not implement socketcall, use specific syscalls.
> 
> On Wed, Sep 01, 2010 at 03:57:09AM +0200, Carmelo AMOROSO wrote:
> > Socket syscalls entries are now available in the syscall table,
> > so it does not need to implement the multipler syscall.
> > It is mapped into the sys_ni_syscall.
> > 
> I don't see how we can make this sort of change safely, it's part of the
> existing ABI. Going forward we can gradually migrate people over to using
> the broken out syscalls directly, but we will need to maintain
> compatability with old binaries almost indefinitely.
> 
> Hi Paul,
> I understand your point regarding the backward compatibility, you're right in keeping
> the socketcall implemented, but I think we should add the broken-out syscalls, so an
> updated version of the C library could make use of them.
> 
Agreed, I had thought about doing this before but I didn't have the time
to look in to what was needed on the libc side. If other people are
taking care of this, I'm of course more than happy to add them in on the
kernel side.
