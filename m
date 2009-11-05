From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 05 Nov 2009 08:01:19 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: Enable SPU2 clock when boot
Message-Id: <umy317640.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uocnifuik.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uocnifuik.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul and Magnus

> This is just doing an enable on init, so it's better to just flag this in
> the CPU code. ie:
(snip)
> Although this is going to be a nuisance for power management.

I'm 100% not sure about power management.
Is spu clock operation unnecessary if there is following ?

+	.archdata = {
+		.hwblk_id = HWBLK_SPU,
+	},

If so, please throw away this patch.

Best regards
--
Kuninori Morimoto
 
