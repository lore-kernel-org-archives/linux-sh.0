From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Mar 2013 08:33:45 +0000
Subject: Re: [PATCH 0/3 v2] ARM: shmobile: add R8A7778 Bock-W board support
Message-Id: <87boaprp96.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hakhrpmn.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hakhrpmn.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> Bock-W board needs ${LINUX}/arch/arm/tools/mach-types
> 
> bockw                  MACH_BOCKW              BOCKW                   3386

Sorry, this was wrong.
It is not needed on DT.

Best regards
---
Kuninori Morimoto
