From: Steve Kowalik <steven@wedontsleep.org>
Date: Thu, 19 Jan 2017 22:06:41 +0000
Subject: [PATCH 0/1] Documentation: convert sh interfaces to RST
Message-Id: <1484863602-27393-1-git-send-email-steven@wedontsleep.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

The following patch converts the SuperH interfaces DocBook into RST,
however, I've not added it to the toctree, since I'm not 100% clear
where it best fits.

Steve Kowalik (1):
  Documentation: convert sh interfaces to RST

 Documentation/DocBook/Makefile  |   2 +-
 Documentation/DocBook/sh.tmpl   | 105 ----------------------------------------
 Documentation/sh/interfaces.rst |  59 ++++++++++++++++++++++
 3 files changed, 60 insertions(+), 106 deletions(-)
 delete mode 100644 Documentation/DocBook/sh.tmpl
 create mode 100644 Documentation/sh/interfaces.rst

-- 
2.7.4

