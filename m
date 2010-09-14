From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Tue, 14 Sep 2010 08:47:20 +0000
Subject: RE: [PATCH] sh: Add syscall entries for non multiplexed socket calls
Message-Id: <4C81667D7A02944B98C4DC6290A19E6CA11156BB6F@SAFEX1MAIL3.st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1283305771-31182-1-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1283305771-31182-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks Paul.

-----Original Message-----
From: Paul Mundt [mailto:lethal@linux-sh.org] 
Sent: Tuesday, September 14, 2010 10:43 AM
To: Carmelo AMOROSO
Cc: linux-sh@vger.kernel.org; Francesco RUNDO
Subject: Re: [PATCH] sh: Add syscall entries for non multiplexed socket calls

On Wed, Sep 01, 2010 at 03:49:29AM +0200, Carmelo AMOROSO wrote:
> Linux kernel already has socket syscalls that can be invoked
> without the multiplexing sys_socketcall wrapper.
> C library wrappers are ready to use them directly. It needs just
> to define the missing syscall numbers and provide the related entries
> into the syscalls table, like sh64 aleady does.
> 
> Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
> Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>

I've applied this now, with the addition of recvmmsg being wired up and
the ignore macro killed.

