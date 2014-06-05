From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Thu, 05 Jun 2014 01:04:45 +0000
Subject: Re: [PATCH v2 7/8] ARM: shmobile: Make r8a7791 CPUFreq capable
Message-Id: <538FC22D.9000604@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <538DB98D.20009@bp.renesas.com>
In-Reply-To: <538DB98D.20009@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus-san,

Thank you for your feedback.
 

> Thanks for your patches. In general they look good, but I wonder about
> this Kconfig magic for r8a7790 and r8a7791.
>
> Instead of enabling the above for r8a7790 and r8a7791, how about
> enabling it for all SoCs included in ARCH_SHMOBILE_MULTI?

I will add this fix into ARCH_SHMOBILE_MULTI for all SoCs, and resend it.

Regards,
Inami

