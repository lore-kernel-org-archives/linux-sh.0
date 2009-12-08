From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 08 Dec 2009 00:54:17 +0000
Subject: Re: [PATCH 4/5] sh: stylistic improvements for the DMA driver
Message-Id: <e9c3a7c20912071654y19313fd5j6d9ff5a62cde028e@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912041936541.3981@axis700.grange>
	 <Pine.LNX.4.64.0912041942040.3981@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0912041942040.3981@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Fri, Dec 4, 2009 at 11:45 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0drivers/dma/shdma.c | =A0 34 +++++++++++++++++-----------------
> =A0drivers/dma/shdma.h | =A0 14 +++++++-------
> =A02 files changed, 24 insertions(+), 24 deletions(-)
>
[..]
> -static int dmae_is_idle(struct sh_dmae_chan *sh_chan)
> +static int dmae_is_busy(struct sh_dmae_chan *sh_chan)

This one isn't purely style, I agree with it, but think it would be a
bit cleaner to return a bool rather than an error code.

--
Dan
