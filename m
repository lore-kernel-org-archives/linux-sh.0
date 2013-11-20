From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Nov 2013 08:18:45 +0000
Subject: Re: [PATCH 00/05] ARM: shmobile: r8a7790 and r8a7791 thermal update
Message-Id: <87li0j8p0d.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120075921.23557.23231.sendpatchset@w520>
In-Reply-To: <20131120075921.23557.23231.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, horms@verge.net.au, linux-sh@vger.kernel.org


Hi

> ARM: shmobile: r8a7790 and r8a7791 thermal update
> 
> [PATCH 01/05] ARM: shmobile: Add r8a7790 thermal device node to DTS
> [PATCH 02/05] ARM: shmobile: Add r8a7790 clocks for thermal devices
> [PATCH 03/05] ARM: shmobile: Add r8a7791 thermal device node to DTS
> [PATCH 04/05] ARM: shmobile: Add r8a7791 thermal platform device
> [PATCH 05/05] ARM: shmobile: Add r8a7791 clocks for thermal devices
> 
> Update the thermal support for the r8a7790 and the r8a7791 SoCs. As
> usual the code is split between the DT reference code and the legacy
> case. The DT reference code is written to be multiplatform aware and
> is used to point out the future direction. Hardware support may however
> be limited there due to lacking DT bindings.

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
