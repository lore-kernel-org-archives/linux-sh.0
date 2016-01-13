From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 13 Jan 2016 14:29:26 +0000
Subject: [PATCH 0/3] i2c/of: switch I2C IP cores at runtime via OF_DYNAMIC
Message-Id: <1452695369-29413-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>

Here is the newest version of this patch series. Since Rob indicated to be OK
with the approach, I am brave and changed the status from RFC to PATCH.

This series allows an I2C bus to switch between multiple masters, i.e. a
n-to-1-demuxer. This is not hot-switching because connected I2C slaves will be
re-instantiated. It is meant to select the best I2C core at runtime once the
task is known. Example: Prefer i2c-gpio over another I2C core because of HW
errata affecting your current runtime configuration.

It works by using OF_DYNAMIC and en-/disabling the i2c parent as needed. See
the binding docs for more details. Because this is largely using OF_DYNAMIC, I
decided to post the whole series to the dt list.

Changes since RFC v2:

* updated docs (sysfs file now described in ABI/testing)
* depends now on OF (thanks buildbot)
* removed mutex handling. This creates a dependency on this patch which adds
  what we need to of-core (thanks Rob):
	https://patchwork.ozlabs.org/patch/539938/
* sysfs-store: use uint instead of ulong (thanks Geert)
* removed typos from commit messages (thanks Geert and Rob)

Changes since RFC v1:

* gracefully handle if i2c adapters are not present at runtime
  (driver not loaded yet)
* added more documentation and examples
* properly put the i2c adapters after use
* respect PAGE_SIZE in sysfs_show

This has been tested on a Renesas Lager board switching between i2c-gpio and
two different IP cores (i2c-rcar and i2c-sh_mobile). The rebinding seems to be
working as expected. However, in practice, I couldn't use the HDMI i2c slaves
with another controller yet, because the rcar-du driver OOPSes when unbinding.
This seems unrelated to this series because it can also be triggered via
sysfs-unbind. soc-camera also had problems properly cleaning up on unbind, a
patch for this already has been sent. So, this series is for sure a good test
for the unbind path of drivers.

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/ip-core-switch-on-4.4

Let me know what you think.

Thanks,

   Wolfram

Wolfram Sang (3):
  dt-bindings: i2c: mux: demux-pinctrl: add bindings
  i2c: mux: demux-pinctrl: add driver
  ARM: shmobile: r8a7790: rework dts to use i2c demuxer

 .../ABI/testing/sysfs-platform-i2c-demux-pinctrl   |  23 ++
 .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  | 136 +++++++++++
 arch/arm/boot/dts/r8a7790-lager.dts                | 141 +++++++----
 drivers/i2c/muxes/Kconfig                          |   9 +
 drivers/i2c/muxes/Makefile                         |   2 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c              | 272 +++++++++++++++++++++
 6 files changed, 530 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-i2c-demux-pinctrl
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
 create mode 100644 drivers/i2c/muxes/i2c-demux-pinctrl.c

-- 
2.1.4

