From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 12 Sep 2013 10:57:20 +0000
Subject: [PATCH] regulator: da9210: add Device Tree binding documentation
Message-Id: <Pine.LNX.4.64.1309121254330.4632@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1378741920-11085-1-git-send-email-g.liakhovetski@gmx.de>
 <1378741920-11085-3-git-send-email-g.liakhovetski@gmx.de>
 <20130909160406.GS29403@sirena.org.uk>
In-Reply-To: <20130909160406.GS29403@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>

DA9210 Device Tree support currently only handles standard regulator DT
bindings. This patch adds compulsory minimal documentation to describe
this.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

On Mon, 9 Sep 2013, Mark Brown wrote:

> On Mon, Sep 09, 2013 at 05:52:00PM +0200, Guennadi Liakhovetski wrote:
> > This patch adds basic Device Tree support to the da9210 regulator driver -
> > with no special properties, since also driver's platform data only contains
> > standard regulator initialisation parameters.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >  drivers/regulator/da9210-regulator.c |    9 ++++++---
> 
> I'd expect to see a binding document, even if it is just a very brief
> one documenting the prefix and pointing to the standard regulator
> properties.

Hi Mark,
Is a separate patch like this one ok or you'd prefer me to re-post the 
original series and merge this with the DT implementation?

 .../devicetree/bindings/regulator/da9210.txt       |   21 ++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/da9210.txt

diff --git a/Documentation/devicetree/bindings/regulator/da9210.txt b/Documentation/devicetree/bindings/regulator/da9210.txt
new file mode 100644
index 0000000..f120f22
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/da9210.txt
@@ -0,0 +1,21 @@
+* Dialog Semiconductor DA9210 Voltage Regulator
+
+Required properties:
+
+- compatible:	must be "diasemi,da9210"
+- reg:		the i2c slave address of the regulator. It should be 0x68.
+
+Any standard regulator properties can be used to configure the single da9210
+DCDC.
+
+Example:
+
+	da9210@68 {
+		compatible = "diasemi,da9210";
+		reg = <0x68>;
+
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
-- 
1.7.2.5

