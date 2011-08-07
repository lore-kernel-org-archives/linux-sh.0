From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 07 Aug 2011 22:31:25 +0000
Subject: [Regression] Boot crash caused by commit 1eb19a12bd2214cdcad5273d472b062a4ba97fa1
Message-Id: <201108080031.26165.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mandeep Singh Baines <msb@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-sh@vger.kernel.org

Hi,

Unfortuately, your commit 1eb19a12bd2214cdcad5273d472b062a4ba97fa1
(lib/sha1: use the git implementation of SHA-1) causes one of my test
systems, which is an ARM shmobile Mackerel development boards, to crash
during boot (due to referencing invalid addresses AFAICS).

Please fix or revert.

Thanks,
Rafael
