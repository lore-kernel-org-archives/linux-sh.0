From: Kees Cook <keescook@chromium.org>
Date: Tue, 17 Dec 2013 22:43:12 +0000
Subject: [PATCH v3] provide -fstack-protector-strong build option
Message-Id: <1387320194-24185-1-git-send-email-keescook@chromium.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This reorganizes the build options for CONFIG_CC_STACKPROTECTOR so that
the new CONFIG_CC_STACKPROTECTOR_STRONG can be used when building with
a compiler that supports it.

-Kees

