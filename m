From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Mon, 02 Jun 2014 03:14:22 +0000
Subject: Re: [PATCH 3/7] ARM: shmobile: Disable DVS support for r8a7790
Message-Id: <538BEC0E.8090000@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5386E66D.3020502@bp.renesas.com>
In-Reply-To: <5386E66D.3020502@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert

Thank you for your feedback.

> The role of the DT is to describe the hardware.
> Not using DVS because the effect of power consumption is low or non-existent
> is a software policy.
>
> So perhaps it should be kept?

I understand what you mean. I will keep the setting of VDD into DT, 
and consider to disable DVS in a different way.

