From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Sep 2010 02:54:29 +0000
Subject: Re: [PATCH] sh: Remove unused __IGNORE_recvmmsg macro.
Message-Id: <20100902025429.GC10947@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1283306055-761-1-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1283306055-761-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 01, 2010 at 03:54:15AM +0200, Carmelo AMOROSO wrote:
> Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
> ---
>  arch/sh/include/asm/unistd_32.h |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/include/asm/unistd_32.h b/arch/sh/include/asm/unistd_32.h
> index a683d2f..4769278 100644
> --- a/arch/sh/include/asm/unistd_32.h
> +++ b/arch/sh/include/asm/unistd_32.h
> @@ -372,8 +372,6 @@
>  
>  #ifdef __KERNEL__
>  
> -#define __IGNORE_recvmmsg
> -
>  #define __ARCH_WANT_IPC_PARSE_VERSION
>  #define __ARCH_WANT_OLD_READDIR
>  #define __ARCH_WANT_OLD_STAT

Your patch wiring up the broken out syscalls does not wire up recvmmsg,
so could you explain your reasoning for why you think this is unused?
