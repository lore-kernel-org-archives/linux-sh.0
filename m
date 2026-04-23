Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189B33ADAF
	for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956033; cv=none; b=spo4T3pdR3gw+bjoc66ydoc9CzLciRNPVlg2st4r1X0aqTsLWPzwbr42gPSvDNIHaO/M3hfXZsMrMvdNXxhtqtgpwGk/XJQcztZ/X0oWQVHf8VFUcmJxkiLQEx/lWQywtOd9qMOXig0b/oYN5lhrawRj4DIYSKIClt11aIZIGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956033; c=relaxed/simple;
	bh=bJLomxoqpLHwVkOrm7MK12cJ45kTW+a/BoqPIaAOM4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJASLzdysNCGm0SxODzbtsAQCK9qtAye8jO3Irt8zgaJi/0EEb2WQXMtL+FvcLKvqxTYmGWfK0aKNzkhyxdOnJpSaXRVVTAz1fubKpu+zKNeopkPPEe4Bui4fYcl7+QLra5WvZQwSOtUrf8ma83Ka5yCFF3GNFCqQVMtD2u6Bho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eCBePoH5; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eCBePoH5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776956029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hh5qAT6cYpMD745bE7Q9j8qsR/TWPVAdUSHwZPtMO7c=;
	b=eCBePoH5GyF4Frhu1aukbxcLOfqQb3co5TeIlCkoszF9AWvDKNY2qRy0Y3QIdfne4wKHJr
	69NzKmMQvyWG2PpILbZ4j+Bq6DYEIm3FK8raJut4f9k7iEkrj3z5vSYDLtZz9Brm+dS2cB
	Gi+/pUysRDaB5V7uah97L3f7U6MzgZU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] gdrom: remove unused but set variable in gdrom_get_last_session
Date: Thu, 23 Apr 2026 16:53:02 +0200
Message-ID: <20260423145301.245374-5-thorsten.blum@linux.dev>
In-Reply-To: <20260423145301.245374-4-thorsten.blum@linux.dev>
References: <20260423145301.245374-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=thorsten.blum@linux.dev; h=from:subject; bh=bJLomxoqpLHwVkOrm7MK12cJ45kTW+a/BoqPIaAOM4M=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvjEKzap0+X+TR4OzKU534a9n+xscXzzIYfyl5dvh7v 43Go7dLO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAivUwM/9Q5P86YtOrpvz+L rPtkPuu+uen269YVnwNW8lZLskN3f2lm+KfBPrViXZ7dNtFLUTF3dkqdOTm5mfvQt6/3Z03+aKU 9dRsvAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove 'lentry' to avoid a "variable set but not used" warning triggered
by -Wunused-but-set-variable.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
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
