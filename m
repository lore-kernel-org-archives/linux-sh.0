From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 12 Jan 2012 01:11:37 +0000
Subject: Re: [PATCH v4 3/6] arm: mach-shmobile: add a resource name for shdma
Message-Id: <20120112011137.GB7281@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0D39FE.1090900@renesas.com>
In-Reply-To: <4F0D39FE.1090900@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 11, 2012 at 04:27:58PM +0900, Shimoda, Yoshihiro wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  about v4:
>   - use defination macros for IRQ resource
> 
>  arch/arm/mach-shmobile/setup-sh7372.c |    8 ++++++++
>  arch/arm/mach-shmobile/setup-sh73a0.c |    2 ++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
I'll just be applying the original two with the strings written out, you
can figure out how you want to deal with the rest of the series on top of
that.
