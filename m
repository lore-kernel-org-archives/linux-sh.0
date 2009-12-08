From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 08 Dec 2009 01:02:24 +0000
Subject: Re: [PATCH 5/5] sh: dmaengine support for sh7724
Message-Id: <e9c3a7c20912071702h1aea2026kff22db99a221f6c4@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912041936541.3981@axis700.grange>
	 <Pine.LNX.4.64.0912041942330.3981@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0912041942330.3981@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Fri, Dec 4, 2009 at 11:45 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Add a dmaengine platform device to sh7724, fix DMA channel interrupt numbers.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> With this patch dmatest works with channels 0-5, channels 6-11 still don't
> work for some reason... So, feel free to discard it for now, if a complete
> fix would be preferred.

Does this patch limit operation to channels 0-5?  I leave this one for
Paul to disposition.

Thanks,
Dan
