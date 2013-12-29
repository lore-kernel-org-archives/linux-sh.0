From: Mike Turquette <mturquette@linaro.org>
Date: Sun, 29 Dec 2013 21:54:42 +0000
Subject: Re: [PATCH V2 0/2] clk: shmobile: clk-mstp fixes
Message-Id: <20131229215442.12054.41926@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <1388232549-6740-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388232549-6740-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Quoting Valentine Barshak (2013-12-28 04:09:07)
> This fixes a number of issues with CPG MSTP clock array handling.

Thanks for the quick respin. Taken into clk-next.

Regards,
Mike

> 
> Changes in V2:
> * removed brackets from the one-line for loop
> 
> Valentine Barshak (2):
>   clk: shmobile: Fix MSTP clock index
>   clk: shmobile: Fix MSTP clock array initialization
> 
>  drivers/clk/shmobile/clk-mstp.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> -- 
> 1.8.3.1
> 
