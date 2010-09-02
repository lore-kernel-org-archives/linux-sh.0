From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Thu, 02 Sep 2010 04:27:41 +0000
Subject: RE: [PATCH] sh_net: Do not implement socketcall, use specific
Message-Id: <4C81667D7A02944B98C4DC6290A19E6CA1113FAEDE@SAFEX1MAIL3.st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1283305771-31182-2-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1283305771-31182-2-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



-----Original Message-----
From: Paul Mundt [mailto:lethal@linux-sh.org] 
Sent: Thursday, September 02, 2010 4:54 AM
To: Carmelo AMOROSO
Cc: linux-sh@vger.kernel.org
Subject: Re: [PATCH] sh_net: Do not implement socketcall, use specific syscalls.

On Wed, Sep 01, 2010 at 03:57:09AM +0200, Carmelo AMOROSO wrote:
> Socket syscalls entries are now available in the syscall table,
> so it does not need to implement the multipler syscall.
> It is mapped into the sys_ni_syscall.
> 
I don't see how we can make this sort of change safely, it's part of the
existing ABI. Going forward we can gradually migrate people over to using
the broken out syscalls directly, but we will need to maintain
compatability with old binaries almost indefinitely.

Hi Paul,
I understand your point regarding the backward compatibility, you're right in keeping
the socketcall implemented, but I think we should add the broken-out syscalls, so an
updated version of the C library could make use of them.

Carmelo
