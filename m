Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73838224C6
	for <linux-sh@vger.kernel.org>; Thu,  4 Jan 2024 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rALK6fip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB10C433C8;
	Thu,  4 Jan 2024 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704375461;
	bh=Es3c8xTk+3h7eXuY7sGw+ixfvwhMqIihP496lSE4sT0=;
	h=Subject:To:From:Date:From;
	b=rALK6fip4jH37eX22cn7Dg/QeoRHoNvgr7nGTsdqdXiHmf4kx2xVYjJgkhk5hUQ7+
	 +fgGjtceCBcWbrsyNhgVxRvgIDzQh7d3fKduhYjUT6ADwduW9+yh6YC4k6fi+CdnlL
	 KqrixIhMZlhOWr1N0JA9eFg9nmPVjY39iN7A0pxA=
Subject: patch "maple: make maple_bus_type static and const" added to char-misc-testing
To: gregkh@linuxfoundation.org,dalias@libc.org,glaubitz@physik.fu-berlin.de,linux-sh@vger.kernel.org,ysato@users.sourceforge.jp
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jan 2024 14:37:39 +0100
Message-ID: <2024010439-cauterize-trash-b603@gregkh>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    maple: make maple_bus_type static and const

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From e76933a9bfa9b7f28a387f2e13cb3e689adc200d Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 19 Dec 2023 15:06:19 +0100
Subject: maple: make maple_bus_type static and const

There is no need to export maple_bus_type as no one uses it outside of
maple.c, so make it static, AND make it const as it can be read-only as
no one modifies it.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: <linux-sh@vger.kernel.org>
Link: https://lore.kernel.org/r/2023121918-rejoicing-frostlike-d976@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/sh/maple/maple.c | 4 ++--
 include/linux/maple.h    | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index e05473c5c267..16018009a5a6 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -59,6 +59,7 @@ struct maple_device_specify {
 static bool checked[MAPLE_PORTS];
 static bool empty[MAPLE_PORTS];
 static struct maple_device *baseunits[MAPLE_PORTS];
+static const struct bus_type maple_bus_type;
 
 /**
  * maple_driver_register - register a maple driver
@@ -773,11 +774,10 @@ static struct maple_driver maple_unsupported_device = {
 /*
  * maple_bus_type - core maple bus structure
  */
-struct bus_type maple_bus_type = {
+static const struct bus_type maple_bus_type = {
 	.name = "maple",
 	.match = maple_match_bus_driver,
 };
-EXPORT_SYMBOL_GPL(maple_bus_type);
 
 static struct device maple_bus = {
 	.init_name = "maple",
diff --git a/include/linux/maple.h b/include/linux/maple.h
index 9b140272ee16..9aae44efcfd4 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -5,7 +5,6 @@
 #include <mach/maple.h>
 
 struct device;
-extern struct bus_type maple_bus_type;
 
 /* Maple Bus command and response codes */
 enum maple_code {
-- 
2.43.0


