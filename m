From: Simon Horman <horms@verge.net.au>
Date: Mon, 10 Nov 2014 00:41:49 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: kzm9g-reference: Add restart callback
Message-Id: <20141110004149.GA16836@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1385428879-26849-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385428879-26849-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 07, 2014 at 04:53:31PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/7/2014 4:46 PM, Geert Uytterhoeven wrote:
> 
> >Port the sh73a0 restart handling from the kzm9g-legacy board code to the
> >kzm9g-reference board code.
> 
> >Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >---
> >Tested on kzm9g-reference
> >
> >  arch/arm/mach-shmobile/board-kzm9g-reference.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> >diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> >index f2ef759b6e969cc8..2e82e44ab85258b7 100644
> >--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> >+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> >@@ -39,6 +39,13 @@ static void __init kzm_init(void)
> >  #endif
> >  }
> >
> >+#define RESCNT2 IOMEM(0xe6188020)
> >+static void kzm9g_restart(enum reboot_mode mode, const char *cmd)
> >+{
> >+	/* Do soft power on reset */
> >+	writel((1 << 31), RESCNT2);
> 
>    Inner () should not be needed.

Over in the purple bike shed someone told me that all the cool kids
are using BIT(31) these days.
