From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 07 Mar 2012 05:55:52 +0000
Subject: Re: [PATCH RESEND] sh: add platform_device for RSPI in setup-sh7757
Message-Id: <20120307055551.GB10151@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F56F641.4030809@renesas.com>
In-Reply-To: <4F56F641.4030809@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 07, 2012 at 02:46:41PM +0900, Shimoda, Yoshihiro wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
I wasn't going to bother applying this until the actual driver itself had
been merged. Obviously we can merge the data regardless, as it doesn't
depend on any headers or anything, but it would be pointless if changes
have to be made to the driver first.
