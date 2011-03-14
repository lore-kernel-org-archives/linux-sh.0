From: Simon Horman <horms@verge.net.au>
Date: Mon, 14 Mar 2011 01:28:18 +0000
Subject: Re: [PATCH] [rfc] mmc, ARM: Add zboot from eSD support for SuperH
Message-Id: <20110314012802.GD15317@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1299743892-3668-1-git-send-email-horms@verge.net.au>
 <AANLkTimiaTpz+Cjq_s0U=whNvwSAaZdk8UVKAS6mVkNC@mail.gmail.com>
 <20110310084158.GB6508@verge.net.au>
In-Reply-To: <20110310084158.GB6508@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Magnus,

are the following also sh7372 specific?

#define SDHI1_BASE              (void __iomem *)0xe6860000
#define SDHI_BASE                SDHI1_BASE

