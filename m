From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 08 Sep 2014 08:06:26 +0000
Subject: Re: [PATCH] mmc: tmio: enable odd number size transfer
Message-Id: <87ppf6o7sw.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq9eohuc.wl%kuninori.morimoto.gx@gmail.com>
	<CAMuHMdUJK1Mmd_S+-hGFoshgRbpHKG5OH2w7AFHNaQG5qyvNaw@mail.gmail.com>
	<87r3zmo969.wl%kuninori.morimoto.gx@gmail.com>
	<CAMuHMdVqFvgPBVenEnoRfpDyMSc_z+9EEF19VHM8CESXmBwFMQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVqFvgPBVenEnoRfpDyMSc_z+9EEF19VHM8CESXmBwFMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Geert

> If count is even, we never get that far, so the even numbers should not
> be present in your table above?
> 
> If count is odd, "(count - 1) >> 1 = count >> 1".

Ahh, yes, indeed.

About endianness / byte access, it requires byte access
especially "read" case.
Because if count was odd number,
using shift with u16 will might be buffer overflow

I need to check cpu_to_le16() / le16_to_cpu()

Best regards
---
Kuninori Morimoto
