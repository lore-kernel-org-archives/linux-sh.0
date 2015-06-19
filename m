From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 19 Jun 2015 10:40:30 +0000
Subject: [PATCH 0/2] new tool 'i2ctransfer'
Message-Id: <1434710432-4182-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org

So, here is my updated, better tested, much improved version of i2ctransfer:

* rewrote parser to match agreed syntax (even improved it futher by reusing
  last address if not specified again)

* fixed 0-byte length transfers

* way more error checking

* better error reporting

And further details and cleanups. I still believe we should let Linux clean up
the buffers, but I suspect Jean won't like it, so I added a patch to just do
that.

Please review, test, apply...

Thanks,

   Wolfram


Wolfram Sang (2):
  i2c-tools: add new tool 'i2ctransfer'
  i2c-tools: i2ctransfer: clean up allocated resources

 tools/Module.mk     |   8 +-
 tools/i2ctransfer.c | 330 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 337 insertions(+), 1 deletion(-)
 create mode 100644 tools/i2ctransfer.c

-- 
2.1.4

