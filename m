From: Xiubo Li <Li.Xiubo@freescale.com>
Date: Mon, 01 Sep 2014 04:29:34 +0000
Subject: [PATCHv1 0/7] simple-card: simplify the code.
Message-Id: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, jsarha-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>


Change in v1:
- Add simple-card dts node patches.
- Fix format parsing bug from Jean-Francois's comment.
- Rebase to Kuninori-san's newest changes in next branch.


Xiubo Li (7):
  ASoC: simple-card: Merge single and muti DAI link code.
  ASoC: simple-card: Adjust the comments of simple card.
  ASoC: dts: vf610-twr: To support simple card newest style.
  ASoC: dts: kirkwood-t5325: To support simple card newest style.
  ASoC: dts: r8a7740-armadillo800eva-reference: To support simple card
    newest style.
  ASoC: dts: sh73a0-kzm9g-reference: To support simple card newest
    style.
  ASoC: dts: kirkwood-openrd-client: To support simple card newest
    style.

 .../devicetree/bindings/sound/simple-card.txt      | 101 ++++++------
 arch/arm/boot/dts/kirkwood-openrd-client.dts       |  15 +-
 arch/arm/boot/dts/kirkwood-t5325.dts               |  15 +-
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  21 +--
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |  18 ++-
 arch/arm/boot/dts/vf610-twr.dts                    |  17 +-
 sound/soc/generic/simple-card.c                    | 176 ++++++++-------------
 7 files changed, 160 insertions(+), 203 deletions(-)

-- 
1.8.4

