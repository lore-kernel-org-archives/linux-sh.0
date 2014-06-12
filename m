From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 12 Jun 2014 00:53:02 +0000
Subject: [PATCH] of: Add vendor 2nd prefix for Asahi Kasei Corp
Message-Id: <87sinbdk44.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com>	<87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>	<539815E6.2050304@codethink.co.uk>	<20140611165410.GK5099@sirena.org.uk>	<CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com>	<20140611170233.GL5099@sirena.org.uk>	<5398A53D.3020706@wwwdotorg.org>	<20140611190444.GN5099@sirena.org.uk>	<5398AB07.4040304@wwwdotorg.org>
In-Reply-To: <5398AB07.4040304@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, Simon <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Ben Dooks <ben.dooks@codethink.co.uk>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current vendor-prefixes.txt already has
"ak" prefix for Asahi Kasei Corp by
ae8c4209af2cec065fef15d200a42a04130799f7
(of: Add vendor prefix for Asahi Kasei Corp.)

It went through the appropriate review process,
and is already in use.
But, almost all Asahi Kasei chip driver is
using "asahi-kasei" prefix today.

Due to ABIness, this patch adds
"asahi-kasei" to vendor-prefixes.txt.
checkpatch.pl will report WARNING without this patch.
(DT compatible string vendor "asahi-kasei" appears un-documented)

OTOH, Asahi Kasei is usually referred as "AKM",
but this patch doesn't care about it.
Because no DT is using it today.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index abc3080..7e4bb83 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -17,6 +17,7 @@ amstaos	AMS-Taos Inc.
 apm	Applied Micro Circuits Corporation (APM)
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
+asahi-kasei	Asahi Kasei Corp.
 atmel	Atmel Corporation
 auo	AU Optronics Corporation
 avago	Avago Technologies
-- 
1.7.9.5

