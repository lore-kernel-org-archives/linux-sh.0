From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 14 Jan 2014 18:54:07 +0000
Subject: Re: [PATCH V2 0/2] clk: shmobile: clk-mstp fixes
Message-Id: <52D587CF.2000308@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1388232549-6740-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388232549-6740-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 28/12/13 12:09, Valentine Barshak wrote:
> This fixes a number of issues with CPG MSTP clock array handling.
>
> Changes in V2:
> * removed brackets from the one-line for loop
>
> Valentine Barshak (2):
>    clk: shmobile: Fix MSTP clock index
>    clk: shmobile: Fix MSTP clock array initialization
>
>   drivers/clk/shmobile/clk-mstp.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)

Both look fine to me, both can have:
Tested-by: Ben Dooks <ben.dooks@codethink.co.uk>


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
