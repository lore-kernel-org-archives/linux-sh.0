From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Sat, 13 May 2017 11:10:53 +0000
Subject: [PATCH 0/5] Convert more books to ReST
Message-Id: <cover.1494672881.git.mchehab@s-opensource.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brian Norris <computersforpeace@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Markus Heiser <markus.heiser@darmarit.de>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, "Herton R. Krzesinski" <herton@redhat.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, David Woodhouse <dwmw2@infradead.org>, Rich Felker <dalias@libc.org>, Silvio Fricke <silvio.fricke@gmail.com>, sayli karnik <karniksayli1995@gmail.com>, linux-security-module@vger.kernel.org

This patch series convert the following books to ReST:
	- librs
	- mtdnand
	- sh

And it is based on my previous series of conversion patches.

After this series, there will be just one DocBook pending conversion:
	- lsm (Linux Security Modules)

This book is very outdated: no changes since the Kernel moved 
to git, in 2005 (except for a minor editorial fix in 2008).

I took a look on the described API: it doesn't seem to be describing
the current security implementation.

The best here is if someone that works with LSM to convert it to
ReST with:
	$ Documentation/sphinx/tmplcvt Documentation/DocBook/lsm.tmpl lsm.rst

And fix the document to produce something that reflects the current
implementation. If nobody is interested, then maybe we could just
drop it.

-

This patch series is based on my past 00/36 patch series, applied on
the top of docs tree (next branch).

The full patch series is on this tree is at:

   https://git.linuxtv.org//mchehab/experimental.git/log/?h=docbook

And the HTML output at:

  http://www.infradead.org/~mchehab/kernel_docs/
  https://mchehab.fedorapeople.org/kernel_docs/ 

Mauro Carvalho Chehab (5):
  docs-rst: convert librs book to ReST
  docs-rst: convert mtdnand book to ReST
  mtdnand.rst: Fix some typos and group the "::" with previous line
  mtd: adjust kernel-docs to avoid Sphinx/kerneldoc warnings
  docs-rst: convert sh book to ReST

 Documentation/DocBook/Makefile       |    5 +-
 Documentation/DocBook/librs.tmpl     |  289 --------
 Documentation/DocBook/mtdnand.tmpl   | 1291 ----------------------------------
 Documentation/DocBook/sh.tmpl        |  105 ---
 Documentation/conf.py                |    2 +
 Documentation/core-api/index.rst     |    1 +
 Documentation/core-api/librs.rst     |  212 ++++++
 Documentation/driver-api/index.rst   |    1 +
 Documentation/driver-api/mtdnand.rst | 1007 ++++++++++++++++++++++++++
 Documentation/index.rst              |   11 +
 Documentation/sh/index.rst           |   59 ++
 drivers/mtd/nand/nand_base.c         |    7 +-
 include/linux/mtd/nand.h             |    2 +-
 13 files changed, 1300 insertions(+), 1692 deletions(-)
 delete mode 100644 Documentation/DocBook/librs.tmpl
 delete mode 100644 Documentation/DocBook/mtdnand.tmpl
 delete mode 100644 Documentation/DocBook/sh.tmpl
 create mode 100644 Documentation/core-api/librs.rst
 create mode 100644 Documentation/driver-api/mtdnand.rst
 create mode 100644 Documentation/sh/index.rst

-- 
2.9.3


