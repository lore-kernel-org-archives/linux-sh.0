Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E4C38888C
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144655; cv=none; b=HmwBWdrZpyb0TGaqCQ+6c7uUP+heOW7EOKA9Pwwfi4+53amLvjdIor1olKEG+1J+E/p9vX0XuE2wx5aG/ML+V9fXq7yWSp5+yuoLN4dRdOt4Pt1cxu58tNzauIWZ7o0K3c7qtBHWS1Z5a0ED/woxfriDanOgYgLvUBcXrVTNZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144655; c=relaxed/simple;
	bh=Ix7/Y+EVEU+dwYPaF05H+bOo4qBH5GMr0TAV7TzgV/0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jS7J3SmJGnM8Fwc01CfeWw5CJQiawjTK5YiKqeey6wXglv2kjiTSvWQcFjCLOB+/Ioe99t02JMyi1stR5QDTv1lE4iVcv7NacWZQNIVsfUNNTkBnWH5ale4bOrJxLhXnmgj8rWdLuNX9vrWIbhjnTR5/5c49yBx6yokT93hSlk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sirSMUFy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sirSMUFy"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37f816d01e3so1292902a91.2
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144653; x=1783749453; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+rvElI5DJc+LADkj/yI5i5ZTCILlIx+N3s68Xcqphs=;
        b=sirSMUFyc+mPqhNdNVT4usAvQ6eTAPsTEAYqeiUD7wzSPDPvw355bFs2iO7Sb01BA9
         HLRBm6KHqqr9BfI6QXa2OjyTL04RVO1MFskDl1unSH00IyQwH6Jx9BSofL5BrhdYnayw
         vZzvJeuCkdE/w0VZpzt7eDGil1MsY5x5Kao668Tz2kBTrL6xKTSgl0K6o976PfFb8TFq
         TEBp9Jr6Gsu+s7wiIvedTIsJQNQgY6dwvlQq1wdx8Dd3OgrVnic6VLcyryXtRn6s/Qz5
         XnoB+dpbzHqcAWDkViV4qsajYAorobYQUfSc5TPG7KiRHXIqw12j5a8RzNMER9wTqhOY
         m9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144653; x=1783749453;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+rvElI5DJc+LADkj/yI5i5ZTCILlIx+N3s68Xcqphs=;
        b=SNExQoGPok5gaspB8Vu4EkokH4iNYHEODNCTcZRCuF8kGLoglEDl0Ql2mv9Sz0uPpg
         9CBFcUlHsfqdRD6RMbJn0nTYezNhR3tzBWj8O9AXSpLjmpsG7NMWoKLsZx9N3fneoZPm
         5QiTX7oOYtsH/o5JcKbrCBmfLCyIK4PoQ01VSG5P6+YOmt1ibBnO88eh4B0ltojWmjVL
         8vwR91P0mtNs168Q/aRigNuhyXjINIXyadJDQfbC9gWwK0BWLZoJnJtf1dMrsH/j+6gO
         wA3sjXFVzUO0M6VKYh7fTtaGdtn+I1t2YvDJyXe9Z/3Vdmi2waJCc1E93+coBJBqg6A4
         2Tpw==
X-Forwarded-Encrypted: i=1; AHgh+RpfiQsqMB67r3cA+W7zknUu49XhBT29mBWkB20esEaZb2D48sGex9E/4gjSTrOycRNFFuwco/WiHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUjBip5EC+Puqlluqp7baHOUkiH9sltIcXrnsoGBpoFx/wYcu+
	2D5HYAj1/WmaFQ/eUcywBWprGuweyun0S5epfx4iD5qrW8VdYqUX2VR5
X-Gm-Gg: AfdE7ckMIQtyLrUOQGKnVVNCRfn1wVQLEtlfs8c+4nz6tcaizR+DIH6X8ClZaxS7lzM
	Zew6lDHIA2/Xy89ZByrZK4J4h2vbIOLCUaxx9f+0GP5dM0mS4/MWBkTglhYTAmu0KeEl/hddnii
	+FGq0dybVxcWeVApudzVy43ntkQ7SjwVpkEo9EZK/00ejxt2uS1NxRVNEh94ja3TytHjnUEx5HM
	P4i6o+5p3cJxKq16k4cIuOyKl96Ogaa9s1ilUJ48t1blcNawgH8ss9VhNaLC/rozGcbbMT3MKfc
	pqj2gdTRZGKsRVCWN+7D4n1X48An1BnrH8JxN2QgmaGWK5WTDpa9VoVqjX6SP57Xn8G6xrUaQt1
	Ug/GXb5Y6KkawiIowKqzIngBI9s2RxmEvlaFCqKg2stc8TQflvppVzscOQnBhEJwCvsXOJiKCbj
	RJVFj+yPgIho9A1eAf69yNPYdjVKPyO/63le9MWmXVq3lSl+Ms/pnSM6EvO2u0UwvV8AN6FeNK2
	7E=
