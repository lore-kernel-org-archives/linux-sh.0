From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 12 Dec 2009 04:58:34 +0000
Subject: Re: [PATCH 0/3 v2] sh: fix dma driver
Message-Id: <e9c3a7c20912112058ga8427c8qc411c3b067cd1751@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912101826010.4487@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0912101826010.4487@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Thu, Dec 10, 2009 at 10:35 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Further testing with preempt enabled revealed more problems with
> insufficient locking and improper descriptor state management. Therefore
> I'm resubmitting the
>
> sh: fix DMA driver's descriptor chaining and cookie assignment
>
> patch. At the same time I swapped it with stylistic changes, to put the
> complex stuff in the end. Also added a minor patch fixing comment in
> dmaengine.h. Patches
>
> sh: DMA driver has to specify its alignment requirements
> dmaengine: fix dmatest to verify minimum transfer length and test buffer size
> sh: dmaengine support for sh7724
>
> are not changed, so, not resubmitted

Applied:
      sh: DMA driver has to specify its alignment requirements
      dmaengine: fix dmatest to verify minimum transfer length and
test buffer size
      sh: stylistic improvements for the DMA driver
      dmaengine: clarify the meaning of the DMA_CTRL_ACK flag

Waiting for Nobuhiro's ack on:
      sh: fix DMA driver's descriptor chaining and cookie assignment
      sh: dmaengine support for sh7724

Thanks,
Dan
