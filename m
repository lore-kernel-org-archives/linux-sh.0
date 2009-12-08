From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 08 Dec 2009 01:09:37 +0000
Subject: Re: [PATCH 0/5] sh: fix the shdma driver, improve dmatest, support
Message-Id: <e9c3a7c20912071709s200074bbhe6ce07c22fcdbb55@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912041936541.3981@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0912041936541.3981@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Fri, Dec 4, 2009 at 11:44 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Hi
>
> Not all of these patches are connected, only the ones, affecting the same
> file should be applied in a specific order, otherwise the patches are
> independent and can be applied separately.

I'll take 1 and 2 straight away, 4 with the bool fixup and a changelog
explaing the dmae_is_idle() change, and 3 after an ack from Nobuhiro
(or when I get a chance to look at it a bit deeper).

Thanks,
Dan
