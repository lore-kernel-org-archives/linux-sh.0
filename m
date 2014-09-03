From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 03 Sep 2014 19:57:21 +0000
Subject: Re: [PATCH] clk-rcar-gen2: RCAN clock support
Message-Id: <540772A1.8080101@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407310023.43605.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407310023.43605.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mturquette@linaro.org, linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, vksavl@gmail.com

Hello.

On 07/31/2014 12:23 AM, Sergei Shtylyov wrote:

> Add RCAN clock support to the R-Car generation 2 CPG driver. This clock gets
> derived from the USB_EXTAL clock by dividing it by 6. The layout of RCANCKCR
> register is close to those of the clocks supported by the 'clk-div6'  driver
> but has no divider field, and so can't be supported by that driver...

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> The patch is against the 'clk-next' branch of Mike Turquette's 'linux.git' repo.

>   drivers/clk/shmobile/clk-rcar-gen2.c |   99 +++++++++++++++++++++++++++++++++++
>   1 file changed, 99 insertions(+)

    More than a months has passed, there hasn't been any feedback, patch 
hasn't been applied... what's wrong with it?

WBR, Sergei

