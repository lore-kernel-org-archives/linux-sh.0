From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 05 Dec 2012 01:42:27 +0000
Subject: [PATCH 0/1] ARM: shmobile: sh73a0: fixup div4 bitmask
Message-Id: <87fw3lnuki.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Magnus

I guess currect div4_clks bitmap on sh73a0 was wrong.
This patch fixes it. it is based on v2.0 datasheet.

>> Magnus

Could you please check this patch ?
and give it your Acked-by if you can agree.

BTW, v2.0 datasheet shows FRQCRA : ZGFC 1010 is 1/5,
but I guess it is 1001 ?
I'm not sure...
current code is still keeping 1010 but...
