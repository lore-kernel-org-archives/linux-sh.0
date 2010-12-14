From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Dec 2010 08:53:26 +0000
Subject: Re: [PATCH (sh-2.6)] sh: wire up accept4 syscall (non-multiplexed path)
Message-Id: <20101214085326.GA14606@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1292235626-23589-1-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1292235626-23589-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 13, 2010 at 11:20:26AM +0100, Carmelo AMOROSO wrote:
> Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
> ---
>  arch/sh/include/asm/unistd_32.h |    3 ++-
>  arch/sh/kernel/syscalls_32.S    |    1 +
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
Applied, thanks.
