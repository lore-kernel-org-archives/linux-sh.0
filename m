From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 29 Apr 2015 20:46:39 +0000
Subject: [PATCH v3 0/3] prototype: switch I2C IP cores at runtime (new approach)
Message-Id: <1430340402-21586-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

So, guys, since 4.1-rc1 is out and Pantelis managed to send me a patch fixing
the problem when destroying platform devices, here is the proto-prototype of an
IP core switcher using OF_DYNAMIC which enables/disables device nodes when the
IP core is switched. The drawback is:

- I2C slave devices need to be reinitialized, so no hot-switching.

However, IMO the advantages do outweigh this drawback a lot:

+ We are now much closer to the driver model, no reparenting hacks.

+ Parent<->child relations are proper, so things like PM should work as
  they do for ever other I2C mux.

+ Better upstream likeliness. No questionable patches for other subsystems.
  (There is one patch for of-base, but this is more an interface fixup IMO)

+ I think this approach is easier to migrate to other subsystems. It uses
  less I2C subsystem specific mux behaviour

+ The bus numbering is saner. No more n+1 new busses. Just the muxed one.
  The active parent keeps its usual number, passive parents are disabled
  and have no numbers at all.

There are still some TODOs and FIXMEs left. Especially the current switching
via sysfs is really proof-of-concept for now. But so far, it worked nice here.

Have fun with it,

   Wolfram

PS: Since these patches depend on a few others, I pushed out a branch here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/ip-core-switch-v2-on-4.1-experimental

Again, these patches go to sh-devel only, because of the very early status.


Wolfram Sang (3):
  of: WIP: make of_mutex public
  ARM: shmobile: r8a7790: lager: add i2c-demuxer to dts
  i2c: mux: demux-pinctrl: add driver

 .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  |  39 ++++
 arch/arm/boot/dts/r8a7790-lager.dts                | 129 ++++--------
 drivers/i2c/muxes/Kconfig                          |   7 +
 drivers/i2c/muxes/Makefile                         |   2 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c              | 224 +++++++++++++++++++++
 drivers/of/of_private.h                            |   1 -
 include/linux/of.h                                 |   2 +
 7 files changed, 313 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
 create mode 100644 drivers/i2c/muxes/i2c-demux-pinctrl.c

-- 
2.1.4

