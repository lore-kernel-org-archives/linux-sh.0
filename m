From: Kees Cook <keescook@chromium.org>
Date: Thu, 19 Dec 2013 19:35:57 +0000
Subject: [PATCH v5] provide -fstack-protector-strong build option
Message-Id: <1387481759-14535-1-git-send-email-keescook@chromium.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This reorganizes the build options for CONFIG_CC_STACKPROTECTOR so that
the new CONFIG_CC_STACKPROTECTOR_STRONG can be used when building with
a compiler that supports it.

Now with more help text.

-Kees

