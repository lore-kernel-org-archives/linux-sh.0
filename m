From: Steve Kowalik <steven@wedontsleep.org>
Date: Fri, 24 Feb 2017 07:38:36 +0000
Subject: [PATCH 0/2] convert sh interfaces to RST
Message-Id: <1487921918-25203-1-git-send-email-steven@wedontsleep.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Convert the SuperH interfaces guide to RST, and add a new arch-guide to
place it into. I'm not hugely happy with the wording, but I've been sitting
on this long enough, and should get more eyes on it.

Steve Kowalik (2):
  Documentation: convert sh interfaces to RST
  Documentation: Add arch-guide documentation

 Documentation/00-INDEX             |   2 +
 Documentation/DocBook/Makefile     |   2 +-
 Documentation/DocBook/sh.tmpl      | 105 -------------------------------------
 Documentation/arch-guide/conf.py   |  10 ++++
 Documentation/arch-guide/index.rst |  14 +++++
 Documentation/index.rst            |  11 ++++
 Documentation/sh/interfaces.rst    |  63 ++++++++++++++++++++++
 7 files changed, 101 insertions(+), 106 deletions(-)
 delete mode 100644 Documentation/DocBook/sh.tmpl
 create mode 100644 Documentation/arch-guide/conf.py
 create mode 100644 Documentation/arch-guide/index.rst
 create mode 100644 Documentation/sh/interfaces.rst

-- 
2.7.4

