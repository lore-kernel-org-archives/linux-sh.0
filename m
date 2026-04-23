Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EE238C3B
	for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962636; cv=none; b=AHphc0eS8MgjJn0bZHvoJtbJgeg2Uvh54hssqJIr756gwsF/4eQiltgYRzl2ZI2bCOe9KHfXkR9TQePRBdKjhstEM0l2GNrsoKzN58UxZR861K5acaW9/pB57e3A2k6pLrfzeZ38PsmZBgALHONARTFu2GZxF6Idgz/hXgfePgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962636; c=relaxed/simple;
	bh=rWK7gYRonbA/vOIcJU4jyKDAg3uTj6ZugZ4suClIqzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUAqjfBvNfdkOC7wFt1VHmCjWh/YWctEUyf9+mkv9W/aulYtRM6QLbjwQagr/AFnJLTSXct39q1v8dk4g9cvzyl4xrc2CTHZEApHtYidfNuknQXBeT0i/TkHdLVwbd7zQP4kqLLaK99Ho77ONMNi24vlEkovWKLsjeZ5IEpW0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RN6yQDPe; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RN6yQDPe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776962633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsG9IbhYvFSxymW4D9AKdvbgzqVMvbocy/PP66BixBQ=;
	b=RN6yQDPeb7Yah02tkA95km1LvAM4iKeIKbMTuhFzIRr40TcvhMw2cb8r2vcZdhwwqauk/T
	utRt4w1hS+l7yt47ddaohrn4t8cMD9Q1mameTJmP3QKcQTO5MT66cN1+HVPxzDdbZT2NVa
	X9yEEdRcar7rgHXWi6KKQm6TQNr2F4A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] gdrom: remove unused but set variable in gdrom_get_last_session
Date: Thu, 23 Apr 2026 18:43:24 +0200
Message-ID: <20260423164324.273220-4-thorsten.blum@linux.dev>
In-Reply-To: <20260423164324.273220-3-thorsten.blum@linux.dev>
References: <20260423164324.273220-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=thorsten.blum@linux.dev; h=from:subject; bh=rWK7gYRonbA/vOIcJU4jyKDAg3uTj6ZugZ4suClIqzs=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvfIz5+1fZVjUZzG+aUawyvWVvq3Rob6ZEc8Tdu0tPi n+oXB7aUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABMRnsbwi8lEdmbnkRV5yWo+ z5Y/WXPNTa3QwfR4tp9nwfeCG3pzZjMy3OhhqLqUI/LDymJtXYGkVWKTwe+tEo/CFsl+cI21+8j GDAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove 'lentry' to avoid a "variable set but not used" warning triggered
by -Wunused-but-set-variable.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
No changes in patch 2/2.
---
 drivers/cdrom/gdrom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 4ba4dd06cbf4..5cc830501fdf 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -312,7 +312,7 @@ static int get_entry_track(int track)
 static int gdrom_get_last_session(struct cdrom_device_info *cd_info,
 	struct cdrom_multisession *ms_info)
 {
-	int fentry, lentry, track, data, err;
+	int fentry, track, data, err;
 
 	if (!gd.toc)
 		return -ENOMEM;
@@ -329,7 +329,6 @@ static int gdrom_get_last_session(struct cdrom_device_info *cd_info,
 	}
 
 	fentry = get_entry_track(gd.toc->first);
-	lentry = get_entry_track(gd.toc->last);
 	/* Find the first data track */
 	track = get_entry_track(gd.toc->last);
 	do {
