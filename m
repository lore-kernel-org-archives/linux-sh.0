From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 12 Feb 2014 01:27:27 +0000
Subject: [PATCH 2/2] regulator: gpio: explain detail of gpios-states
Message-Id: <87ha859l37.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87eh3o7mfc.wl%kuninori.morimoto.gx@gmail.com>
	<20140204184327.GS22609@sirena.org.uk>
In-Reply-To: <20140204184327.GS22609@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

gpios-states is array, and default is 0

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../bindings/regulator/gpio-regulator.txt          |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
index 3ecb585..356e8bb 100644
--- a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
@@ -8,7 +8,8 @@ Required properties:
 Optional properties:
 - enable-gpio		: GPIO to use to enable/disable the regulator.
 - gpios			: GPIO group used to control voltage.
-- gpios-states		: gpios pin's initial states. 1 means HIGH
+- gpios-states		: gpios pin's initial states array. 0: LOW, 1: HIGH.
+			  defualt is LOW if nothing is specified.
 - startup-delay-us	: Startup time in microseconds.
 - enable-active-high	: Polarity of GPIO is active high (default is low).
 
-- 
1.7.9.5