X-Received: by 2002:a17:90b:17c4:b0:380:40b:f30a with SMTP id 98e67ed59e1d1-38280d99e12mr2630038a91.13.1783144652797;
        Fri, 03 Jul 2026 22:57:32 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:32 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 00/26] sh: maple: cleanup and modernize input drivers
Date: Fri, 03 Jul 2026 22:57:23 -0700
Message-Id: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMSgSGoC/yXMQQrCMBBG4auUWTuQhhKGXqW4SOKvTmljSKwIp
 Xc36vJbvLdTRVFUGrudCl5a9ZEa+lNH8e7TDayXZrLGOuOscBh49XkBxwU+bZlFBifWozcSqGW
 54Krv33I6/123MCM+vx86jg9nwHB4dAAAAA==
X-Change-ID: 20260628-b4-maple-cleanup-884682ae108b
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

This series aims to modernize the Maple bus core and its input drivers
(keyboard, mouse, joystick/controller), addressing build failures, race
conditions, and coding style issues:

- fixes a build failure in vmu-flash.c due to missing include
- fixes keyboard press detection logic (eliminating a 1-poll delay and
  redundant press events)
- corrects D-pad axis limits and optimizes event reporting using
  branchless calculations
- implements open() and close() in maple_keyb so all Maple input drivers
  only poll when actively open
- introduces callback_mutex in the Maple bus core to avoid potential UAF
  when stopping/unbinding the drivers
- removes the unused driver field from struct maple_device (write-only
  since 2008) and eliminates the redundant maple_unsupported_device dummy
  driver
- implements standard bus-level probe() and remove() methods for the
  Maple bus
- converts all three Maple input drivers to use managed resources, and
  fixes style issues reported by checkpatch.

This compiles but has not been tested on real hardware.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (26):
      sh: maple: include linux/device.h in linux/maple.h
      Input: maple_keyb - fix key press detection
      Input: maplecontrol - only enable present axes
      Input: maplemouse - stop polling and clear callback on close
      Input: maplecontrol - stop polling and clear callback on close
      Input: maplecontrol - simplify maple_device retrieval in open/close
      Input: maple_keyb - implement open and close methods
      Input: maplemouse - remove redundant drvdata resetting
      Input: maple_keyb - remove redundant drvdata resetting
      Input: maplecontrol - remove redundant drvdata resetting
      Input: maplemouse - remove unused mdev->driver assignment
      Input: maplecontrol - remove unused mdev->driver assignment
      Input: maple_keyb - remove unused mdev->driver assignment
      mtd: maps: vmu-flash: remove unused mdev->driver assignment
      sh: maple: remove not needed maple_unsupported_device driver
      sh: maple: remove unused driver field from struct maple_device
      sh: maple: implement bus-level probe/remove
      sh: maple: introduce callback_mutex in maple_device
      Input: maple_keyb - remove redundant mutex and remove method
      Input: maple_keyb - convert to devm
      Input: maplemouse - convert to devm
      Input: maplecontrol - convert to devm
      Input: maple_keyb - fix style issues
      Input: maplemouse - fix style issues
      Input: maplecontrol - fix style issues
      Input: maple_keyb - remove redundant 'new' buffer from struct dc_kbd

 drivers/input/joystick/maplecontrol.c |  98 +++++++++------------------
 drivers/input/keyboard/maple_keyb.c   | 124 +++++++++++++---------------------
 drivers/input/mouse/maplemouse.c      |  55 ++++-----------
 drivers/mtd/maps/vmu-flash.c          |  15 ++--
 drivers/sh/maple/maple.c              |  61 ++++++++++-------
 include/linux/maple.h                 |   8 ++-
 6 files changed, 140 insertions(+), 221 deletions(-)
---
base-commit: 2b763db0c2763d6bf73d7d3e69665222d1f377cf
change-id: 20260628-b4-maple-cleanup-884682ae108b

Thanks.

-- 
Dmitry

