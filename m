From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Feb 2013 00:34:59 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: armadillo800eva: enable branch prediction on defconfig
Message-Id: <87ip5hfcy8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1351731731-8435-3-git-send-email-horms@verge.net.au>
In-Reply-To: <1351731731-8435-3-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > Because defconfig disabled ARM branch prediction
> > by CONFIG_CPU_BPREDICT_DISABLE,
> > Armadillo800eva's Bogomips and Loop were not good performance.
> > This patch enabled Arm branch prediction.
> > Special thanks to Ishiyama-san
> > 
> > Reported-by: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Thanks,
> 
> should this change also be made to ag5evm_defconfig and kota2_defconfig?
> 
> Or alternatively, should we remove those boards from upstream?
> * Since the following commit added for 3.8-rc1 kota2 does not appear to boot:
>   - b8b499c86be58cb309964fcab5b62ac4a240a878
>     "ARM: 7602/1: Pass real "__machine_arch_type" variable to
>     setup_machine_tags() procedure"

Really ?
I could find kota2 on mach-type.h though...

kota2			MACH_KOTA2		KOTA2			3616

> * I have no way to test ag5evm nor am I aware of anyone who is testing
>   that board

In my opinion, we should keep these defconfigs
even though it seems no one seems testing/using it.

 - Not all user are working with this ML.
 - These code can be "good sample code" even though there is no user

Best regards
---
Kuninori Morimoto
