From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Oct 2009 22:38:45 +0000
Subject: Re: [PATCH] sh4: fix watchdog timer for sh7780/sh7785
Message-Id: <20091026223845.GB16759@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1255689947-25421-1-git-send-email-valentin.sitdikov@siemens.com>
In-Reply-To: <1255689947-25421-1-git-send-email-valentin.sitdikov@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 16, 2009 at 02:45:47PM +0400, Valentin Sitdikov wrote:
> 
> Signed-off-by: Valentin Sitdikov <valentin.sitdikov@siemens.com>
> ---
>  arch/sh/include/asm/watchdog.h         |   59 +++++++++++++++++++++++++++++++-
>  arch/sh/include/cpu-sh4/cpu/watchdog.h |   13 +++++++
>  2 files changed, 71 insertions(+), 1 deletions(-)
> 
Applied, thanks.
