From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 12 Sep 2013 12:28:33 +0000
Subject: [PATCH v2 0/2] regulator: da9210: support Device Tree initialisation
Message-Id: <1378988915-10539-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

The first patch just adds a vendor prefix for Dialog Semiconductor PLC, the
second one actually implements DT support in da9210.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

v2: add DT documentation

Guennadi Liakhovetski (2):
  DT: add a vendor prefix for Dialog Semiconductor
  regulator: da9210: add Device Tree support

 .../devicetree/bindings/regulator/da9210.txt       |   21 ++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/regulator/da9210-regulator.c               |    9 +++++--
 3 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/da9210.txt

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
