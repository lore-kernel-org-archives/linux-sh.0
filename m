Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A0F2E62A4;
	Fri, 17 Apr 2026 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421934; cv=none; b=qT7iC1Ms364roHZVao5MxdzswqFNY4FlCbKhZM4krxlp1N0rlf+RDQRJBMxu3YAr/AS8sb43EpZBNdthAMono7E8BO7eqAUpuaysuSUu8hV9h5AMqCOv1PjD0OtVmI6VPKLoCxsmN8fxIpQFPatzwobLE2WtJakM7u3pJ80/jH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421934; c=relaxed/simple;
	bh=O2rQFEuCdd4mpX17nfkzJvBNUfAWpCVhhkV6d0E3jKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CwQvE/w1Ud/k0EhoihCfbdRZ3fn/NhXF9/u/Mr8hQvf0AwDyzKk5K4+8nvhc6P9+KMy5ETFNQGg590fb6Vo09IJJ1Huk0AfXD9QYBzFJsGhSiFadN/UItUHd1oik0jtkw97NXLX/hKF/ScfgbCz5S/1hjuGgZ83XASXSOfRr7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qL27aUJy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qL27aUJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C182EC19425;
	Fri, 17 Apr 2026 10:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776421933;
	bh=O2rQFEuCdd4mpX17nfkzJvBNUfAWpCVhhkV6d0E3jKE=;
	h=From:To:Cc:Subject:Date:From;
	b=qL27aUJyEG3ahNIuULODAHJ02GuEitaeoig4mFUZKZdoeFx7+f0xumgt5sasoiw3O
	 1R2Hyht2Y30NPYcUzaho2tqODoYe/1l2PDYgCgthFGnqTzkSJRmQp0/UtWvvCKgjSD
	 RlWplL6DdfCRPCOGrDWQw9l8GLJhfc8coGV5/Zb1zWmiXC6ySDtYLHW+yE2MFd1SPo
	 MIKSJJCXzbA0ZtDNCBa5Qn6YYaNwjnwHM7T/KbZXyYzdVtPAvErdS8ZLZpxWdXUdS5
	 3oN7KROSqcy5/UmDtlm/81zk+eQJ5ZSf0dpsdNZGZySflJ8eUZM8zOfITIjKR2+l/2
	 hR3+deoH+U6Gg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mike Rapoport <rppt@kernel.org>,
	Rich Felker <dalias@libc.org>,
	=?UTF-8?q?Thomas=20Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: [PATCH] sh: fix fallout from ZERO_PAGE consolidation
Date: Fri, 17 Apr 2026 13:32:07 +0300
Message-ID: <20260417103208.1217010-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Consolidation of empty_zero_page declarations broke boot on sh.

sh stores its initial boot parameters in a page reserved in
arch/sh/kernel/head_32.S. Before commit 6215d9f4470f ("arch, mm:
consolidate empty_zero_page") this page was referenced in C code as an
array and after that commit it is referenced as a pointer.

This causes wrong code generation and boot hang.

Declare boot_params_page as an array to fix the issue.

Reported-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Fixes: 6215d9f4470f ("arch, mm: consolidate empty_zero_page")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/include/asm/setup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
index 63c9efc06348..8488f76b48b4 100644
--- a/arch/sh/include/asm/setup.h
+++ b/arch/sh/include/asm/setup.h
@@ -7,7 +7,7 @@
 /*
  * This is set up by the setup-routine at boot-time
  */
-extern unsigned char *boot_params_page;
+extern unsigned char boot_params_page[];
 #define PARAM boot_params_page
 
 #define MOUNT_ROOT_RDONLY (*(unsigned long *) (PARAM+0x000))

base-commit: 43cfbdda5af60ffc6272a7b8c5c37d1d0a181ca9
-- 
2.53.0

