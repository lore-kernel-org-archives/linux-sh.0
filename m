From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Mar 2011 08:38:27 +0000
Subject: Re: [PATCH] [rfc] mmc, ARM: Add zboot from eSD support for SuperH
Message-Id: <AANLkTinnc=w3Q1ytTDvy9nR=crKbdW3=A84xtu+jQn=-@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1299743892-3668-1-git-send-email-horms@verge.net.au>
	<AANLkTimiaTpz+Cjq_s0U=whNvwSAaZdk8UVKAS6mVkNC@mail.gmail.com>
	<20110310084158.GB6508@verge.net.au>
	<20110314012802.GD15317@verge.net.au>
In-Reply-To: <20110314012802.GD15317@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Simon,

On Mon, Mar 14, 2011 at 10:28 AM, Simon Horman <horms@verge.net.au> wrote:
> Hi Magnus,
>
> are the following also sh7372 specific?
>
> #define SDHI1_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0(void __iomem *)0xe6860000
> #define SDHI_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHI1_BASE

Yes, you want to specify the base address of the SDHI hardware block
instance in the cpu specific code.

Thanks,

/ magnus
