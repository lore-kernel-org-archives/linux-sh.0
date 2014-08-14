From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Aug 2014 05:34:56 +0000
Subject: Re: [PATCH 0/4] ARM: shmobile: Remove unneeded nr_irqs initialization
Message-Id: <20140814053455.GB26709@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1407931199-11756-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1407931199-11756-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 13, 2014 at 01:59:59PM +0200, Geert Uytterhoeven wrote:
> This patch series removes the remaining initializations of
> machine_desc.nr_irqs, which are unneeded as they match the default value.
> 
> As per arch_probe_nr_irqs(), the default value is NR_IRQS, which maps to
> NR_IRQS_LEGACY if CONFIG_SPARSE_IRQ=y.
> 
> Since SPARSE_IRQ is selected by both ARCH_MULTIPLATFORM and
> ARCH_SHMOBILE_LEGACY, it's always enabled on shmobile.

Thanks. I have queued these up as cleanups for v3.18.
