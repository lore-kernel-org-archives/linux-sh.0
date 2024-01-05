Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7294249FA
	for <linux-sh@vger.kernel.org>; Fri,  5 Jan 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j1jqi5eZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04446C433C7;
	Fri,  5 Jan 2024 09:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704446238;
	bh=8RawTng96j6usboDPYnTuXRFNsRgKgbMmc/lbSET7rg=;
	h=Subject:To:From:Date:From;
	b=j1jqi5eZJl+XA/YhZhs+Pya6TL6XcKprf6RhixmYCihnbE5SgpEsroKmOTB0DxVso
	 DEaWJO9KjgTTuEEaqmQoJPbLy6SHYGj/hRYvClkzxUluNS8qE/B1Jr0YvJl3+g48B0
	 VuEU2jt6ATMennJ2+JjAUpLNSEtcdGPaCCcDBiNg=
Subject: patch "maple: make maple_bus_type static and const" added to char-misc-next
To: gregkh@linuxfoundation.org,dalias@libc.org,glaubitz@physik.fu-berlin.de,linux-sh@vger.kernel.org,ysato@users.sourceforge.jp
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jan 2024 10:17:15 +0100
Message-ID: <2024010515-senorita-valid-1ee0@gregkh>
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
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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


