From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 31 Jul 2014 04:34:12 +0000
Subject: Re: [PATCH 0/10 v2] mmc: tmio: fixup patches
Message-Id: <87k36uuoxq.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>
	<87simtenpi.wl%kuninori.morimoto.gx@renesas.com>
	<cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>
	<87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>
	<53AD638C.5060907@renesas.com>
	<87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
	<87mwbso8sp.wl%kuninori.morimoto.gx@gmail.com>
	<53D9A148.1000802@jinso.co.jp>
	<20140731023037.GC2558@verge.net.au>
	<53D9C5A3.8090908@jinso.co.jp>
In-Reply-To: <53D9C5A3.8090908@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cm-hiep@jinso.co.jp
Cc: Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, "(Renesas)goda" <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, ryo.kataoka.wt@renesas.com, shinobu.uehara.xc@renesas.com, kouei.abe.cp@renesas.com


Hi

> >>> These are v2 of fixup patches for mmc tmio/shmobile.
> >>> I tesed these patches on my environment.
> >>> I'm very happy if someone test these patches.
> >> I have just tested these series on Lager. if remove CONFIG_HIGHMEM from
> >> config file,
> >> They are good at SDHI and MMC on my environment.
> > Could you provided a Tested-by tag?
> Tested-by: Nguyen Xuan Nui <nx-nui@jinso.co.jp>
> Reported-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>

I guess, both "Tested-by" is correct :)

  Tested-by: Nguyen Xuan Nui <nx-nui@jinso.co.jp>
  Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>

# "Reported-by" means "bug report", not "test report"

Best regards
---
Kuninori Morimoto
