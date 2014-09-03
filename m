From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 03 Sep 2014 00:44:59 +0000
Subject: Re: [PATCH 1/7 v2] mmc: add blk_size_workaround for HW bug
Message-Id: <87d2bd7cs6.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87lhq2kcif.wl%kuninori.morimoto.gx@gmail.com>
	<87k35mkcgu.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFrFMCjKHDLYs=fZKuhf8VD-x+prvAok_2Ngn4vGc2x=hA@mail.gmail.com>
In-Reply-To: <CAPDyKFrFMCjKHDLYs=fZKuhf8VD-x+prvAok_2Ngn4vGc2x=hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Ulf

> > Current mmc block.c has MMC_CAP2_NO_MULTI_READ flag
> > for HW bug workaround, but it should be implemented
> > under driver, not framework.
> > This patch is prepare for it
> 
> I like the idea of this patchset!
> 
> Still, historically, we have been using MMC_CAP* to solve these kind
> issues. Therefore I think the commit message deserves a better
> explanation to why we invent a new host ops function pointer for this
> particular case.

Thank you for your feedback.
(Especially "English comment/naming" feedback is very useful for me :)
I send v3 patchset soon

Best regards
---
Kuninori Morimoto
