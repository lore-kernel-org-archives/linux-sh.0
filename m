From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 22 Aug 2013 21:19:13 +0000
Subject: [PATCH v5 0/3] R8A7779/Marzen R-Car VIN driver support
Message-Id: <201308230119.13783.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   [Resending with a real version #.]

   Here's the set of 3 patches against the Mauro's 'media_tree.git' repo's
'master' branch. Here we add the VIN driver platform code for the R8A7779/Marzen
with ADV7180 I2C video decoder.

[1/3] ARM: shmobile: r8a7779: add VIN support
[2/3] ARM: shmobile: Marzen: add VIN and ADV7180 support
[3/3] ARM: shmobile: Marzen: enable VIN and ADV7180 in defconfig

    Mauro has kindly agreed to merge this patchset thru his tree to resolve the
dependency on the driver's platform data header, provided that the maintainer
ACKs this. Simon, could you ACK the patchset ASAP -- Mauro expects to close his
tree for 3.12 this weekend or next Monday?

WBR, Sergei
